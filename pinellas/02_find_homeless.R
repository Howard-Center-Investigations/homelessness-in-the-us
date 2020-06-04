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
library(refinr)
library(itertools)
library(rvest)

full_data <- readRDS("data/full_data.rds")
  

####FIND HOMELESS-----

shelters <-  read_excel("data/shelters.xlsx") 
colnames(shelters) <- c("shelter", "city", "orig_address")

shelters$city <- toupper(shelters$city)
shelters$orig_address <- toupper(shelters$orig_address)

addresses <- full_data %>% 
  group_by(first_name, last_name, date_of_birth, case_number, 
           loopaddress, address_line_number_1, 
           address_line_number_2) %>% 
  count() %>% 
  group_by(loopaddress,
           address_line_number_1, 
           address_line_number_2) %>% 
  count()

addresses <- addresses %>% 
  rename(address = 1)
#delete periods to make it easier to join with shelters
addresses$address <- str_remove_all(addresses$address, "[.]")
addresses$address_line_number_1 <- str_remove_all(addresses$address_line_number_1, "[.]")
addresses$address_line_number_2 <- str_remove_all(addresses$address_line_number_2, "[.]")
shelters$orig_address <- str_remove_all(shelters$orig_address, "[.]")
shelters$city <- str_remove_all(shelters$city, "[.]")
shelters <- shelters %>% 
  mutate(city_add = paste(orig_address, city)) 

#standardize shelter addresses----

#read in usps abbreviations
usps <- read_html("https://pe.usps.com/text/pub28/28apc_002.htm") %>% 
  html_nodes('#ep533076') %>% 
  html_table(fill = TRUE) %>% 
  as.data.frame() %>% 
  rename(full = 1, 
         short = 2)


testpattern <- paste0(" ", usps$short, " ")
mylist2 <- shelters$city_add %>% unique() %>% toString()

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

mylist <- shelters$city_add
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
new_shelter_address <- bind_rows(list_addresses, .id = NULL) %>% 
  select(-3) %>% rename(city_add = original)
shelters <- shelters %>% 
  left_join(new_shelter_address)
#endstreetstandard-----
shelters <- shelters %>% rename(address = loopaddress)

addresses <- left_join(addresses, shelters, by = c("address"))

#separate shelters

addresses <- addresses %>% 
  select(address, shelter, everything())
#add a shelter tag as some of addresses have more than one shelter

addresses <- addresses %>% 
  mutate(is_shelter = shelter)
addresses$is_shelter <- if_else(is.na(addresses$shelter), "no", "yes")

addresses <- addresses[order(-addresses$n),] %>% 
  select(-shelter) 

addresses <- unique(addresses)

#use unique, we don't care about the NA-s now nor the same address with several places and group again later just in case

#look at spellings of most common terms 
#no spelling errors on transient, added versions of other in later code

#create new address column with taking out columns 

#first take out universal terms 

homeless <- full_data %>% 
  filter(str_detect(full_data$loopaddress, "TRANSIENT|TRANIENT|GENERALDELIVERY|DELVERY|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")|
           str_detect(full_data$address_line_number_1,  "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")|
         str_detect(full_data$address_line_number_2, "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")) %>% 
  unique()

#add shelters 

#turns out we still need city and address 

shelters_add <- as.data.frame(matrix(ncol=0, nrow=0))
for (h in as.list(izip(a=shelters$address, b=shelters$city))) {
  print(c(h$a, h$b))
  
  temp <- full_data %>% filter((str_detect(full_data$loopaddress, h$a)|
                                  str_detect(full_data$address, h$a)|
                               str_detect(full_data$address_line_number_1, h$a)|
                               str_detect( full_data$address_line_number_2, h$a)),
                               full_data$city == h$b)

  shelters_add <- bind_rows(shelters_add, temp) %>% unique()}

homeless <- bind_rows(homeless, shelters_add) %>% unique()

#there are homeless names in the cities as well sometimes 

homelesscity <- full_data %>% 
  filter(str_detect(full_data$city, "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|DELVERY|HOMELES|ANYWHERE"))

homeless <- bind_rows(homeless, homelesscity) %>% unique()

##take out prisons, jails etc 

jails <- addresses %>% ungroup() %>% 
  filter(str_detect(addresses$address, "CORRECTIONAL|HAMILTON CI|CFRC|CENTRAL FLORIDA RECEPTION CENTER|7000 H C KELLEY|CFRC|RECEPTION AND MEDICAL CENTER|HOLMES CI|DC #R67468|3142 THOMAS DRIVE")|
            str_detect(addresses$address_line_number_2, "CORRECTIONAL|HAMILTON CI|CFRC|CENTRAL FLORIDA RECEPTION CENTER|7000 H C KELLEY|CFRC|RECEPTION AND MEDICAL CENTER|HOLMES CI|DC #R67468|3142 THOMAS DRIVE")|
           str_detect(addresses$address_line_number_1, "CORRECTIONAL|HAMILTON CI|CFRC|CENTRAL FLORIDA RECEPTION CENTER|7000 H C KELLEY|CFRC|RECEPTION AND MEDICAL CENTER|HOLMES CI|DC #R67468|3142 THOMAS DRIVE"))

no_jails_add <- anti_join(addresses, jails) %>% rename(loopaddress = address)

#take out homeless by terms, as we don't care about the city here

no_jails_add <- anti_join(no_jails_add, homeless, by = "loopaddress")

top175addresses <- head(no_jails_add, 175)

#went through all addresses manually, take out the names and addresses who are not homeless


top175addresses <- top175addresses %>% 
  filter(!loopaddress %in% c("1443 KINGS HIGHWAY CLEARWATER",
                    "2906 3RD AVENUE SOUTH ST PETERSBURG",
                    "3928 8TH AVENUE SOUTH ST PETERSBURG",
                    #poSToffice
                    "3135 1ST AVENUE NORTH ST PETERSBURG",
                    "5885 66TH STREET NORTH ST PETERSBURG",
                    "11601 4TH STREET NORTH ST PETERSBURG",
                    "1550 OAK VILLAGE DRIVE LARGO",
                    "650 60TH AVENUENUE STREET ST PETERSBURG",
                    "11797 104TH STREET NORTH LARGO",
                    "2690 DREW STREET CLEARWATER",
                    "2460 17TH AVENUE SOUTH ST PETERSBURG",
                    "2225 NURSERY ROAD CLEARWATER",
                    "1243 PALMETTO STREET CLEARWATER",
                    "2226 23RD STREET SOUTH ST PETERSBURG",
                    "3124 21ST AVENUE SOUTH ST PETERSBURG",
                    "3604 6TH AVENUE SOUTH ST PETERSBURG",
                    "1010 22ND AVENUE SOUTH ST PETERSBURG",
                    "1011 SEMINOLE STREET CLEARWATER",
                    "207 PENNSYLVANIA AVENUE CLEARWATER",
                    "2349 CENTRAL AVENUE ST PETERSBURG",
                    "3172 71ST AVENUE NORTH ST PETERSBURG",
                    "6300 60TH STREET NORTH PINELLAS PARK",
                    "7288 122ND WAY NORTH SEMINOLE",
                    "8400 49TH STREET NORTH PINELLAS PARK",
                    "12717 133RD AVENUE LARGO",
                    "1411 PRESCOTT STREET SOUTH ST PETERSBURG",
                    "3035 66TH AVENUE NORTH ST PETERSBURG",
                    "555 31ST STREET SOUTH ST PETERSBURG",
                    "10596 GANDY BOULEVARD ST PETERSBURG",
                    "1112 CARLTON STREET CLEARWATER",
                    "2034 SEMINOLE BOULEVARD SOUTH ST PETERSBURG",
                    "1201 SEMINOLE BOULEVARD LARGO",
                    "1490 FAIRMONT STREET CLEARWATER",
                    "2350 CYPRESS POND ROAD PALM HARBOR",
                    "2365 5TH AVENUE NORTH ST PETERSBURG",
                    "240 13TH STREET NORTH ST PETERSBURG",
                    "3901 46TH AVENUE NORTH ST PETERSBURG",
                    "1006 14TH AVENUE NORTH WEST LARGO",
                    "2065 NORTH HIGHLAND AVENUE CLEARWATER",
                    "210 ANDREA DRIVE LARGO",
                    "2230 NURSERY ROAD CLEARWATER",
                    "2501 59TH STREET SOUTH GULFPORT",
                    "2675 ALDERMAN ROAD PALM HARBOR",
                    "1375 TUSCOLA STREET CLEARWATER",
                    "1847 21ST STREET SOUTH ST PETERSBURG",
                    "4200 54TH AVENUE SOUTH ST PETERSBURG",
                    "1913 COLES ROAD CLEARWATER",
                    "3962 12TH AVENUE SOUTH ST PETERSBURG",
                    "4730 11TH AVENUE SOUTH ST PETERSBURG",
                    "1540 SOUTH MYRTLE AVENUE CLEARWATER",
                    "4050 11TH AVENUE SOUTH ST PETERSBURG",
                    "7570 46TH AVENUE NORTH ST PETERSBURG",
                    "1216 CLAIRE DRIVE CLEARWATER",
                    "503 CLEVELAND STREET CLEARWATER",
                    "5107 54TH STREET WEST BRADENTON",
                    "1497 OAK VILLAGE DRIVE LARGO",
                    "2816 FULTON STREET SOUTH WEST LARGO", 
                    "1931 12TH STREET SOUTH ST PETERSBURG",
                    "4167 15TH AVENUE SOUTH ST PETERSBURG",
                    "3124 21ST AVENUE SO ST PETERSBURG",
                    "716 29TH AVENUE SOUTH ST PETERSBURG",
                    "519 15TH AVENUE SOUTH ST PETERSBURG",
                    "4673 18TH AVENUE SOUTH ST PETERSBURG",
                    "3022 47TH AVENUE SOUTH ST PETERSBURG",
                    "1745 25TH STREET SOUTH ST PETERSBURG",
                    "2861 THAXTON DRIVE PALM HARBOR",
                    "3080 34TH STREET NORTH ST PETERSBURG",
                    "4621 25TH AVENUE SOUTH ST PETERSBURG",
                    "4920 26TH LANE EAST       UNIT 302 BRADENTON",
                    "936 15TH AV ST PETERSBURG FL 33705",
                    "1050 3RD AVENUE NORTH    APT J1 ST PETERSBURG",
                    "11459 117TH AVENUE LARGO",
                    "1408 N WESTSHORE TAMPA",
                    "14400 49TH STREET NORTH CLEARWATER",
                    "1714 BENTLEY STREET CLEARWATER",
                    "6674 10TH AVENUE NORTH ST PETERSBURG",
                    "814 4TH AVENUE NORTH ST PETERSBURG",
                    "9091 52ND WAY NORTH PINELLAS PARK",
                    "790 27TH AVENUE SOUTH ST PETERSBURG",
                    "201 SOUTHERN MAGNOLIA SANFORD",
                    "4714 SOUTH WEST 42ND STREET OCALA",
                    "NA NA"))

top175addresses_large <- top175addresses %>% 
  select(loopaddress, 
                          address_line_number_1, 
                          address_line_number_2) %>% 
  left_join(full_data, by = "loopaddress")
#take out names 

namesout <- read_csv("data/namesout.csv") %>% unique()
namesout <- namesout %>% 
  mutate(full_name = paste(first_name, middle_name, last_name))
namesout_large <- left_join(namesout, full_data, by = "full_name")

top175addresses_large <- top175addresses_large %>% 
  ungroup () %>% 
  select(3:53,loopaddress) %>% 
  anti_join(namesout_large, by = "full_name")

#add to homeless 

top175addresses_large <- top175addresses_large %>% 
  ungroup()
homeless <- homeless %>% ungroup()
homeless <- bind_rows(homeless, top175addresses_large) %>% unique()

homelessnames <- homeless %>% 
  count(full_name, date_of_birth)
#who has the same name but no "homeless address"


more_addresses <- full_data %>% 
  filter(full_name %in% homelessnames$full_name) %>% 
  filter(date_of_birth %in% homelessnames$date_of_birth)

more_addresses <- more_addresses %>% 
  subset(!loopaddress %in% homeless$loopaddress)

more_addresses %>% 
  group_by(loopaddress) %>% 
  count() %>% 
  arrange(desc(n)) %>% 
  View()

homeless <- bind_rows(homeless, more_addresses) %>% unique()

homeless <- subset(homeless, !(full_name %in% namesout$full_name))
#TO DO 
#join with names from full data 
#make sure, you check with typos 
#then take the names out and then write the explanation into the code 

#what about NA-s
full_data %>% 
  filter(is.na(person_address_record_current_known_address)) %>% 
  group_by(disposition_statute, offense) %>% 
  count() %>% View()

#too many homeless charges to make anything of NA-s 

makesenseofnames <- full_data %>% 
  group_by(first_name, middle_name, last_name, suffix_name, alias_name_1, alias_name_2, alias_name_3) %>% 
  count() %>% 
  View()

demographics <- full_data %>% 
  group_by(first_name, middle_name, last_name, full_name, 
           date_of_birth, state_id, race, sex
           ) %>% 
  summarise(people = n())

n_distinct(full_data$full_name)

#this gives us 484456 people 

#how many people have same name bday but difference in sex or gender

more_2 <- demographics %>% group_by(full_name, date_of_birth, race, sex)%>% 
  count() %>% 
  group_by(full_name) %>% 
  count() %>% filter(n>1)

#look into them 

demographics %>% 
  filter(full_name %in% more_2$full_name, !is.na(middle_name)) %>% 
  group_by(full_name, race, sex, date_of_birth) %>% 
  count() %>% View()

#substantial amount of people have several or unknown bdays, two races, etc
#it's impossible to find any unique id, hence at first we take more people just in
#case by finding people by names 


dem_homeless <- final_homeless %>% 
  group_by(full_name, alias_name_1, alias_name_2, alias_name_3, 
           date_of_birth, race, sex) %>% 
  count()
homeless <- homeless %>% 
  filter(!full_name %in% c("A NA SOCIETYOFSTVINCENTDEPAUL",
                          "A NA ST PETERSBURG FREE CLINIC",
                          "NA NA SOLID ROCK CHRISTIAN CHURCH",
                          "NA NA ECKERD COLLEGE INC,A",
                          "NA NA BOLEY CENTERS INC,A",
                          "NA NA SALVATION ARMY"
                          ))

n_distinct(final_homeless$full_name)
#there's 7898 full_names vs 8042 in dem, who are they

morethanone <- dem_homeless %>% 
  group_by(full_name) %>% 
  count() %>% 
  filter(n>1)

morethanone <- dem_homeless %>% 
  filter(full_name %in% morethanone$full_name)
#for a lot of people it comes down to aliases which exist for one and not for another

wo_alias <- dem_homeless %>% 
  group_by(full_name, date_of_birth, race, sex) %>% 
  count() %>% 
  group_by(full_name) %>% 
  count() %>% 
  filter(n>2)
#there's 11 people like this 

dem_homeless %>% 
  filter(full_name %in% wo_alias$full_name) %>% 
  View()
#they all have different bdays, so to be on the safer 
#side we treat them like different people 

wo_alias <- dem_homeless %>% 
  group_by(full_name, date_of_birth, sex, race) %>% 
  count() %>% 
  group_by(full_name) %>% 
  count()
#if we remove aliases then there's the same nr as 
#in final_homeless. # looked trough the 242 people with aliases
#most aliases are like full_names 
#in future analysis we group always by birthday and full_name to see unique people

###create age column ----

final_homeless <- homeless
calc_age <- function(birthDate, refDate = Sys.Date()) {
  
  require(lubridate)
  
  period <- as.period(interval(birthDate, refDate),
                      unit = "year")
  
  period$year
  
} 
final_homeless$date_of_birth <- mdy(final_homeless$date_of_birth)
final_homeless <- final_homeless %>% 
  mutate(age = calc_age(date_of_birth))



final_homeless <- final_homeless %>% 
  mutate(offense_year = year(offense_date))



saveRDS(final_homeless, "data/final_homeless.rds")

    
#how many people we have who have 
#whether the name is in full name or in alias1 or alias 2
#1) name not in alias but in all aliases 

#number of manually checked people, not all ----

#people who have address marked in top 100 addresses, but are transient based on police reports, checked manually 
#1260 MICHIGAN BLVD, RYAN JOSEF HILDENBEUTEL
#7001 142ND AVE, LEHMAN, TABATHA ROSHELL 
#3001 FIRST AVE N, RICHARD ALLEN ALVAREZ
#620 CLW LARGO RD, DENISE LYNN RICHTER
#61 N CANAL ST, MITCHELL STEVEN DODGE 
#928 10TH AVE S, MATTHEW J BARBER 
#928 10TH AVE S, DEBRA ANN LEIBROCK 
#7600 78TH AVE N, JAMES RANDALL RANSOM
#2025 ROGERS ST, BRIAN      SHIELDS       
#2025 ROGERS ST, RICHARD    VANN           
#2025 ROGERS ST, TRACI      BUTTERWORTH   
#237 38TH AVE NE, IRA WILLIAM GUM
#1565 S PROSPECT AVE, TRACY NA BRILEY
#3191 VALEMOOR DR, JOHN JOSEPH CRICAN
#1315 1ST N, PAULO S DELEON
#401 34TH ST N, GARY       RUSSELL     CROSBY      
#932 9TH ST S, TIMOTHY ALLEN IRWIN
#540 2ND AVE S, DESIREE D LINCOLN 
#1116 HOWARD ST, CLEARWATER
#4050 5TH AVE N, ROBERT     DALE        EVANS 
#145 23RD AVE S, EDWARD FLOYD CASTRO
#165 CORAL DR, BRETT SCOTT PEARSON
#DENNIS LEE RITTER ,DENNIS LEE RITTER (not a typo, his name is his address)
#3125 28TH ST N ST PETERSBURG, ROBERT SHAWN OBRIANT
#3801 9TH AVE N ST PETERSBURG, DARRELL     KENNETH            ROLLE 
#115 EAST GRAPEFRUIT CIRCLE CLEARWATER,ROBERT ELMO SPARKS
#8285 53RD WAY N PINELLAS PARK, BENJAMIN   GENE        WHITE
#2442 40TH AVENUE NORTH ST PETERSBURG, ROBERT HARRY KLISUS
#2442 40TH AVENUE NORTH ST PETERSBURG, ROBERT M DONOHUE 
#2442 40TH AVENUE NORTH ST PETERSBURG, LINDA F MARIANO  
#4670 DOUGLAS DRIVE DADE CITY, RODNEY NA TOMLIN
#506 GROVE STREET NORTH ST PETERSBURG, MICHAEL LEE WILLHOITE
#PAUL J NELLIGAN 401 FAIRWOOD AVENUE        APT 54 CLEARWATER
#DOWNS, JOSHUA BRISTOL, 11064 NW DEMPSEY BARRON ROADR23791
