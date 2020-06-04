#Script for reading in Pinellas, FL court data
#Riin Aljas, aljasriin@gmail.com

library(tidyverse)
library(lubridate)
library(readxl)
library(readr)
library(data.table)
library(reshape2)
library(purrr)
library(fs)
library(janitor)
library(stringr)
library(rvest)
library(itertools)

options(scipen = 999)
#readata in based on year 

folder_paths <- dir_ls("data", regexp = "20")

file_paths <- lapply(folder_paths, dir_ls) %>% 
  unlist() %>% 
  as.data.frame()
file_paths <- as.character(file_paths$.)
col_spec = cols(.default= col_character())

x <- file_paths[1]
full_data <- map_dfr(file_paths, ~ read_delim(.x, "|",
                                                escape_double = FALSE,
                                                col_names = FALSE,
                                              col_types = col_spec))

#clean data----
#get names from data dictionary 

dictionary <- read_excel("data/Data Export Data Map.xlsx")

dictionary$`Defendant Details` <- dictionary$`Defendant Details` %>% 
  str_remove_all('Defendant|(Case Count Charge)')

dictionary <- dictionary %>% 
  filter(!str_detect(dictionary$`Defendant Details`, "Details|Description"))

newnames <- dictionary$`Defendant Details` %>% 
  as.data.frame()

newnames <- newnames[-c(22), ]
#data lines up with dictionary, but is off by one column, except for one person
#take him out 

exception <- full_data %>% 
  filter(X5 == "STANEK, STEVEN L")
#check to be sure, he was the only one

unique(full_data$X11) %>% View()
#there's only two cases with problems but they have missing data anyway 

full_data <- anti_join(full_data, exception) %>% select(-X48)

#now we can add the dictionary names 
colnames(full_data) <- newnames 
full_data <- full_data %>% clean_names()

#check data-----

#do we have columns that indi
#cate that all data is not in

missing <- map(full_data, (~sum(is.na(.))))

missing <- missing %>% 
  unlist() %>% 
  as.data.frame() %>% 
  mutate(prct = `.`/nrow(full_data)*100) %>% 
  mutate(datanames <- names(full_data))

#the columns we care about the most are ok 
#save for analysis script 
saveRDS(full_data, "data/full_data.rds")

##FILTER OUT HOMELESS 


#do we have anything we can use as an identifier?
  map(full_data, (~n_distinct(.)))
#no. 
#the most unique thing is casenr though, look into it 
  
full_data %>% 
  group_by(case_number) %>% 
  count() %>% filter(n>1)

#one case can have several offense dates 


#how many unique people we have?
dem <- full_data %>% 
  group_by(first_name, 
           middle_name, 
           last_name, 
           alias_name_1,
           sex, race, date_of_birth) %>% 
  count()

#too many to clean 

full_data <- unique(full_data)


  


fulldata %>% 
  group_by(sex) %>% 
  count() 

#just one faulty

fulldata %>% 
  filter(sex == "SERVED TIME") %>% View()

sex_na <- fulldata %>% 
  filter(is.na(sex)) 

sex_na$date_of_birth <- mdy(sex_na$date_of_birth)
sex_na$offense_date <- mdy(sex_na$offense_date)
sex_na %>% group_by(year(offense_date)) %>% count()
#2016 and 2015 are overrepresented 

sex_na %>% 
  group_by(disp) %>% 
  count() %>% View()
#some of them are companies, we need to filter them out rightaway 

###STANDARDIZE ADDRESSES----

full_data <- full_data %>% 
  mutate(address = str_remove_all(person_address_record_current_known_address, "[.]"))
full_data <- full_data %>%
  mutate(city_add = paste0(address, " ", city)) %>% 
  mutate(full_name = paste(first_name, middle_name, last_name))


#read in usps abbreviations
usps <- read_html("https://pe.usps.com/text/pub28/28apc_002.htm") %>% 
  html_nodes('#ep533076') %>% 
  html_table(fill = TRUE) %>% 
  as.data.frame() %>% 
  rename(full = 1, 
         short = 2)


testpattern <- paste0(" ", usps$short, " ")
mylist2 <- full_data$city_add %>% unique() %>% toString()

##which abbreviations we need to use to replace

mywords <- lapply(testpattern, function(x){
  myresult <- paste0(x, str_detect(mylist2, x))
} )

pinellas_abbreviations <- mywords %>% 
  unlist() %>% 
  as.data.frame() %>% 
  separate(1, into = c("v1", "v2", "v3"), sep = " ") %>% 
  filter(v3 == TRUE) %>% 
  select(short = 2) %>% 
  left_join(usps, by = "short")

mylist <- full_data$city_add
myaddresses <- as.data.frame(matrix(ncol = 0, nrow = 0))  

list_addresses <- lapply(mylist, function(x){
  
  loopaddress <- x %>% as.data.frame()
  for (word in as.list(izip(a = pinellas_abbreviations$full, b = pinellas_abbreviations$short))){
    mypattern = paste0(" ", word$b, " ")
    mypattern2 = paste0(" ", word$a, " ")
    print(Sys.time())
    if (str_detect(loopaddress[[1]], mypattern)==TRUE) {
      
      loopaddress <- str_replace_all(loopaddress[[1]], mypattern, mypattern2)%>% 
        str_replace_all("APOINT", "APT") %>% 
        str_replace_all("\\dSTREET", "\\dST") %>%
        str_replace_all(c("STREET PETERSBURG" = "ST PETERSBURG")) %>%
        str_replace_all(c(" N " = " NORTH ", " E " = " EAST ", " S " = " SOUTH ", " W " = " WEST ", " NE | NORTHEAST "= " NORTH EAST ", " SE | SOUTHEAST " = " SOUTH EAST ", " NW | NORTHWEST " = " NORTH WEST ", " SW | SOUTHWEST " = " SOUTH WEST " )) %>% 
        as.data.frame()
      
      
      next
    }
    loopaddress <- loopaddress[[1]] 
  }
  loopaddress <- as.data.frame(loopaddress) %>% mutate(original = x)
  myaddresses <- bind_rows(myaddresses, loopaddress) 

})
newaddresses <- bind_rows(list_addresses, .id = NULL)
newaddresses <- newaddresses %>% rename(city_add = original)
saveRDS(newaddresses, "newaddresses.rds")
full_data <- full_data %>% 
  left_join(newaddresses, by = "city_add")
saveRDS(full_data, "full_data.rds")
