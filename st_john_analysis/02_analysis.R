#Analysis 
#Riin Aljas
#aljasriin@gmail.com

###LOAD DATA, FUNCTIONS AND LIBRARIES----
source("03_helper_functions.R")

library(tidyverse)
library(janitor)
library(lubridate)
library(refinr)
library(ggplot2)
library(dplyr)
library(stringr)
library(gridExtra)
library(readxl)
final_homeless <- readRDS("final_homeless.rds") 
final_homeless <- final_homeless %>% 
  mutate(offense_year = year(offense_date),
         case_year = year(case_open_date)) %>%
  mutate(id = rownames(final_homeless))

masterdata <- readRDS("masterdata.rds") 
look_up <- readxl::read_xlsx("data/source/statute_lookup.xlsx") %>%
  clean_names() %>% 
  mutate(statute_full = paste0(statute, " ", subsection)) %>% 
  select(statute_full, description)

look_up$statute_full <- gsub("NA", "", look_up$statute_full) 
look_up$statute_full <- gsub("843.02 ", "843.02", look_up$statute_full)
look_up$statute_full <- gsub("00000000001 ", "", look_up$statute_full)
look_up$statute_full <- gsub("00000000005", "", look_up$statute_full)
look_up$statute_full <- gsub("000000000003", "", look_up$statute_full)
look_up$statute_full <- gsub("000000000004", "", look_up$statute_full)
look_up$statute_full <- gsub("812.0142", "812.014 2", look_up$statute_full)


#check for doubles 
ourdata <- list(animal, 
                boating, 
                code_en, 
                county_ord, 
                crim_traf, 
                felony, 
                fish, 
                misdem, 
                municip_ord,  
                non_crim, 
                parking)

results <- lapply(ourdata, function(df) {
  amount <- n_distinct(df[[1]])
}
)

#based on reporting look for charges based on these state laws 
#source ADD SOURCE 

crimes <- c("316.130", "316.2045", "810.08", "810.09", "856.011", "856.201", "856.021", "877.03", 
            "4-5", "13-4", "18-8", "22-12", "18-56", "99-50", "91-11", "24-14", "2007-19,3.0", "28-3", "18-51", "337.406")

###look for doubles ---- 
#animal - 975 vs 973
#boating - ==
#code en 486 vs 482
#county or 1000 vs 999
#crim_traf 13287 vs 11009
#felony 9463 vs 42483
#fish 368 vs 359
#misdem 18032 vs #12321
#municip 1289  vs 1269
#parking 4013 vs 4012

#most doubles are actually present in the data originally, hence not a flag 

#how do we find homeless people?
# let's look what they've used as addresses for people 
#make a masterdataframe 

#group by all addresses to look at what could refer to homeless adressesses

###TOP ADDRESSESS----
top100adressess <- masterdata %>% 
  group_by(address, last_name, first_name, date_of_birth) %>% 
  count() %>%
  group_by(address) %>%
  count() 

#common but we need to look into more: 
#75 KING STREET (T) a lot of records <- it's the address for St Augustine pol dep
#75 (t) king st


#Flagged out homeless shelters, resque centes with goofle, rest of them look like normal addresses besides:
# 	3571 begonia st <- no charge related to homelessness
# 25 nesmith ave <- related to certain drug raid
#65 lewis blvd marina 



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

masterdata %>% 
  filter(str_detect(address, "GENERAL")) %>% 
  group_by(first_name, last_name, date_of_birth, address) %>% 
  count()

# some places have general delivery with post office addresses, local police officer said that might be the case if they have PO box

#check against list of homeless centers from here https://docs.google.com/document/d/1I9yF0jknqvSCF4S4jqgLpVTU1QDjMAOCCVVk_s5XNs0/edit?ts=5e4ab08c

#check for spelling errors for street names we're interested in and add them to the query

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
         str_detect(masterdata$address,"185 mlk", )|
         str_detect(masterdata$address,"161b marine", )| 
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

#final_homeless <- bind_rows(homelessaddresses, inboth)

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
#comment this row out as we save it to the final rds dataframe 

# final_homeless[final_homeless$id == 3675, "date_of_birth"] <- as.Date("1989-07-03")
# final_homeless[final_homeless$id == 3544, "date_of_birth"] <- as.Date("1964-10-24")
# final_homeless[final_homeless$id == 3745, "date_of_birth"] <- as.Date("1984-06-09")
# final_homeless[final_homeless$id == 3877, "date_of_birth"] <- as.Date("1991-10-02")



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
# final_homeless$date_of_birth <- gsub("^2", "1", final_homeless$date_of_birth)
# final_homeless$date_of_birth <- gsub("^10", "19", final_homeless$date_of_birth)
# 
# saveRDS(final_homeless, "final_homeless.rds")
#there's five left, but we can't make decisions about them 

doublebday <- final_homeless %>% 
  group_by(full_name, date_of_birth) %>% 
  count() %>% 
  group_by(full_name)%>%
  count() %>%
  filter(n>1)





#create a data for NA-s 

na_addresses <- masterdata %>%
  anti_join(final_homeless) 

na_addresses <- na_addresses %>% 
  filter(is.na(address))

na_addresses %>% 
  group_by(full_name) %>% 
  count() %>% 
  nrow()

#there are 64288 people all together with NA address but who are not in homeless dataframe

#how many of them have "homeless charges"?

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

na_and_address_atsometime <- masterdata %>%
  filter(full_name %in% na_and_address$full_name) 

na_and_address_atsometime %>% 
  group_by(full_name, case_id, address) %>% 
  count() 

#there's 13 people who have both NA and existing address, but the case numbers dont match, so for now we include them 

# final_homeless <- bind_rows(final_homeless, na_but_charge)
# final_homeless <- unique(final_homeless)



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

####CHARGES----

homeless_crimes <- crimes <- c("316.130", "316130", "316.2045", "162045", "810.08", "810.09", "856.011", "856.021", "877.03", 
                               "4-5", "13-4", "18-8", "22-12", "18-56", "99-50", "91-11", 
                               "24-14", "2007-19,3.0", "28-3", "18-51", "337.406")

homeless_charge_data <- final_homeless %>% 
  filter(str_detect(final_homeless$initial_statute, paste(crimes, collapse="|"))| 
           str_detect(final_homeless$court_statute, paste(crimes, collapse="|"))| 
           str_detect(final_homeless$prosecute_statue, paste(crimes, collapse="|"))) 



chargedata <- masterdata %>% 
  filter(str_detect(masterdata$initial_statute, paste(crimes, collapse="|"))| 
           str_detect(masterdata$court_statute, paste(crimes, collapse="|"))| 
  str_detect(masterdata$prosecute_statue, paste(crimes, collapse="|"))) 

unique(chargedata$initial_statute)

masterdata %>% 
  filter(str_detect(masterdata$initial_charge, "tresspass")|
           str_detect(masterdata$initial_charge, "overnight")|
           str_detect(masterdata$initial_charge, "over night")|
           str_detect(masterdata$initial_charge, "loiter")|
           str_detect(masterdata$initial_charge, "panhandling")|
           str_detect(masterdata$initial_charge, "camping")|
           str_detect(masterdata$court_charge, "tresspass")|
           str_detect(masterdata$court_charge, "over night")|
           str_detect(masterdata$court_charge, "overnight")|
           str_detect(masterdata$court_charge, "loiter")|
           str_detect(masterdata$court_charge, "panhandling")|
           str_detect(masterdata$court_charge, "camping")|
           str_detect(masterdata$filed_charge, "tresspass")|
           str_detect(masterdata$filed_charge, "over night")|
           str_detect(masterdata$filed_charge, "overnight")|
           str_detect(masterdata$filed_charge, "loiter")|
           str_detect(masterdata$filed_charge, "panhandling")|
           str_detect(masterdata$court_charge, "camping")) %>%
  group_by(initial_statute)%>% #change this also to court_statute and prosecute_statute
  count()


####DATA ANALYSIS----

#what are the most common charges, statues and how they differ ----

#look at statutes 

by_initial_statute <- final_homeless %>% 
  select(full_name, case_id, initial_statute) %>%
  unique() %>% 
  group_by(initial_statute) %>% 
  count() %>%
  left_join(look_up,  by = c("initial_statute" = "statute_full"))
  

by_court_statute <- final_homeless %>% 
  select(full_name, case_id, court_statute) %>%
  unique() %>% 
  group_by(court_statute) %>% 
  count()%>%
  left_join(look_up,  by = c("court_statute" = "statute_full"))

by_prosecute_statute <- final_homeless %>% 
  select(full_name, case_id, prosecute_statue) %>%
  unique() %>% 
  group_by(prosecute_statue) %>% 
  count()%>%
  left_join(look_up,  by = c("prosecute_statue" = "statute_full"))

#look at charges

by_initial_charge <- final_homeless %>% 
  select(full_name, case_id, initial_charge) %>%
  unique() %>% 
  group_by(initial_charge) %>%
  count() %>% 
  ungroup()


by_court_charge<- final_homeless %>% 
  select(full_name, case_id, court_charge) %>%
  unique() %>% 
  group_by(court_charge)%>%
  count()

by_prosecute_charge <- final_homeless %>% 
  select(full_name, case_id, filed_charge) %>%
  unique() %>% 
  group_by(filed_charge) %>%
  count()


broader_initial_charge <- by_initial_charge



keycharges <- c("trespass.*", ".*drinking in public.*", "aggravated assault.*", "aggravated battery.*", 
                "arson.*", "burgl.*", "disorderly conduct.*", "disorderly intox.*", ".*panhandling.*", "sab sleeping in public places/vehicles prohibited.*", 
                "sleep/camp/habit/leave human waste.*", ".*cannabis.*", ".*sleep.*")

for (i in keycharges) {
    broader_initial_charge$initial_charge <-gsub(i, i, broader_initial_charge$initial_charge)
}

broader_initial_charge$initial_charge <-gsub("\\.\\*", "", broader_initial_charge$initial_charge) 

broader_initial_charge <- broader_initial_charge %>% 
  group_by(initial_charge) %>% 
  summarise(n = sum(n))

homelessaddresses %>% 
  group_by(full_name, initial_charge, court_charge, filed_charge, offense_date, case_open_date, case_number, case_id) %>%
  count() 

key_collision_merge(broader_initial_charge$initial_charge) 


#do we have homelesspeople in the police dataset

policedep <- masterdata %>% 
  filter(address %in% c("75 king st (t)", 
                        "	75 king street (t)", 
                        "75 (t) king st")) 

anti_join(homelessaddresses, policedep, by = "full_name")

#look into homeless address data to be sure they are really homeless

uniquenames <- homelessaddresses %>% 
  group_by(first_name,middle_name, last_name, date_of_birth, case_open_date) %


#we have 679 people 
# is there a way to tell whether they're all homeless by just joining any other public records data -- no need to spend time now on this 
homelessaddresses %>% 
  group_by(address) %>% 
  count()

#which date should we look at
test <- homelessaddresses %>% 
  mutate(mydifference = (case_open_date - offense_date)) %>%
  select(case_open_date,
         case_close_date,
         offense_date,
         initial_charge,
         court_charge, 
         filed_charge, 
         initial_statute, 
         court_statute, 
         prosecute_statue, 
         everything()) %>%
  select(mydifference, everything())

test %>% 
  filter(mydifference < 0) %>% 
  nrow()

#30 offense or case open dates are wrong, as the time difference is negative, if we leave these out on average the offense date and case open date is 80
# on maximum it's 1306 days though which is 3.5 years 
# Min. 1st Qu.  Median    Mean    3rd Qu.    Max. 
# 1.00   30.00   31.00   81.33   62.00  1306.00 

namebday <- homelessaddresses %>% 
  group_by(full_name, date_of_birth, race) %>%
  count() 

doubles <- namebday %>% 
  group_by(full_name) %>% 
  count() %>% 
  filter(n > 1)
#where's the difference 
masterdata %>% 
  filter(full_name %in% doubles$full_name) %>%
  group_by(full_name, date_of_birth, race) %>% 
  count() 

#all doubles come from missing bdays hence we can use full name as an unique id unless
#run key kollision merge just in case 

key_collision_merge(namebday$full_name)

homelessaddresses %>% group_by(full_name, date_of_birth) %>% count() 
#went through them all we can use that as a unique ID, mutate bdays so we wouldn't have doubles


n_distinct(homelessaddresses$full_name) #makes sense because with grouping by bdays we get 672
##660 full_names 

homelessaddresses %>% group_by(last_name, middle_name, first_name, date_of_birth, offense_date, initial_statute)

# police_dep_address <- masterdata %>% 
#   filter(str_detect(masterdata$address,"75 king")) %>% View()
#   group_by(court_statute, 
#            initial_statute, 
#            prosecute_statue, 
#            initial_charge, 
#            court_charge, 
#            filed_charge) %>% 
#   count()
#   
#   police_dep_address %>%
#     group_by(first_name, 
#              last_name, 
#              date_of_birth, 
#              court_statute, 
#              initial_statute, 
#              prosecute_statue, 
#              initial_charge, 
#              court_charge, 
#              filed_charge
#              ) %>% 
#     count() %>% View()
# 
#   #179 people 
#   police_dep_address %>%
#     group_by(date_of_birth, 
#               last_name, 
#              first_name,
#              initial_charge, 
#              filed_charge
#     ) %>% 
#     count() %>% View()
#   
#   
#   drinking_police_dep <- police_dep_address %>%
#     filter(str_detect(initial_charge, "drinking"))
# 
# drinking_police_dep <- police_dep_address %>%
#   filter(last_name %in% drinking_police_dep$last_name)
# 
# drinking_police_dep %>%
#   group_by(date_of_birth, 
#                                 last_name, 
#                                 first_name,
#                                 initial_charge, 
#                                 filed_charge
# ) %>% 
#   count() %>% View()
#double check whether there are some laws we might miss 

anti_join(chargedata, homelessaddresses) %>% 
  group_by(address, full_name) %>% 
  count() %>% 
  group_by(address) %>% 
  count()

masterdata %>% 
  filter(address %in% c("75 king st (t)", 
                        "	75 king street (t)", 
                        "75 (t) king st")) %>% 
  group_by(initial_charge) %>% 
  count()

#everything but the police office address is there only once so we can't tell whether there's any that can refer to homeless ones



#find doubles 

t <- unique(homelessaddresses)
homelessaddresses 

homelessaddresses %>% 
  group_by(full_name, initial_charge, case_open_date, offense_date) %>%
  count() 

unique(homelessaddresses) %>% nrow() 

x <- homelessaddresses %>% 
  select(full_name, case_id, initial_charge) %>%
  unique() 


  group_by(full_name, case_id, initial_charge) %>% 




#LOOK INTO PEOPLE ----
  
##who's charging? 
  #of 3978 arrests (when one arrest per day and person) it's been mostly st augustine police and st john's county 
  
final_homeless %>% group_by(full_name, offense_date, charging_agency) %>% 
  unique() %>% 
  group_by(charging_agency) %>% 
  summarise(n = n()) %>% 
    arrange(desc(n))
 
  
  # 1 st augustine police dept         2297
  # 2 st johns county sheriffs office  1798
  # 3 st augustine beach police dept    129
  # 4 florida highway patrol             76
  # 5 county animal control               9
  # 6 fl dept of financial services       9
  # 7 fl fish/wildlife conserv comm       8
  # 
#who's been charged the most?----
  
final_homeless %>% group_by(full_name, offense_date) %>% 
  count() %>% 
  group_by(full_name)%>% 
  count()%>% 
  arrange(desc(n)) 


#lets try with the most charged guy
firstguy <- final_homeless %>% filter(full_name == "laurence jefferson mattox")

mynames <- names(firstguy)

for (i in 1:74) {
 uniquerows <- n_distinct(firstguy[i])
 print(uniquerows)
}

#doesnt look suspicious

x <- firstguy %>%
  group_by(case_id, 
           case_number,
           court_type, 
           case_status, 
           case_open_date, 
           case_close_date, 
           offense_date, 
           charge_status, 
           status_date, 
           initial_count, 
           initial_charge,
           disposition_date, 
           disposition, 
           total_owed, 
           total_paid, 
           balance_due, 
           re_open_date, 
           re_open_close_date, 
           re_open_reason, 
           charging_agency) %>%
  count()


x %>%
  group_by(offense_date, case_open_date, initial_charge) %>%
  count() %>%
  View()
#all rows are unique - he actually has so many different charges 

x %>%
  group_by(case_id, case_number, offense_date, case_open_date, case_close_date, initial_charge,
           total_owed, total_paid, balance_due) %>%
  count() %>%
  arrange((offense_date)) %>%
  View()

#so far we cant add the charges together as we're not sure whats unique

#1) which courts----
#we group it by case and a person, hence how many different cases, not how many charges per court
final_homeless %>%
  group_by(case_number, court_type, full_name) %>% 
  count() %>% 
  group_by(court_type) %>% 
  summarise(total = n()) %>%
  mutate(pct = total/sum(total)*100) %>%
  arrange(desc(total))

# court_type              total     pct
# <chr>                   <int>   <dbl>
#   1 misdemeanor              1357 45.3   
# 2 municipal ordinance       669 22.3   
# 3 criminal felony           454 15.2   
# 4 civil traffic             296  9.88  
# 5 criminal traffic          170  5.68  
# 6 county ordinance           23  0.768 
# 7 animal control             10  0.334 
# 8 boating infractions         7  0.234 
# 9 parking                     6  0.200 
# 10 non-criminal infraction     2  0.0668
# 11 fish/wildlife               1  0.0334

#the one fish/wildlife court charge is for no " n/c no wildlife management area permit"
#the person was indeed homeless then though, and has five other charges which go up to felony

#non-criminal infraction is for littering, same guy

#
#2) is there difference in location----

final_homeless %>%
  group_by(jurisdiction) %>% 
  count() %>%
  arrange(desc(n)) 
#not so much 

#3) difference in dates----- 

grid.arrange(plot1, plot2, plot3)

plot1 <- final_homeless %>% 
  filter(offense_year > 2013) %>% 
  group_by(offense_year, case_number) %>% 
  count() %>%
  group_by(offense_year) %>%
  count() %>% 
  ggplot()+
  geom_smooth(mapping = aes(offense_year, n))

plot2 <- final_homeless %>%
  filter(case_year > 2013) %>%
  group_by(case_year, case_number) %>% 
  count() %>%
  group_by(case_year) %>%
  count() %>% 
  ggplot()+
  geom_smooth(mapping = aes(case_year, n))

plot3 <- masterdata %>%
  filter(offense_year > 2013) %>%
  group_by(case_year, case_number) %>% 
  count() %>%
  group_by(case_year) %>%
  count() %>% 
  ggplot()+
  geom_smooth(mapping = aes(case_year, n))

##there was a rise from 2017 to 2018 and then decrease again after 2019

#4) what's the difference between case_id and case_nr----
#their n_distinct is the same 

n_distinct(final_homeless$case_number)

x <- final_homeless %>%
  group_by(case_id, full_name) %>%
  count()

y <- final_homeless %>%
  group_by(case_number, full_name) %>%
  count() %>% anti_join(x)
rm(y,x)
#they're the same, so we don't care

#5 #difference in status---- 

final_homeless %>% 
  group_by(offense_date, charge_status) %>%
  summarise(n = n()) %>%
  group_by(charge_status) %>%
  summarise(n=n()) %>%
  mutate(percent = round(n/sum(n)*100,2))

#6 difference in total paid----
#we know from talking to the clerk and random checks that money owed is unique per case number (not by charge) and offense date 

unique_payments <- final_homeless %>%
  group_by(offense_date, case_number, total_owed, full_name) %>% 
  count() %>%
  group_by(total_owed) %>% 
  summarise(cases = n()) %>% 
  mutate(pct = round(
    (cases/sum(cases)*100),2
    )) %>%
  arrange(desc(cases)) 


by_nr <- final_homeless %>%
  group_by(offense_date, case_number, total_owed, total_paid, balance_due, full_name, release_date, receipt_date, first_offense_date, last_offense_date) %>% 
  count()

by_nr$total_owed <- as.integer(by_nr$total_owed)
summary(by_nr$total_owed)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 0.0    166.0    305.0    385.9    414.0 105783.0 


demographics <- final_homeless %>% 
  group_by(full_name, date_of_birth, sex, race, receipt_date, release_date, first_offense_date, last_offense_date) %>% 
  count() %>% 
  unique()

owed_by_person <- by_nr %>%
  group_by(full_name) %>%
  summarise(all_fees = sum(total_owed, na.rm = TRUE), 
            all_paid = sum(total_paid , na.rm = TRUE), 
            all_balance = sum(balance_due, na.rm = TRUE)) %>%
  arrange(desc(all_fees)) %>% 
  inner_join(demographics, owed_by_person, by = "full_name") %>% 
  mutate(age = calc_age(date_of_birth)) %>%
  select(full_name, all_fees, all_paid, all_balance, everything())

###add first and last offense dates----

# t <- final_homeless %>% 
#   group_by(full_name, offense_date) %>% 
#   count() %>% 
#   select(-n) %>%
#   pivot_wider(names_from = offense_date, values_from = offense_date) %>%
#   ungroup() %>%
#   select(-full_name) 
#   
# 
# is.na(final_homeless$full_name) %>% nrow() <- #make sure there are no NA-s in full_name
# 
# x <- t %>% 
#   replace(is.na(.), "1000-01-01") ##pick a date which is definitely smaller 
# 
# last_offense_date <- as.data.frame(apply(x, 1, FUN=max))%>% 
#   rename(last_offense_date = 1)
# 
# x <- t %>%
#   replace(is.na(.), "3000-01-01") #pick a date which is definitely bigger 
# 
# first_offense_date <- as.data.frame(apply(x, 1, FUN=min)) %>% 
#   rename(first_offense_date = 1)
# 
# t <- final_homeless %>% 
#   group_by(full_name, offense_date) %>% 
#   count() %>% 
#   group_by(full_name) %>% 
#   count() %>% 
#   select(full_name)
# 
# mydata <- list(t, first_offense_date, last_offense_date)
# 
# offense_dates <- map_dfc(mydata, bind_cols)

#add to final dataframe 

#final_homeless <- final_homeless %>%
  #left_join(offense_dates, by = "full_name")

#saveRDS(final_homeless, "final_homeless.rds")

#7) which judges are charging people---- 

x <- final_homeless %>%
  filter(offense_year > 2013) %>% 
  group_by(offense_year, case_number,full_name, initial_charge, judge, court_type) %>% 
  count() %>% 
  group_by(judge, offense_year) %>% 
  summarise(judge_by_year = n())


final_homeless %>%
  filter(offense_year > 2013) %>% 
  group_by(offense_year, case_number,full_name, initial_charge, judge, court_type) %>% 
  count() %>% 
  group_by(judge, court_type, offense_year) %>% 
  summarise(total = n()) %>%
  left_join(x, by = c("judge", "offense_year")) %>%
  mutate(pct = total/judge_by_year) %>% 
  ggplot()+
  geom_line(mapping = aes(offense_year, pct, color = court_type))+
  facet_wrap(~judge)

#the judges that have no cases are the rows with a lot of other na-s
  
  
  

####PRISON RELATION ----
#load in data, from Florida DoC, of january 2020 

release <- read_excel("data/source/release_inmates.xlsx", 
                             col_types = c("numeric", "text", "text", "text", "text", "text", "text", "date", 
                                           "date", "date", "text", "text", "text")) 

active <- read_excel("data/source/active_inmates.xlsx", 
                             col_types = c("numeric", "text", "text", 
                                           "text", "text", "text", "text", "date", 
                                           "date", "date", "text", "text", "text")
                             )

# active_small <- active %>% select(last_name, first_name, date_of_birth, receipt_date)
# release_small <- release %>% select(last_name, first_name, date_of_birth, release_date)
# 
# 
# release_small$last_name <- release_small$last_name %>% tolower()
# release_small$first_name <- release_small$first_name %>% tolower()
# active_small$last_name <- active_small$last_name %>% tolower()
# active_small$first_name <- active_small$first_name %>% tolower()
# release_small$date_of_birth <- release_small$date_of_birth %>% as.Date()
# active_small$date_of_birth <- active_small$date_of_birth %>% as.Date()
# release_small$release_date <- release_small$release_date %>% as.Date()
# active_small$receipt_date <- active_small$receipt_date %>% as.Date()
# 
# released_homeless <- inner_join(final_homeless, release_small, by = c("first_name", "last_name", "date_of_birth")) %>% 
#   group_by(full_name, release_date) %>% 
#   count()
# 
# imprisoned_homeless <- inner_join(final_homeless, active_small, by = c("first_name", "last_name", "date_of_birth")) %>%
#   group_by(full_name, receipt_date) %>% 
#   count()
# 
# #add to the main homeless dataframe 
# 
# final_homeless <- final_homeless %>% 
#   left_join(released_homeless, by = "full_name") %>%  
#   select(-n) %>% 
#   left_join(imprisoned_homeless, by = "full_name") %>%  
#   select(-n)






release_small <- release %>% 
  tolower(release_small$last_name, release_small$first_name)

owed_by_person_wider <- final_homeless %>% 
  group_by(offense_date, full_name, initial_charge, total_owed, total_paid, balance_due) %>% 
  count() %>% 
  unique() %>% 
  arrange(desc(total_owed), full_name)


owed_by_person <- by_nr %>%
  group_by(full_name) %>%
  summarise(all_fees = sum(total_owed, na.rm = TRUE), 
            all_paid = sum(total_paid , na.rm = TRUE), 
            all_balance = sum(balance_due, na.rm = TRUE)) %>%
  arrange(desc(all_fees)) %>% 
  inner_join(demographics, by = "full_name") %>% 
  mutate(age = calc_age(date_of_birth)) %>%
  

#write_rds(owed_by_person, "owed_by_person.RDS")


by_nr_homeless_charge <- homeless_charge_data %>%
  group_by(offense_date, case_number, total_owed, total_paid, balance_due, full_name, release_date, receipt_date, first_offense_date, last_offense_date) %>% 
  count()


owed_by_person_spec <- by_nr_homeless_charge %>%
  group_by(full_name) %>%
  summarise(all_fees_homeless = sum(total_owed, na.rm = TRUE), 
            all_paid_all_homeless = sum(total_paid , na.rm = TRUE), 
            all_balance_homeless = sum(balance_due, na.rm = TRUE)) %>%
  arrange(desc(all_fees_homeless)) %>% 
  inner_join(demographics, by = "full_name") %>% 
  mutate(age = calc_age(date_of_birth))


owed_by_person <-  left_join(owed_by_person, (owed_by_person_spec %>% 
                                     select(full_name, all_fees_homeless, all_paid_all_homeless, all_balance_homeless))
                  , by = "full_name") %>%
  select(full_name, all_fees_homeless, all_paid_all_homeless, all_balance_homeless, everything()) %>%
  arrange(desc(all_fees_homeless))
  
  

write_rds(owed_by_person, "owed_by_person.rds")







#look same about homeless related charges 

homeless_crimes <- crimes <- c("316.130", "316130", "316.2045", "162045", "810.08", "810.09", "856.011", "856.021", "877.03", 
                               "4-5", "13-4", "18-8", "22-12", "18-56", "99-50", "91-11", 
                               "24-14", "2007-19,3.0", "28-3", "18-51", "337.406")

by_nr_spec_charges <- final_homeless %>%
  filter(initial_statute %in% )
  group_by(offense_date, case_number, total_owed, total_paid, balance_due, full_name, release_date, receipt_date, first_offense_date, last_offense_date) %>% 
  count()

key_collision_merge(unique(final_homeless$initial_statute)) %>% View()

####CHARGES----

#1) group by statute numbers, but first need to standardize 

# key_collision_merge(final_homeless$initial_statute) 
# #key_collision_merge showed we can remove ((sab) and xb and xby and we need to change 5apr to 5-4)
# 
# final_homeless$initial_statute <- str_replace_all(final_homeless$initial_statute,
#                 "\\(sab\\)| xb| xby",
#                   "")
# 
# final_homeless$initial_statute <- str_replace_all(final_homeless$initial_statute,
#                                                   "5-apr", 
#                                                   "5-4")
# 
# final_homeless$court_statute <- str_replace_all(final_homeless$court_statute,
#                                                   "\\(sab\\)", 
#                                                   "")
# 
# key_collision_merge(final_homeless$prosecute_statue) %>% 
#   unique() 
# 
# final_homeless$prosecute_statue <- str_replace_all(final_homeless$prosecute_statue,
#                                                   "5-apr", 
#                                                   "5-4")

#write_rds(final_homeless, "final_homeless.rds")

final_homeless %>% 
  count(initial_statute) %>%
  left_join(look_up, by = )


final_homeless %>%
  group_by(initial_charge, initial_statute) %>%
  count() %>% 
  arrange(desc(n)) %>% View()
  
mydf <- as.data.frame(final_homeless$initial_charge)
write_csv(mydf, "mydf.csv")

final_homeless$initial_charge <- gsub("trespass on property other than structure or conve", 
                                      "trespass on property other than a structure or conveyance", 
                                      final_homeless$initial_charge)
u <-  str_replace_all(final_homeless$initial_charge, "drug paraphernalia", "use or possession of drug paraphernalia")

###ADD JAILDATA AND JAILANALYSIS

jaildata <- readRDS("data/jaildata.rds") %>%
  select(1:3)

jaildata$booking_date <- mdy_hm(jaildata$booking_date)
jaildata$release_date <- mdy_hm(jaildata$release_date)
jaildata$full_name <- gsub(" BUDDY LOVE", "", jaildata$full_name)

jaildata <- jaildata %>%
  mutate(last_name = sub(" .*", "", full_name),
         first_name = str_extract(full_name, "( .*? )"),
         middle_name = str_remove_all(full_name, ".* "))


# jaildata$last_name <- gsub(",", "", jaildata$last_name) %>%
#   tolower()
# jaildata$first_name <- gsub(" ", "", jaildata$first_name) %>%
#   tolower()
# jaildata$middle_name <- gsub(" ", "", jaildata$middle_name) %>%
#   tolower()


#
# jaildata <- jaildata %>%
#   mutate(full_name = paste0(first_name,
#                             " ",
#                             middle_name,
#                             " ",
#                             last_name))
# jaildata <- jaildata %>%
#   mutate(jailtime_in_days = round((release_date - booking_date)/24/60,2))
#
# write_rds(jaildata, "jaildata.rds")

jaildata <- readRDS("jaildata.rds")

###WHO HAS SERVED THE MOST JAIL TIME----

all_jail_time <- jaildata %>% 
  filter(last_name != "charges", 
         year(booking_date) > 2014) %>% 
  group_by(full_name) %>% 
  summarise(jailtime_in_days = sum(jailtime_in_days, na.rm = T),
            jailtime_in_years = round(sum(jailtime_in_days, na.rm = T)/365,2)) %>% 
  arrange(desc(jailtime_in_days)) 

all_jail_time$full_name <- str_replace_all(all_jail_time$full_name,"\\s+", " ") 

all_jail_time %>% View()

write that into homelessdata

 # final_homeless <- left_join(final_homeless, all_jail_time, by = "full_name")
 # write_rds(final_homeless, "final_homeless.rds")
 # 
 # write_rds(all_jail_time,"all_jail_time.rds")



####tresspass and drinking among homeless vs everyone else----


n_distinct(masterdata$full_name) #
#86665


#we dont have resources to check all unique people in masterdata so we use demographics and take out NA cases

interactions <- masterdata %>%
  anti_join(final_homeless, by = "full_name") %>% 
  filter(!is.na(sex), !is.na(date_of_birth))

all_unique_people <- masterdata %>%
  filter(!is.na(sex), !is.na(date_of_birth)) %>% 
  group_by(full_name, date_of_birth, sex) %>% 
  count()

uniquepeople <- interactions %>% 
  group_by(full_name, date_of_birth, sex) %>% 
  count()
#82900 people 

interactions %>%
  filter(str_detect(initial_statute, "4-5")) %>%
  group_by(full_name, date_of_birth, sex, offense_date, case_number, initial_statute) %>% 
  count() %>% 
  group_by(full_name, date_of_birth, sex) %>%
  count() %>% 
  group_by(full_name) %>% 
  count()
#259 people , that's 0.3124246


final_homeless %>%
  filter(str_detect(initial_statute, "4-5")) %>%
  group_by(full_name, offense_date, case_number) %>% 
  count() %>% 
  group_by(full_name) %>%
  count() 

#169 people of 729 - that'23%

#let's look at overall 'homeless charges'

interactions %>% 
  filter(initial_statute %in% homeless_crimes) %>% 
  group_by(full_name,date_of_birth, sex,  offense_date, case_number) %>% 
  count() %>% 
  group_by(full_name) %>%
  count() 
#979 people, that's 1.18%

final_homeless %>% 
  filter(initial_statute %in% homeless_crimes) %>% 
  group_by(full_name, offense_date, case_number) %>% 
  count() %>% 
  group_by(full_name) %>%
  count() 

#379 people, thats 52% .

masterdata %>% 
  filter(!is.na(sex), !is.na(date_of_birth)) %>% 
  filter(str_detect(initial_statute, "4-5")) %>%
  group_by(full_name,date_of_birth, sex,  offense_date, case_number) %>% 
  count() %>% 
  group_by(full_name) %>%
  count() %>% 
  filter(full_name %in% final_homeless$full_name)

#435 people st, of whom 179 are homeless people, that's 38%. overall ratio to all people in the data is 0.87%. 

#let's look at the same in st augustine only as it's city ordinance

masterdata %>% 
  filter(!is.na(sex), !is.na(date_of_birth)) %>% 
  filter(str_detect(initial_statute, "4-5"), jurisdiction == "st aug city - 1") %>%
  group_by(full_name,date_of_birth, sex,  offense_date, case_number) %>% 
  count() %>% 
  group_by(full_name) %>%
  count() %>% 
  filter(full_name %in% final_homeless$full_name)
#435 and 179

  masterdata %>% 
    filter(jurisdiction == "st aug city - 1") %>% 
    filter(!is.na(sex), !is.na(date_of_birth)) %>% 
    group_by(full_name, date_of_birth, sex) %>% 
    count()
#16453
  
  final_homeless %>% 
    filter(jurisdiction == "st aug city - 1") %>% 
    group_by(full_name) %>% 
    count()
  #470

#2.64% people in st augustine in crime data are charged with 4-5, 
  #among st augustine homeless people 92% people are charged with 4-5
  
####attorneys 
  
  final_homeless %>% 
   filter(!is.na(defense_attorney))   %>% 
    group_by(defense_attorney, full_name, offense_date, case_number) %>% 
    count() %>% 
    group_by(defense_attorney, full_name) %>%
    count() %>% 
    group_by(defense_attorney) %>% 
    summarise(total = n()) %>% 
    mutate(pct = total/sum(total, na.rm = T)*100) %>% 
    arrange(desc(total))
  
  final_homeless %>% 
    #filter(!is.na(prosecutor_attorney))   %>% 
    group_by(prosecutor_attorney, full_name, offense_date, case_number) %>% 
    count() %>% 
    group_by(prosecutor_attorney, full_name) %>%
    count() %>% 
    group_by(prosecutor_attorney) %>% 
    summarise(total = n()) %>% 
    mutate(pct = total/sum(total, na.rm = T)*100) %>% 
    arrange(desc(total))
  
  
  


