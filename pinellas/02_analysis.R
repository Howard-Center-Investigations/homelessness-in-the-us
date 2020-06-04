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
library(hunspell)

full_data <- readRDS("data/full_data.rds")

####FIND HOMELESS-----

shelters <-  read_excel("data/shelters.xlsx") 
colnames(shelters) <- c("shelter", "city", "address")

shelters$city <- toupper(shelters$city)
shelters$address <- toupper(shelters$address)

addresses <- full_data %>% 
  group_by(first_name, last_name, date_of_birth, case_number, 
           person_address_record_current_known_address, address_line_number_1, 
           address_line_number_2, city) %>% 
  count() %>% 
  group_by(person_address_record_current_known_address, address_line_number_1, 
           address_line_number_2, city) %>% 
  count()

addresses <- addresses %>% 
  rename(address = 1)
#delete periods to make it easier to join with shelters
addresses$address <- str_remove_all(addresses$address, "[.]")
addresses$city <- str_remove_all(addresses$city, "[.]")
addresses$address_line_number_1 <- str_remove_all(addresses$address_line_number_1, "[.]")
addresses$address_line_number_2 <- str_remove_all(addresses$address_line_number_2, "[.]")
shelters$address <- str_remove_all(shelters$address, "[.]")
shelters$city <- str_remove_all(shelters$city, "[.]")

addresses <- left_join(addresses, shelters, by = c("address", "city"))

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


full_data <- full_data %>% 
  mutate(city_add = paste0(address, " ", city))
  


addresses <- addresses %>% 
  mutate(city_add = paste0(address, " ", city))

#first take out universal terms 

homeless <- full_data %>% 
  filter(str_detect(full_data$address, "TRANSIENT|TRANIENT|GENERALDELIVERY|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")|
           str_detect(full_data$address_line_number_1,  "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")|
         str_detect(full_data$address_line_number_2, "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")) %>% 
  unique()

#add shelters 



shelters_add <- as.data.frame(matrix(ncol=0, nrow=0))
for (h in as.list(izip(a=shelters$address, b=shelters$city))) {
  print(c(h$a, h$b))
  
  temp <- full_data %>% filter((str_detect(full_data$address, h$a)|
                               str_detect(full_data$address_line_number_1, h$a)|
                               str_detect( full_data$address_line_number_2, h$a)),
                               full_data$city == h$b)

  shelters_add <- bind_rows(shelters_add, temp) %>% unique()}



homeless <- bind_rows(homeless, shelters_add) %>% unique()

#there are homeless names in the cities as well sometimes 

homelesscity <- full_data %>% 
  filter(str_detect(full_data$city, "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE"))

homeless <- bind_rows(homeless, homelesscity) %>% unique()

##take out prisons, jails etc 

jails <- addresses %>% ungroup() %>% 
  filter(str_detect(addresses$address, "CORRECTIONAL|HAMILTON CI|CFRC|CENTRAL FLORIDA RECEPTION CENTER|7000 H C KELLEY|CFRC|RECEPTION AND MEDICAL CENTER|HOLMES CI|DC #R67468|3142 THOMAS DRIVE")|
            str_detect(addresses$address_line_number_2, "CORRECTIONAL|HAMILTON CI|CFRC|CENTRAL FLORIDA RECEPTION CENTER|7000 H C KELLEY|CFRC|RECEPTION AND MEDICAL CENTER|HOLMES CI|DC #R67468|3142 THOMAS DRIVE")|
           str_detect(addresses$address_line_number_1, "CORRECTIONAL|HAMILTON CI|CFRC|CENTRAL FLORIDA RECEPTION CENTER|7000 H C KELLEY|CFRC|RECEPTION AND MEDICAL CENTER|HOLMES CI|DC #R67468|3142 THOMAS DRIVE"))

no_jails_add <- anti_join(addresses, jails)

#take out homeless by terms, as we don't care about the city here

no_jails_add <- anti_join(no_jails_add, homeless, by = "city_add")

top150addresses <- head(no_jails_add, 150)

#went through all addresses manually, take out the names and addresses who are not homeless


top150addresses <- top150addresses %>% 
  filter(!city_add %in% c("1443 KINGS HWY CLEARWATER",
                    "2906 3RD AVE S ST PETERSBURG",
                    "3928 8TH AVE S ST PETERSBURG",
                    #postoffice
                    "3135 1ST AVE N ST PETERSBURG",
                    "5885 66TH ST N ST PETERSBURG",
                    "11601 4TH ST N ST PETERSBURG",
                    "1550 OAK VILLAGE DR LARGO",
                    "650 60TH AVE S ST PETERSBURG",
                    "11797 104TH ST N LARGO",
                    "2460 17TH AVE S ST PETERSBURG",
                    "2225 NURSERY RD CLEARWATER",
                    "1243 PALMETTO ST CLEARWATER",
                    "2226 23RD ST S ST PETERSBURG",
                    "3124 21ST AVE SO ST PETERSBURG",
                    "3604 6TH AVE S ST PETERSBURG",
                    "1010 22ND AVE S ST PETERSBURG",
                    "1011 SEMINOLE ST CLEARWATER",
                    "207 PENNSYLVANIA AVE CLEARWATER",
                    "2349 CENTRAL AVE ST PETERSBURG",
                    "3172 71ST AVE N ST PETERSBURG",
                    "6300 60TH ST N PINELLAS PARK",
                    "7288 122ND WAY N SEMINOLE",
                    "8400 49TH ST N PINELLAS PARK",
                    "12717 133RD AVE LARGO",
                    "1411 PRESCOTT ST S ST PETERSBURG",
                    "3035 66TH AVE N ST PETERSBURG",
                    "555 31ST ST S ST PETERSBURG",
                    "10596 GANDY BLVD ST PETERSBURG",
                    "1112 CARLTON ST CLEARWATER",
                    "2034 SEMINOLE BLVD S ST PETERSBURG",
                    "1490 FAIRMONT ST CLEARWATER",
                    "2350 CYPRESS POND RD PALM HARBOR",
                    "2365 5TH AVE N ST PETERSBURG",
                    "240 13TH ST N ST PETERSBURG",
                    "3901 46TH AVE N ST PETERSBURG",
                    "1006 14TH AVE NW LARGO",
                    "2065 N HIGHLAND AVE CLEARWATER",
                    "210 ANDREA DR LARGO",
                    "2230 NURSERY RD CLEARWATER",
                    "2501 59TH ST S GULFPORT",
                    "2675 ALDERMAN RD PALM HARBOR",
                    "1375 TUSCOLA ST CLEARWATER",
                    "1847 21ST ST S ST PETERSBURG",
                    "1913 COLES RD CLEARWATER",
                    "3962 12TH AVE S ST PETERSBURG",
                    "4730 11TH AVE S ST PETERSBURG",
                    "1540 S MYRTLE AVE CLEARWATER",
                    "4050 11TH AVE S ST PETERSBURG",
                    "7570 46TH AVE N ST PETERSBURG",
                    "1216 CLAIRE DR CLEARWATER",
                    "503 CLEVELAND ST CLEARWATER",
                    "5107 54TH ST W BRADENTON",
                    "1497 OAK VILLAGE DR LARGO",
                    "2816 FULTON ST SW LARGO", 
                    "NA NA"))

#what about NA-s
full_data %>% 
  filter(is.na(person_address_record_current_known_address)) %>% 
  group_by(disposition_statute, offense) %>% 
  count() 

#too many homeless charges to make anything of NA-s 

#try to find all addresses which have similar address as top150addresses
#for that we create extra columns with ave, drives etc removed 

short_city_add <- as.data.frame(full_data$city_add %>% 
  str_replace_all(" AVE | AV ", "AVENUE") %>% 
    str_replace_all("STREET", "ST")) #because we have st petersburg


top150addresses <- top150addresses %>% 
  mutate(short_city_add = city_add %>% 
           str_remove_all(" AVE | AVENUE | BLVD | BOULEVARD| ST | STREET | N | RD | ROAD| S | SW | E | HWY | LN | LANE | HIGHWAY | WAY | ND") %>% 
           str_replace_all("PETERSBURG", " ST PETERSBURG")


x <- as.data.frame(full_data$city_add) %>% 
  unique()

makesenseofnames <- full_data %>% 
  group_by(first_name, middle_name, last_name, suffix_name, alias_name_1, alias_name_2, alias_name_3) %>% 
  count() %>% 
  View()

#create column for full name 

full_data <- full_data %>% 
  mutate(full_name = paste0(first_name, " ",
                             middle_name, " ", 
                             last_name))



demographics <- full_data %>% 
  group_by(first_name, middle_name, last_name, full_name, 
           date_of_birth, state_id, race, sex
           ) %>% 
  summarise(people = n())

#this gives us 484456 people 

n_distinct(full_data$full_name)
#477863
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

#whether the name is in full name or in alias1 or alias 2



#how many are whose first and last name is in alias1 and alias2 

full_data %>% 
  filter(full_name %in% alias_name_3) %>% 
  View()

#how many different people have a same bday and first and last name but different 
#middle name
full_data <- full_data %>% 
  mutate(first_last_name = paste(last_name, first_name),
         last_first_name = paste(first_name, last_name))


x <- subset(full_data, !(full_name %in% c(first_last_name,last_first_name)))
y <- anti_join(full_data, x)
#not an issue 
#take out names who were not homeless 

namesout <- read_excel("data/top150_names_out.xlsx")
top150addresses <- top150addresses %>% 
#   left_join(full_data, by = c("city_add", "address", "address_line_number_1", 
#                               "address_line_number_2", "city"))
# top150addresses <- top150addresses %>% 
#   anti_join(namesout, by = c("first_name", "middle_name", "last_name"))
  
           

#make sure to take in account all avenues and lanes and parkways etc 

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
#8285 53RD WAY N PINELLAS PARK BENJAMIN   GENE        WHITE