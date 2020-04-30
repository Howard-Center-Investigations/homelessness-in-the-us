#Analysis for St John Court data 
#Riin Aljas 
#aljasriin@gmail.com

#TO DO----



#load libraries 
library(purrr)
library(magrittr)
library(tidyverse)
library(readr)
library(fs)
library(lubridate)
library(janitor)
library(chron)


###READ IN DATA ----
#read in files by court, as we dont have so many different ones its ok to do it manually, as directories differ and we read data in as it came 
#during different times 
#data source: https://apps.stjohnsclerk.com/Benchmark/CaseLists.aspx (log in needed), scraped using Selenium, Python script for that available in repo


mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*animal*")
read_csv(myfiles[1])
animal <- myfiles %>% 
  map_dfr(read_csv) %>%
  clean_names()


mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*boating*")
read_csv(myfiles[1])
boating <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()


mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*code_en*")
read_csv(myfiles[1])
code_en <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()

mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*county_ord*")
read_csv(myfiles[1])
county_ord <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()

mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*fish*")
read_csv(myfiles[1])
fish <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()

mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*municip_ord*")
read_csv(myfiles[1])
municip_ord <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()

mydir <- "data/source"
myfiles <- dir_ls(mydir, regexp = "*non_crim*")
read_csv(myfiles[1])
non_crim <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()



mydir <- "data/source/months"
myfiles <- dir_ls(mydir, regexp = "*misdem*")
read_csv(myfiles[1])
misdem <- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()



mydir <- "data/source/months"
myfiles <- dir_ls(mydir, regexp = "*crim*")
read_csv(myfiles[1])
crim_traf<- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()



mydir <- "data/source/civil_traffic"
myfiles <- dir_ls(mydir, regexp = "*civil*")
read_csv(myfiles[1])
civil_traf<- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()


mydir <- "data/source/parking"
myfiles <- dir_ls(mydir)
read_csv(myfiles[1])
parking<- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()


mydir <- "data/source/felony"
myfiles <- dir_ls(mydir)
read_csv(myfiles[1])
felony<- myfiles %>% 
  map_dfr(read_csv, 
          col_types = cols(.default =  col_character(), 
                           `Zip Code` = col_integer())) %>%
  clean_names()


#create master data 

masterdata <- bind_rows(mutate_all(animal, as.character), 
                        mutate_all(boating, as.character), 
                        mutate_all(code_en, as.character), 
                        mutate_all(county_ord, as.character),
                        mutate_all(crim_traf, as.character), 
                        mutate_all(felony, as.character), 
                        mutate_all(fish, as.character), 
                        mutate_all(misdem, as.character), 
                        mutate_all(municip_ord, as.character),
                        mutate_all(non_crim, as.character), 
                        mutate_all(parking, as.character), 
                        mutate_all(civil_traf, as.character))

masterdata <- masterdata %>% 
  mutate_all(tolower)

masterdata <- mutate_at(masterdata, vars(matches("date")), funs(mdy)) %>% 
  mutate(full_name = paste0(first_name, " ", middle_name, " ", last_name))

masterdata <- masterdata %>% 
  mutate(offense_year = year(offense_date), 
         case_year = year(case_open_date))

masterdata <- unique(masterdata)


saveRDS(masterdata, "masterdata.rds")

###CHECK THE DATA ----

ourdata = list(animal, boating, civil_traf, code_en, county_ord, crim_traf, 
            felony, fish, misdem, municip_ord, non_crim, parking) #create a list of all our dataframes
mynames = c("animal", "boating", "civil_traf", "code_en", "county_ord", "crim_traf",
            "felony", "fish", "misdem", "municip_ord", "non_crim", "parking")

 dates <- seq(as.Date("2015/01/01"), by = "day", length.out = 1826) #create a df with all the dates in our five year period and flag weekends
 weekdays <- (is.weekend(dates))
 dates <- as.data.frame(dates)
 dates <- as.data.frame(weekdays) %>%
  bind_cols(dates) %>%
  rename(newdate = dates)

##antijoin our date with all dates to see which dates are missing
  results <- lapply(ourdata, function(df) {

   dates <- dates %>%
     mutate(court = as.character(df[1,4]))
   df <- df %>%
     mutate(newdate = mdy(df$case_open_date))
   df <- df %>%
     group_by(newdate, ) %>%
     count()
   missing_dates <- anti_join(dates, df)
 }
)
#
# #Q: look into whether there's any anomaly when it comes to missing weekdays vs weekend --
# #A : there's not
 lookdata <- lapply(results, function(df) {

    df %>%
     group_by(df$weekdays, df$court) %>%
     count()
  }
  )
 

# #Q: look into every dataframe in the 'results' list and group by year and date to notice anomalies
# #Q: look for 'more than 500 records errors
#
# #A: there's no anomalies, besides the fact that civil traffic has files missing, will run script again, now there are four extra files
# #A: no court stands out specifically when it comes to missing weekdays vs missing weekenddays
# #A: double checked manually every month that had all dates missing, no mistakes
# #A: only felony has one case of more than 500 records, hence we have one day missing
#

#
#  felony %>%
#     filter(str_detect(column1, pattern = "more than 500 records")) %>%
 #    nrow()
#
# results[[12]] %>% group_by(year(newdate), month(newdate), court) %>% count() %>% View()
#
#
# #Q: create a random sample of 10% of all missing dates across df-s and run spotcheks on st john page
# # manually
# #A: no mistakes, all correct
#
# randomchecks <- lapply(results, function(df) {
#   sample_n(df,  nrow(df)*0.01)
# }
# )
#
# randomchecks[[12]] %>% View()
#
