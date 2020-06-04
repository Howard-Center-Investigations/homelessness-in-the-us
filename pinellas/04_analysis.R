#Riin Aljas
#aljasriin@gmail.com

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
library(spelling)
options(scipen = 999)

full_data <- readRDS("data/full_data.rds")
# full_data$offense_date <- mdy(full_data$offense_date)
# full_data$offense_year <- year(full_data$offense_date)
# saveRDS(full_data,"data/full_data.rds")
final_homeless <- readRDS("data/final_homeless.rds") %>%
  filter(offense_year<2020, offense_year>2014)

narrow_final_homeless <- readRDS("data/narrow_final_homeless.rds")

source("analysis/03_helper_functions.R")

## 
#it's impossible to check out all false positives one by one
##did it for two full days, still two many 
#we create a separate df to take out people who doesn't have 
#a clear homeless address(word in it) %>% and who have no 
#'homeless' charges 
homelesspatterns <- c("INTOXICATED|INTOXICATION|DISORDERLY INTOXICATION |BEGGIN|SOLICT|SOLICIA|SOLICA|TRESPASS|TRESPASSING |TRESPASS |TRES|TREP |NIGHTTIME HOURS |OPEN HOURS|CLOSE HOURS|BEING AT |BEING IN |RECLINING ON|TRES |UNLAWFUL CONSUMPTION|PARK OPEN|PARK HOUR|LOITERING|PUBLIC CONSUMPTION|TRESP|PARK HOURS|DRINK|URINAT|CAMPING|OPEN ALCOHOL|ALCOHOL|SLEEP|URINATION|SOLICIT|PANHANDL|TRESSP|OPEN CONTAINER|OPEN CONT|OPEN CONTAINER|OPEN ALCOHOL|OPEN HOURS|AFTER")


homelessforsure <- final_homeless %>% 
  filter(str_detect(final_homeless$loopaddress, "TRANSIENT|TRANIENT|GENERALDELIVERY|DELVERY|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")|
           str_detect(final_homeless$address_line_number_1,  "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")|
           str_detect(final_homeless$address_line_number_2, "TRANSIENT|TRANIENT|GENERALDELIVER|DELIVERY|DELIEVRY|DELIEVEY|HOMELES|ANYWHERE")) %>% 
  unique()

homelesscharges <- final_homeless %>% 
  filter(str_detect(offense, homelesspatterns))

narrow_final_homeless <- final_homeless %>% 
  filter(full_name %in% homelesscharges$full_name)

narrow_final_homeless <- bind_rows(narrow_final_homeless, 
                                   homelessforsure) %>% 
  unique()
saveRDS(narrow_final_homeless,"data/narrow_final_homeless.rds")
##DEMOGRAPHIC ANALYSIS with 2015-2019 df

narrow_final_homeless <- readRDS("data/narrow_final_homeless.rds")

##1) age----

age <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, age) %>% 
  count() 
summary(age$age)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#   18.00   35.00   46.00   45.87   56.00  90.00       2
narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, age) %>% 
  count() %>% 
  summary()
##2) gender----

narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, sex) %>% 
  count() %>%  
  group_by(sex) %>% 
  count()

# 1 F      807
# 2 M      3773
# 3 NA       15

##3) race----

narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, race) %>% 
  count() %>% 
  group_by(race) %>% 
  count()
# A tibble: 8 x 2
# Groups:   race [8]
# race      n
# <chr> <int>
#   1 A     21
# 2 B      849
# 3 I       5
# 4 O        8
# 5 S       100
# 6 U       141
# 7 W      3248
# 8 NA       23

##4) charges---- 

by_offenses <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, case_number, offense_date, offense) %>% 
  count() %>% 
  group_by(full_name) %>% 
  count() %>% 
  arrange(desc(n))
# 
summary(by_offenses$n)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   1.000   3.000   6.148   7.000 155.000 

by_arrests <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, arrest_date_of_arrest) %>% #, arrest_statute) %>% 
  count() %>% 
  group_by(full_name) %>% 
  count() %>% 
  arrange(desc(n))
summary(by_arrests$n)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.000   1.000   2.000   4.094   4.000  94.000 
narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth, offense_date, offense) %>% 
  group_by(offense) %>% 
  count() %>% 
  arrange(desc(n))


narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year < 2020) %>% 
  group_by(full_name, date_of_birth) %>% 
  count()


##EMPLOYMENT----
#where do homeless people work who have jobs 
homeless_employed <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year <2020) %>% 
  group_by(full_name, date_of_birth, employment) %>% count() %>% 
  group_by(full_name, employment) %>% count()

workplaces <- homeless_employed %>% 
  group_by(employment) %>% 
  count()

###DISPOSITION TYPE----
narrow_final_homeless %>%
  filter(offense_year > 2014, offense_year <2020) %>% 
  group_by(full_name, date_of_birth, case_number, disposition_type) %>% 
  count() %>% 
  group_by(disposition_type) %>% 
  summarise(total = n(), 
            pct = total/nrow(narrow_final_homeless)*100) %>% 
  arrange(desc(total))
#26.4% are 	
# NO TRIAL - ADJUDICATED GUILTY

# 17.1
# NO TRIAL - ADJ GUILTY (ORD/INFRACTION)  
#   

####EXAMINE STATUTES 

statutes <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year <2020) %>%
  group_by(full_name, date_of_birth, offense_date, case_number, disposition_statute) %>% 
  count() %>% 
  group_by(disposition_statute) %>% 
  count() %>% 
  arrange(desc(n))





###sentence type
#we group first by case_number and sentence type, because usually one case gets one sentence
narrow_final_homeless %>%
  filter(offense_year > 2014, offense_year <2020) %>% 
  group_by(case_number, sentence_type) %>% 
  count() %>% 
  group_by(sentence_type) %>% 
  summarise(total = n(), 
            pct = total/nrow(narrow_final_homeless)*100) %>% 
  arrange(desc(total))

#21.8% are fine/and court costs only, 12.4% are incarceration and served time 11.1%

#write a data frame to see how it depends on the offense 

narrow_final_homeless %>%
  filter(offense_year > 2014, offense_year <2020) %>% 
  group_by(case_number, sentence_type, disposition_statute) %>% 
  count() %>% 
  group_by(disposition_statute, sentence_type) %>% 
  summarise(total = n()) %>% View()
##fix above


narrow_final_homeless %>% 
  filter(offense_year <2020, 
         offense_year >2014) %>%
  filter(disposition_statute %in% c("1", "2", "3", "4", "5")) %>% 
  count(offense,city) %>% view()


uniqueoffense <- narrow_final_homeless$offense %>% 
  unique() %>% 
  View()



#we can't use unique statutes nor offense, hence try to create a homelesscharge tag 
homelesspatterns <- c("INTOXICATED|INTOXICATION|DISORDERLY INTOXICATION |BEGGIN|SOLICT|SOLICIA|SOLICA|TRESPASS|TRESPASSING |TRESPASS |TRES|TREP |NIGHTTIME HOURS |OPEN HOURS|CLOSE HOURS|BEING AT |BEING IN |RECLINING ON|TRES |UNLAWFUL CONSUMPTION|PARK OPEN|PARK HOUR|LOITERING|PUBLIC CONSUMPTION|TRESP|PARK HOURS|DRINK|URINAT|CAMPING|OPEN ALCOHOL|ALCOHOL|SLEEP|URINATION|SOLICIT|PANHANDL|TRESSP|OPEN CONTAINER|OPEN CONT|OPEN CONTAINER|OPEN ALCOHOL|OPEN HOURS|AFTER")

narrow_final_homeless %>% 
  filter(!str_detect(offense, homelesspatterns)) %>% 
  count(offense) %>% 
  view()

narrow_final_homeless %>% 
  filter(!str_detect(arrest_offense_literal, homelesspatterns)) %>%
  count(arrest_offense_literal) %>% 
  view()

narrow_final_homeless$homeless_arrest <- if_else((str_detect(narrow_final_homeless$arrest_offense_literal, homelesspatterns)== T), 
           "homeless arrest", 
           "other offense")
narrow_final_homeless$homeless_offense <- if_else(str_detect(narrow_final_homeless$offense, homelesspatterns)== T,
                                           "homeless offense",
                                           "other offense")

#now that we have homeless charge tag we can look into it



narrow_final_homeless %>% 
  filter(offense_year<2020, offense_year>2014) %>% 
  group_by(full_name, case_number, offense_date, offense_year) %>% 
  group_by(offense_year) %>% 
  count() %>% 
  ggplot()+
  geom_line(mapping = aes(offense_year, n))
#all offenses 
full_data %>% 
  filter(offense_year<2020, offense_year>2014) %>% 
  group_by(full_name, case_number, offense_date, offense_year) %>% 
  group_by(offense_year) %>% 
  count() %>% 
  ggplot()+
  geom_line(mapping = aes(offense_year, n))
                                          
#all wo homeless

full_data %>% 
  anti_join(narrow_final_homeless, by = c("full_name", 
                                          "loopaddress")) %>% 
  filter(offense_year<2020, offense_year>2014) %>% 
  group_by(full_name, case_number, offense_date, offense_year) %>% 
  group_by(offense_year) %>% 
  count() %>% 
  ggplot()+
  geom_line(mapping = aes(offense_year, n))












  alloffenses <- full_data %>% 
    group_by(full_name, date_of_birth, case_number, offense_date, offense_year, offense) %>% 
    count() %>% 
    group_by(offense_year) %>% 
    count()
  allofenses20152019 <- alloffenses %>% 
    filter(offense_year<2020, offense_year>2014)
  
  all_fin_hom_offenses <- final_homeless %>% 
    group_by(full_name, date_of_birth, case_number, offense_date, offense_year, offense) %>% 
    count() %>% 
    group_by(offense_year) %>% 
    count()
  
  final_homeless %>% 
    filter(homeless_offense == "homeless offense") %>% 
    group_by(full_name, case_number, offense_date, date_of_birth, offense_year, offense) %>% 
    count() %>% 
    group_by(offense, offense_year) %>% 
    count() %>% View()

  
 temp <- final_homeless %>% 
    group_by(full_name, case_number, offense_date, offense_year, homeless_offense) %>% 
    group_by(offense_year, homeless_offense) %>% 
    count() 
    
    ggplot()+
    geom_line(mapping = aes(temp$offense_year, temp$n, color= temp$homeless_offense))+
    geom_line(mapping = aes(allofenses20152019$offense_year, allofenses20152019$n))+
    geom_line(mapping = aes(all_fin_hom_offenses$offense_year, all_fin_hom_offenses$n))
  
    
#why are there so many cocaine charges?

cocaine <- final_homeless %>% 
  filter(offense == "POSSESSION OF COCAINE") 

final_homeless %>% 
  filter(full_name %in% cocaine$full_name) %>% 
  group_by(offense) %>% 
  count() %>% View()

bynameoffense <- final_homeless %>% 
  group_by(full_name, offense) %>% 
  count()

onlyone <- bynameoffense %>%
  group_by(full_name) %>% 
  count() %>% 
  filter(n<2)

#1661 people of over 4984 only one offense, are they really homeless?

final_homeless %>% 
  filter(full_name %in% onlyone$full_name) %>% 
  group_by(loopaddress) %>% 
  count() %>% 

final_homeless <- readRDS("data/final_homeless.rds")
names_out <- read_csv("data/namesout.csv") %>% unique()
names_out$middle_name <- names_out$middle_name %>% trimws()
names_out$full_name <- paste(names_out$first_name, names_out$middle_name, names_out$last_name)

final_homeless <- subset(final_homeless, !(full_name %in% names_out$full_name))
saveRDS(final_homeless, "data/final_homeless.rds")
n_distinct(final_homeless$full_name) 


names_out %>% filter(full_name %in% final_homeless$full_name) %>% view()
final_homeless$full_name <- final_homeless$full_name %>% trimws()
final_homeless$middle_name <- final_homeless$middle_name %>% trimws()
saveRDS(final_homeless, "data/final_homeless.rds")
final_homeless$full_name <- paste(final_homeless$first_name, final_homeless$middle_name, final_homeless$last_name)
final_homeless <- subset(final_homeless, !(full_name %in% names_out$full_name))
saveRDS(final_homeless, "data/final_homeless.rds")

final_homeless$first_name <- final_homeless$first_name %>% trimws()
final_homeless$middle_name <- final_homeless$middle_name %>% trimws()
final_homeless$last_name <- final_homeless$last_name %>% 
  trimws()
final_homeless <- final_homeless %>% 
  mutate(full_name = paste(first_name, 
                           middle_name, 
                           last_name))
saveRDS(final_homeless, "final_homeless.rds")



 
  
  
  
  
  
  
  
  
  




final_homeless %>% 
  subset(!(full_name %in% homelesscharges$full_name)) %>%
  group_by(loopaddress, full_name) %>%
  count() %>% 
  group_by(loopaddress) %>% 
  count() %>% 
  View()



###standardize offenses a little bit 


narrow_final_homeless <- readRDS("data/narrow_final_homeless.rds")
narrow_final_homeless %>% 
  group_by(offense) %>% 
  count() %>% 
  view()

narrow_final_homeless$offense <- narrow_final_homeless$offense %>% trimws()

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense =  (if_else(str_detect(offense, "DRINK|BEER|ALC|ALCOHOL|OPEN COT|OPEN  ALC|OPEN  CONT|OPENER|OPEN ALCOHOL|BEVERAGE|CONSUM|OPEN CAN|OPEN CON|CONATAINER|OEPN|OPEN ALCHOL|OPEN CONATINER|OPEN ALOCHOL|OPEN ALOHOL|OPEN ALCOHO|OPEN CONTAINER|OPEN CONTAINER OF ALCOHOL|OPEN ALCOHOL|OPEN CONT|CONAINER|OPEN ALCHOHOL|OPEN ALCOHOL") == T,
                                  "OPEN CONTAINER", 
                                  offense)))
narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(offense,
                                            "TRASP|TRESP|TRES|TRESS|TREP|TREA") == T,
                                  "TRESPASSING",
                                  stand_offense))
narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                          "PANH|PANDH|PANDAH|PAN HA|PANDAND") == T,
                               "PANHANDLING",
                               stand_offense))

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "SOLI|SOLC| SOLI") == T,
                                 "SOLICITING",
                                 stand_offense))

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "DISORDERLY IN") == T,
                                 "DISORDERLY INTOXICATION",
                                 stand_offense))

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "URIN") == T,
                                 "URINATING",
                                 stand_offense))

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "SLEEP|CAMPI") == T,
                                 "SLEEPING/CAMPING IN PUBLIC",
                                 stand_offense))
narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "RESISTING|RESIS|REIST|OBSTRUCT") == T,
                                 "OBSTRUCTING OR RESISTING OFFICER WITHOUT VIOLENCE",
                                 stand_offense))

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "IN A PARK|PARK CLOSE|COUNTY PARK|PARKK|AND PARK|RECREATIONAL PARK|PARK HOUSE|PARKS CLOSING|PARKS USE|PARK VIOLATION|PARK USE|PARK CLOSING|IN PARK|PARK HOUR|CITY PARK|PARK AFTER|PARK OPEN") == T,
                                 "VIOLATION IN A PARK",
                                 stand_offense))

narrow_final_homeless <- narrow_final_homeless %>% 
  mutate(stand_offense = if_else(str_detect(stand_offense,
                                            "PARAPH") == T,
                                 "POSSESSION OF PARAPHERNALIA",
                                 stand_offense))
                                           
narrow_final_homeless$stand_offense <- narrow_final_homeless$stand_offense %>% trimws()         
         
narrow_final_homeless %>% group_by(stand_offense) %>% count() %>% view()   
narrow_final_homeless$stand_offense %>% unique() %>% view()

saveRDS(narrow_final_homeless, "data/narrow_final_homeless.rds")
###NOISE----
x <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year<2020) %>% 
  group_by(full_name, offense_date, offense, date_of_birth, case_number) %>% 
  summarise(total= n()) %>% 
  group_by(full_name, date_of_birth, offense_date, offense) %>% 
  count() %>% 
  group_by(full_name, date_of_birth) %>% 
  summarise(total = sum(n())) %>% 
  ungroup() %>% 
  select(-date_of_birth) %>% 
  arrange(desc(total))

y <- narrow_final_homeless %>% 
  filter(offense_year > 2014, offense_year<2020) %>% 
  group_by(full_name, offense_date, date_of_birth, case_number) %>% 
  summarise(total= n()) %>%
  group_by(full_name, date_of_birth, offense_date) %>%
  count() %>% 
  group_by(full_name, date_of_birth) %>% 
  summarise(total = sum(n())) %>%
  select(-date_of_birth) %>% 
  arrange(desc(total))

missing <- anti_join(y,x)

####JOIN FINES----
fines <- readRDS("pinellas_data.rds")



narrow_final_homeless <- readRDS("data/narrow_final_homeless.rds")

narrow_final_homeless<- left_join(narrow_final_homeless, fines, by = "case_number")


narrow_final_homeless$to_pay <-narrow_final_homeless$to_pay %>% 
  str_replace_all(",", "") %>% 
  trimws() %>% 
  str_replace_all("\\s", "") %>% 
  as.numeric()

narrow_final_homeless$balance <-narrow_final_homeless$balance %>% 
  str_replace_all(",", "") %>% 
  trimws() %>% 
  str_replace_all("\\s", "") %>% 
  as.numeric()

narrow_final_homeless$paid<-narrow_final_homeless$paid %>% 
  str_replace_all(",", "") %>% 
  trimws() %>% 
  str_replace_all("\\s", "") %>% 
  as.numeric()

  
saveRDS(narrow_final_homeless, "narrow_final_homeless.rds")
narrow_final_homeless %>%
  filter(offense_year>2014, offense_year<2020) %>% 
  group_by(full_name, date_of_birth, case_number,to_pay, balance) %>% 
  count() %>% 
  group_by(full_name, date_of_birth) %>% 
  summarise(total_to_pay = sum(to_pay), 
            total_balance = sum(balance)) %>% 
  arrange(desc(total_to_pay)) %>% 
  view()
          