#Extract, transform load St Johns Data 
#Riin Aljas 
#aljasriin@gmail.com


#load libraries 
library(purrr)
library(magrittr)
library(tidyverse)
library(readr)
library(fs)
library(lubridate)
library(janitor)
library(chron)
library(refinr)
library(readxl)


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
     group_by(newdate) %>%
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

####FIND HOMELESS----
 
 #group by all addresses to look at what could refer to homeless adressesses
 
 ###TOP ADDRESSESS----
 top100adressess <- masterdata %>% 
   group_by(address, last_name, first_name, date_of_birth) %>% 
   count() %>%
   group_by(address) %>%
   count() 
 #manual checks-----
 
 #75 KING STREET (T) a lot of records <- it's the address for St Augustine pol dep
 
 #Flagged out homeless shelters, resque centers with google, rest of them look like normal addresses besides:
 # 	3571 begonia st <- no charge related to homelessness
 # 25 nesmith ave <- related to certain drug raid

 # cabbage <- masterdata %>% 
 #   filter(str_detect(address, "2970 CABBAGE HAMMOCK"))
 # 
 # cabbage %>% 
 #   group_by(case_open_date, case_id, court_type, court_charge, date_of_birth, 
 #            first_name, last_name, offense_date) %>%
 #   count() %>% 
 #   View()
 # 
 # cabbage %>% 
 #   group_by(first_name, last_name) %>%
 #   count() %>% 
 #   View()
 # 
 # #cabbage road is one of the most common, but only for four people total, so can be that they just happen to have a lot of crimes. look whether homeless charges 
 # #stand out? There are trespassing warnings there, so it might still refer to homelessness. We need to look more into that place, whether any of those people are homeless
 
 # cabbage %>% 
 #   group_by(initial_charge) %>%
 #   count() %>% 
 #   View()
 # #look into w state street 
 # 
 # cabbage <- masterdata %>% 
 #   filter(str_detect(address, "2970 CABBAGE HAMMOCK"))
 # 
 # 
 # statest <- masterdata %>% 
 #   filter(str_detect(address, "234 W STATE ST")) 
 # 
 # statest %>% 
 #   group_by(initial_charge) %>%
 #   count() %>% 
 #   View()
 # 
 # statest %>% 
 #   group_by(first_name, last_name, date_of_birth) %>% 
 #   count() %>%
 #   View()
 # 
 # washingtonst <- masterdata %>% 
 #   filter(str_detect(address, "70 WASHINGTON ST")) 
 # 
 # masterdata %>% 
 #   filter(str_detect(address, "5770 DON MANUEL RD")) %>% 
 #   group_by(first_name, last_name, date_of_birth) %>% 
 #   count()
 # #only two people, probably married or siblings so not a shelter 
 # # 1 PAUL       BUTNER    07/29/1999       14
 # # 2 SIERRA     BUTNER    09/05/1997      241
 # 
 # #run charge view just incase - no charge looks like a homeless related charge 
 # 
 # masterdata %>% 
 #   filter(str_detect(address, "5770 DON MANUEL RD")) %>% 
 #   group_by(initial_charge) %>% 
 #   count() %>% 
 #   View()
 
 # 1 ATTACHING A TAG NOT ASSIGNED                           1
 # 2 CARRYING A CONCEALED FIREARM                          35
 # 3 DRIVING LICENSE SUSPENDED/REVOKED                      6
 # 4 DRUGS-POSSESS CNTRL SUB/RX DRUG W/OUT PRESCRIPTION     1
 # 5 INTRODUCTION OF CONTRABAND INTO PENAL INSTITUTION     33
 # 6 NO VALID DRIVER LICENSE                               39
 # 7 POSSESSION OF COCAINE                                 33
 # 8 POSSESSION OF HEROIN                                  33
 # 9 PRODUCE METHAMPHETAMINE                               35
 # 10 USE OR POSSESSION OF DRUG PARAPHERNALIA               39
 
 
 #check for general delivery (from  Ryan's reporting)
 
 
 t <- masterdata %>%
   group_by(address) %>% 
   count()
 
 
 t$address %>% 
   key_collision_merge() 
 #%>% View()
 
 #no spelling errors for homeless and general delivery
 #added some for old moultrie and others
 
 #check for names 
 
 homelessaddresses <- masterdata %>% 
   filter(str_detect(masterdata$address,"2450 old moultrie")|
            str_detect(masterdata$address,"2450 old moultry")|
            str_detect(masterdata$address,"2450 moultrie rd")|
            str_detect(masterdata$address,"2450 moultry rd")|
            str_detect(masterdata$address,"62 chapin")| 
            str_detect(masterdata$address,"70 washington")| 
            str_detect(masterdata$address, "8 carrera")| 
            str_detect(masterdata$address, "118 king st")|
            str_detect(masterdata$address,"185 martin luther king")|
            str_detect(masterdata$address,"185 mlk")|
            str_detect(masterdata$address,"161b marine")| 
            str_detect(masterdata$address,"3125 agricultural")| 
            str_detect(masterdata$address,"525 west king")|
            str_detect(masterdata$address,"homeless")|
            str_detect(masterdata$address,"general delivery")|
            str_detect(masterdata$address,"70 washington")|
            str_detect(masterdata$address,"234 w state")|
            str_detect(masterdata$address, "507 e church")| #(homeless center),
            str_detect(masterdata$address, "1850 sr 207")|
            str_detect(masterdata$address, "1850 sr207")|
            str_detect(masterdata$address,"1850 state rd 207")|
            str_detect(masterdata$address,"1850 state road 207")| #(salvation army)
            str_detect(masterdata$address,"611 e adams st"))
 
 
 #check to be sure that str_detect found all options
 unique(homelessaddresses$address)
 
 #look for people in homelessadress from rest of the data 
 
 homelessaddresses <- unique(homelessaddresses)
 
 nohomelessadd <- anti_join(masterdata, homelessaddresses, by = "address")
 
 homelessnames <- homelessaddresses %>% 
   select(full_name) %>% 
   group_by(full_name) %>% 
   count() %>% 
   select(full_name)
 
 inboth <- inner_join(homelessnames, nohomelessadd)
 
 inboth %>% 
   group_by(full_name, address) %>%
   count() 
 
 final_homeless <- bind_rows(homelessaddresses, inboth)
 
 final_homeless <- final_homeless %>% 
   mutate(offense_year = year(offense_date),
          case_year = year(case_open_date)) %>%
   mutate(id = rownames(final_homeless))
 
 #do we have people with double bdays? there,s 18 people 
 
 doublebday <- final_homeless %>% 
   group_by(full_name, date_of_birth) %>% 
   count() %>% 
   group_by(full_name)%>%
   count() %>%
   filter(n>1)
 
 #deal with NA-s first 
 nobday <- final_homeless %>% filter(is.na(date_of_birth)) %>% group_by(full_name, date_of_birth) %>% count()
 
 #do they have other rows with bdays
 
 final_homeless %>% 
   filter(full_name %in% nobday$full_name) %>%
   group_by(full_name, date_of_birth, race, sex) %>% 
   count() 
 
 #for people who have a bday in other rows we can just use their ID, there are 3 in nobday data frame 
 
 final_homeless[final_homeless$id == 3675, "date_of_birth"] <- as.Date("1989-07-03")
 final_homeless[final_homeless$id == 3544, "date_of_birth"] <- as.Date("1964-10-24")
 final_homeless[final_homeless$id == 3745, "date_of_birth"] <- as.Date("1984-06-09")
 final_homeless[final_homeless$id == 3877, "date_of_birth"] <- as.Date("1991-10-02")
 
 
 
 #some birthdays are NA-s and some have typos when it comes to the first 2 instead of 1
 
 
 #saveRDS(final_homeless, "final_homeless.rds")
 
 
 #how many now?
 
 doublebday <- final_homeless %>% 
   group_by(full_name, date_of_birth) %>% 
   count() %>% 
   group_by(full_name)%>%
   count() %>%
   filter(n>1)
 
 final_homeless %>% 
   filter(full_name %in% doublebday$full_name) %>%
   group_by(full_name, date_of_birth) %>%
   count()
 
 #some people have just wrong year, e.g 2057 instead of 1057 etc
 # 
 final_homeless$date_of_birth <- gsub("^2", "1", final_homeless$date_of_birth)
 final_homeless$date_of_birth <- gsub("^10", "19", final_homeless$date_of_birth)

 final_homeless <- final_homeless %>% 
   mutate(offense_year = year(offense_date),
          case_year = year(case_open_date)) %>%
   mutate(id = rownames(final_homeless))
   
 #saveRDS(final_homeless, "final_homeless.rds")
 #there's five left, but we can't make decisions about them 
 
 doublebday <- final_homeless %>% 
   group_by(full_name, date_of_birth) %>% 
   count() %>% 
   group_by(full_name)%>%
   count() %>%
   filter(n>1)
 
 final_homeless$date_of_birth <- ymd(final_homeless$date_of_birth)
 
 #create a data for NA-s 
 
 na_addresses <- masterdata %>%
   anti_join(final_homeless) 
 
 na_addresses <- na_addresses %>% 
   filter(is.na(address))
 
 na_addresses %>% 
   group_by(full_name) %>% 
   count() %>% 
   nrow()
 
 #there are 64229 people all together with NA address but who are not in homeless dataframe
 
 #how many of them have "homeless charges"?
 
 #based on reporting look for charges based on these state laws 
 
 crimes <- c("316.130", "316.2045", "810.08", "810.09", "856.011", "856.201", "856.021", "877.03", 
             "4-5", "13-4", "18-8", "22-12", "18-56", "99-50", "91-11", "24-14", "2007-19,3.0", "28-3", "18-51", "337.406")
 
 
 na_but_charge <- na_addresses %>%
   filter(str_detect(na_addresses$initial_statute, paste(crimes, collapse="|"))| 
            str_detect(na_addresses$court_statute, paste(crimes, collapse="|"))| 
            str_detect(na_addresses$prosecute_statue, paste(crimes, collapse="|"))) 
 
 #how many of them have other addressess
 
 names_na_but_charge <- na_but_charge %>% 
   select(full_name) %>%
   group_by(full_name) %>% 
   count()
 
 names_na_but_charge <- names_na_but_charge %>% 
   left_join(masterdata, by = "full_name")
 
 na_and_address_atsometime <- names_na_but_charge %>% 
   group_by(address, full_name) %>%
   count() %>%
   group_by(full_name) %>% 
   count() %>% 
   filter(n>1) 
 
 
 #there's 13 people who have both NA and existing address, but the case numbers dont match, so for now we include them 
 
 final_homeless <- bind_rows(final_homeless, na_but_charge)
 final_homeless <- unique(final_homeless)
 
 final_homeless <- final_homeless %>% 
   mutate(offense_year = year(offense_date),
          case_year = year(case_open_date)) %>%
   mutate(id = rownames(final_homeless))
 
 saveRDS(final_homeless, 'final_homeless.rds')
 
 ####CHECK SEPARATELY----
 #str_detect(masterdata$address,"75 (t) king st")| #(salvation army)
 #str_detect(masterdata$address,"75 king st (t)"))
 
 #we need to look at NA-s - can this be homeless person as well?
 
 #what's going in in NA-s
 
 address_NA <- masterdata %>% 
   filter(is.na(masterdata$address)) 
 #%>% View()
 
 address_NA %>% 
   group_by(first_name, last_name, middle_name, date_of_birth) %>% 
   count() 
 #%>% View()
 #64,602 entries, e.g unique people, very likely that two people with the same name and birthday end up commiting crimes in florida 
 # do we have nameless people?
 # we use last name, becuse when first name is missing, then it might be also a company 
 masterdata %>%
   filter(is.na(masterdata$last_name)) 
 #%>% View() 
 
 #there's 6 nameless records all together, will get back to it if we need to. 
 
saveRDS(final_homeless,"final_homeless.rds")

###JAILDATA----

###ADD JAILDATA AND JAILANALYSIS
#scraped from st john's county's jail website 

jaildata <- readRDS("data/jaildata.rds") %>%
  select(1:3)

jaildata$booking_date <- mdy_hm(jaildata$booking_date)
jaildata$release_date <- mdy_hm(jaildata$release_date)
jaildata$full_name <- gsub(" BUDDY LOVE", "", jaildata$full_name)

jaildata <- jaildata %>%
  mutate(last_name = sub(" .*", "", full_name),
         first_name = str_extract(full_name, "( .*? )"),
         middle_name = str_remove_all(full_name, ".* "))


jaildata$last_name <- gsub(",", "", jaildata$last_name) %>%
   tolower()
 jaildata$first_name <- gsub(" ", "", jaildata$first_name) %>%
   tolower()
 jaildata$middle_name <- gsub(" ", "", jaildata$middle_name) %>%
   tolower()

jaildata <- jaildata %>%
  mutate(full_name = paste0(first_name,
                          " ",
                            middle_name,
                             " ",
                             last_name))
jaildata <- jaildata %>%
  mutate(jailtime_in_days = round((release_date - booking_date)/24/60,2))

write_rds(jaildata, "jaildata.rds")

all_jail_time <- jaildata %>% 
  filter(last_name != "charges", 
         year(booking_date) > 2014) %>% 
  group_by(full_name) %>% 
  summarise(jailtime_in_days = sum(jailtime_in_days, na.rm = T),
            jailtime_in_years = round(sum(jailtime_in_days, na.rm = T)/365,2)) %>% 
  arrange(desc(jailtime_in_days)) 

all_jail_time$full_name <- str_replace_all(all_jail_time$full_name,"\\s+", " ") 

#write it into homelessdata

final_homeless <- left_join(final_homeless, all_jail_time, by = "full_name")
saveRDS(final_homeless, "final_homeless.rds")
 
write_rds(all_jail_time,"all_jail_time.rds")

##PRISONDATA----


#load in data, from Florida DoC, of january 2020 

release <- read_excel("data/source/release_inmates.xlsx", 
                      col_types = c("numeric", "text", "text", "text", "text", "text", "text", "date", 
                                    "date", "date", "text", "text", "text")) 

active <- read_excel("data/source/active_inmates.xlsx", 
                     col_types = c("numeric", "text", "text", 
                                   "text", "text", "text", "text", "date", 
                                   "date", "date", "text", "text", "text")
)

 active_small <- active %>% select(last_name, first_name, date_of_birth, receipt_date)
 release_small <- release %>% select(last_name, first_name, date_of_birth, release_date)
 
 
release_small$last_name <- release_small$last_name %>% tolower()
release_small$first_name <- release_small$first_name %>% tolower()
active_small$last_name <- active_small$last_name %>% tolower()
active_small$first_name <- active_small$first_name %>% tolower()
release_small$date_of_birth <- release_small$date_of_birth %>% as.Date()
active_small$date_of_birth <- active_small$date_of_birth %>% as.Date()
release_small$release_date <- release_small$release_date %>% as.Date()
active_small$receipt_date <- active_small$receipt_date %>% as.Date()
 
released_homeless <- inner_join(final_homeless, release_small, by = c("first_name", "last_name", "date_of_birth")) %>% 
   group_by(full_name, release_date) %>% 
   count()
 
 imprisoned_homeless <- inner_join(final_homeless, active_small, by = c("first_name", "last_name", "date_of_birth")) %>%   group_by(full_name, receipt_date) %>% 
   count()
 
#add to the main homeless dataframe 
 
 final_homeless <- final_homeless %>% 
   left_join(released_homeless, by = "full_name") %>%  
   select(-n) %>% 
   left_join(imprisoned_homeless, by = "full_name") %>%  
   select(-n)
 
 saveRDS(final_homeless, "final_homeless.rds")
 
 ###add first and last offense dates----
 
 t <- final_homeless %>% 
    group_by(full_name, offense_date) %>% 
    count() %>% 
    select(-n) %>%
    pivot_wider(names_from = offense_date, values_from = offense_date) %>%
    ungroup() %>%
    select(-full_name) 
    
  
 is.na(final_homeless$full_name) %>% nrow() <- #make sure there are no NA-s in full_name
  
  x <- t %>% 
    replace(is.na(.), "1000-01-01") ##pick a date which is definitely smaller 
  
  last_offense_date <- as.data.frame(apply(x, 1, FUN=max))%>% 
    rename(last_offense_date = 1)
  
  x <- t %>%
    replace(is.na(.), "3000-01-01") #pick a date which is definitely bigger 
  
  first_offense_date <- as.data.frame(apply(x, 1, FUN=min)) %>% 
    rename(first_offense_date = 1)
  
  t <- final_homeless %>% 
    group_by(full_name, offense_date) %>% 
    count() %>% 
    group_by(full_name) %>% 
    count() %>% 
    select(full_name)
  
  mydata <- list(t, first_offense_date, last_offense_date)
  
  offense_dates <- map_dfc(mydata, bind_cols)
 
 #add to final dataframe 
 
 final_homeless <- final_homeless %>%
 left_join(offense_dates, by = "full_name")
 
 saveRDS(final_homeless, "final_homeless.rds")