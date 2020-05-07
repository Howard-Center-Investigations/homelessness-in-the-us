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
# 
# masterdata %>% 
#   filter(str_detect(masterdata$initial_charge, "tresspass")|
#            str_detect(masterdata$initial_charge, "overnight")|
#            str_detect(masterdata$initial_charge, "over night")|
#            str_detect(masterdata$initial_charge, "loiter")|
#            str_detect(masterdata$initial_charge, "panhandling")|
#            str_detect(masterdata$initial_charge, "camping")|
#            str_detect(masterdata$court_charge, "tresspass")|
#            str_detect(masterdata$court_charge, "over night")|
#            str_detect(masterdata$court_charge, "overnight")|
#            str_detect(masterdata$court_charge, "loiter")|
#            str_detect(masterdata$court_charge, "panhandling")|
#            str_detect(masterdata$court_charge, "camping")|
#            str_detect(masterdata$filed_charge, "tresspass")|
#            str_detect(masterdata$filed_charge, "over night")|
#            str_detect(masterdata$filed_charge, "overnight")|
#            str_detect(masterdata$filed_charge, "loiter")|
#            str_detect(masterdata$filed_charge, "panhandling")|
#            str_detect(masterdata$court_charge, "camping")) %>%
#   group_by(initial_statute)%>% #change this also to court_statute and prosecute_statute
#   count()


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


#try to standardize charges 
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

anti_join(final_homeless, policedep, by = "full_name") %>% nrow()


#how to distinct people?----

namebday <- final_homeless %>% 
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

final_homeless %>% group_by(full_name, date_of_birth) %>% count() 
#went through them all we can use that as a unique ID, mutate bdays so we wouldn't have doubles


n_distinct(final_homeless$full_name) #makes sense because with grouping by bdays we get 734
##729full_names 

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


#2) is there difference in location----

final_homeless %>%
  group_by(jurisdiction) %>% 
  count() %>%
  arrange(desc(n)) 
#not so much 

#3) difference in dates-----
#we always group by offense year and case number to make sure every case 
#is counted once 

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

grid.arrange(plot1, plot2, plot3)
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

#5) difference in status---- 

final_homeless %>% 
  group_by(offense_date, charge_status) %>%
  summarise(n = n()) %>%
  group_by(charge_status) %>%
  summarise(n=n()) %>%
  mutate(percent = round(n/sum(n)*100,2))

#6) difference in total paid----
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

by_nr$total_paid <- as.integer(by_nr$total_paid) 
by_nr$balance_due <- as.integer(by_nr$balance_due) 

#create a wide df with all the information we're most interested in

owed_by_person <- by_nr %>%
  group_by(full_name) %>%
  summarise(all_fees = sum(total_owed, na.rm = TRUE), 
            all_paid = sum(total_paid , na.rm = TRUE), 
            all_balance = sum(balance_due, na.rm = TRUE)) %>%
  arrange(desc(all_fees)) %>% 
  inner_join(demographics, owed_by_person, by = "full_name") %>% 
  mutate(age = calc_age(date_of_birth)) %>%
  select(full_name, all_fees, all_paid, all_balance, everything())



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
  
#make a wider df  

owed_by_person_wider <- final_homeless %>% 
  group_by(offense_date, full_name, initial_charge, total_owed, total_paid, balance_due) %>% 
  count() %>% 
  unique() %>% 
  arrange(desc(total_owed), full_name)


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
  filter(initial_statute %in% homeless_crimes)
  group_by(offense_date, case_number, total_owed, total_paid, balance_due, full_name, release_date, receipt_date, first_offense_date, last_offense_date) %>% 
  count()

key_collision_merge(unique(final_homeless$initial_statute)) %>% View()

####CHARGES----

#group by statute numbers, but first need to standardize 

key_collision_merge(final_homeless$initial_statute) 
#key_collision_merge showed we can remove ((sab) and xb and xby and we need to change 5apr to 5-4)
 
final_homeless$initial_statute <- str_replace_all(final_homeless$initial_statute,
                 "\\(sab\\)| xb| xby",
                   "")
 
 final_homeless$initial_statute <- str_replace_all(final_homeless$initial_statute,
                                                   "5-apr", 
                                                   "5-4")
 
 final_homeless$court_statute <- str_replace_all(final_homeless$court_statute,
                                                   "\\(sab\\)", 
                                                   "")

 key_collision_merge(final_homeless$prosecute_statue) %>% 
   unique() 
 
 final_homeless$prosecute_statue <- str_replace_all(final_homeless$prosecute_statue,
                                                   "5-apr", 
                                                   "5-4")
write_rds(final_homeless, "final_homeless.rds")

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
  
  
  


