# ---
#   title: Ryan's script"
# author: "Ryan Little"
# date: "12/3/2019"
# output: html_document
# ---
#   
#   ## R Markdown
#   ```{r setup, include=FALSE}
# knitr::opts_chunk$set(echo = TRUE, message=FALSE, warning=FALSE, paged.print=TRUE)
# ```


## Load libraries


library(tidyverse)  # attaches purrr and readr
library(lubridate)
library(rvest)
library(downloader)
library(R.utils)
library(rlist)
library(here)
library(janitor)
library(scales)
library(ggrepel)
library(ggplot2)
library(here)
library(tidycensus)
library(ggthemes)
library(scales)
library(mapview)
library(here)
# library(fs)
# library(stringr)

# library(retrosheet)
# install.packages('retrosheet')
# devtools::install_github("rmscriven/retrosheet")

# Store census API key
census_api_key("2badea95d03037d0582d8c5ada5195100b1d92f6")


options(scipen=999)
```

```{r}

#clear environment for when I need it
rm(list = ls())


```


#Import and Clean Data

The data had to be downloaded by month by request of Okaloosa County Clerk. They said larger timeframes would tax their system. This means the data had to be downloaded by month, imported and binded together using a for loop.

```{r}
# list of file names
files <- c("0115", "0215", "0315", "0415", "0515", "0615", "0715", "0815", "0915", "1015", "1115", "1215","0116", "0216", "0316", "0416", "0516", "0616", "0716", "0816", "0916", "1016", "1116", "1216", "0117", "0217", "0317", "0417", "0517", "0617", "0717", "0817", "0917", "1017", "1117", "1217", "0118", "0218", "0318", "0418", "0518", "0618", "0718", "0818", "0918", "1018", "1118", "1218", "0118", "0218", "0318", "0418", "0518", "0618", "0718", "0818", "0918", "1018", "1118", "1218", "0119", "0219", "0319", "0419", "0519", "0619", "0719", "0819", "0919", "1019", "1119", "1219")

# creating empty tibble, changes to character were made playing wack-a-mole with binding errors
master_data <- read_csv(here("data", "0115.csv")) %>%
  clean_names() %>%
  filter(arrest_charge == "nothing") %>%
  mutate(actual_speed = as.character(actual_speed),
         blood_alcohol_level = as.character(blood_alcohol_level),
         commercial_vehicle = as.character(commercial_vehicle),
         haul_hazard = as.character(haul_hazard),
         obts_number = as.character(obts_number),
         vehicle_tag_expiration_year = as.character(vehicle_tag_expiration_year),
         prosecutor_charge_count = as.character(prosecutor_charge_count))


# importing, binding to empty data frame 
for (i in files) {
  #writing filepath
  name <- paste0(i, ".csv")
  filepath <- "data/"
  name_plus_filepath <- paste0(filepath,name)
  # importing and cleaning files to temp dataframe
  temp <- read_csv(name_plus_filepath) %>%
    clean_names()
  # changes to character were made playing wack-a-mole with binding errors
  temp <- temp %>%
    mutate(actual_speed = as.character(actual_speed),
           blood_alcohol_level = as.character(blood_alcohol_level),
           commercial_vehicle = as.character(commercial_vehicle),
           haul_hazard = as.character(haul_hazard),
           obts_number = as.character(obts_number),
           vehicle_tag_expiration_year = as.character(vehicle_tag_expiration_year),
           prosecutor_charge_count = as.character(prosecutor_charge_count))
  # binding temp to master_data
  master_data <- master_data %>%
    bind_rows(temp)
  # processing and clearing environment
  print(paste0("Done processing ", i))
  rm(temp)
  rm(name)
  rm(filepath)
  rm(name_plus_filepath)
}

rm(i)
rm(files)

# changing columns back to numerics, go lowercase
master_data <- master_data %>%
  mutate_all(tolower) %>%  
  mutate(actual_speed = as.double(actual_speed),
         blood_alcohol_level = as.double(blood_alcohol_level),
         commercial_vehicle = as.double(commercial_vehicle),
         haul_hazard = as.double(haul_hazard),
         obts_number = as.double(obts_number),
         vehicle_tag_expiration_year = as.double(vehicle_tag_expiration_year),
         prosecutor_charge_count = as.double(prosecutor_charge_count),
         case_open_date = mdy(case_open_date),
         case_close_date = mdy(case_close_date),
         disposition_date = mdy(disposition_date),
         date_of_birth = mdy(date_of_birth),
         offense_date = mdy(offense_date),
         arrest_date = mdy(arrest_date),
         arrest_month = month(arrest_date),
         arrest_year = year(arrest_date),
         offense_month = month(offense_date),
         offense_year = year(offense_date),
         total_assessed = as.numeric(total_assessed),
         balance = as.numeric(balance),
         total_paid = as.numeric(total_paid),
         obts_number = as.character(obts_number),
         arrest_charge_count = as.numeric(arrest_charge_count)) %>%
  filter(offense_year %in% c("2015", "2016", "2017", "2018", "2019"))

glimpse(master_data)
```

# Filtering for Homeless
Fort Walton Beach Police officer confirms that "General Delivery" is an address law enforcement agencies use when they arrest a homeless person. Fort Walton Beach uses "At Large."

```{r}

# creating a dataframe that only includes addresses that match those we know likely mean they are homeless
general_delivery <- master_data %>%
  filter(address %in% c("general delivery", "genral delivery", "at large", "genreal delivery", "general deliverly", "homeless", "gerneral delivery", "general deliver", "general delviery", "not listed", "general deivery", "grneral delivery", "428 mclaughlin ave", "307 harbor blvd", "183 eglin parkway ne", "117 windham ave", "300 miracle strip"))


#filter for list of defendants
homeless_names <- general_delivery %>%
  group_by(defendant) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges)) %>%
  select(defendant)

#left join with master_data frame to get every entry for each person who has a general delivery address at least once
homeless_data <- homeless_names %>%
  left_join(master_data)

rm(temp)

```

```{r}

# Okaloosa County Sheriff's Office report on its jail groups "loitering, public intoxication, obstruction of right of way, & mutual affray (fighting)" as " "Trespass / Public Nuisance". It seems like they are insinuating that these are a certain type of crimes. I think they are calling them homeless crimes. Reporting will have to confirm this. Nonetheles,s let's sort for only these crimes on our homeless dataframe and see what it looks like.

# Loitering = "810.09(2a)", "810.08(2a)", "810.02(4)"

# Panhandling/right of way = 316.130

# Disorderly intoxication = 856.011


# XXXXXXXXXXXXXXXXX

# There are additional laws that we know through other reporting that have been used to criminalize homelessness = 316.2045 

# I have chosen to filter the spreadsheet without the subsections of the laws here. To try and catch every occurence of the law I want, I am filtering broadly in this step, then filtering out laws I don't want at the end.
crimes <- c("316.130", "316.2045", "810.08", "810.09", "856.011")

crimes_data <- master_data %>%
  filter(arrest_charge == "nothing")

for (i in crimes) {
  temp <- master_data %>%
    filter(str_detect(arrest_charge, i))
  print(paste0("Finished filtering ", i))
  crimes_data <- crimes_data %>%
    bind_rows(temp)
}

rm(temp)
rm(crimes)
rm(i)

# writing my own operator
'%!in%' <- function(x,y)!('%in%'(x,y))

# filtering out crimes that don't fit the descripition
crimes_data <- crimes_data %>%
  filter(arrest_charge %!in% c("810.02(4)", "810.02(3c)", "810.02(3a)", "810.02(3b)", "810.02(2c2)", "810.02(2b)", "810.02(1)(b)(2)(a)"))

rm(temp)
rm(crimes)
rm(i)

# this searches for the one state law found unconstitutional
unconst <- master_data %>%
  filter(str_detect(arrest_charge, "316.2045"))
```

# Examing what the homeless are charged with most

```{r}
# creating a spreadsheet of all the charges filed against homeless people
homeless_charges <- homeless_data %>%
  group_by(arrest_charge, arrest_statute) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

#creating a spreadsheet of homeless people charged with crimes that criminalize homelessness
filtered_crimes <- crimes_data %>%
  filter(address %in% c("general delivery", "genral delivery", "at large", "genreal delivery", "general deliverly", "homeless", "gerneral delivery", "general deliver", "general delviery", "not listed", "general deivery", "grneral delivery", "428 mclaughlin ave", "307 harbor blvd", "183 eglin parkway ne", "	117 windham ave", "300 miracle strip"))

# homeless criminilzation charges and arrests
temp <- filtered_crimes %>%
  group_by(defendant, case_number) %>%
  summarise()
temp2 <- temp %>%
  group_by(defendant) %>%
  summarise(crim_cases = n())
temp3 <- filtered_crimes %>%
  group_by(defendant) %>%
  summarise(crim_charges = n())

#total arrests and charges
temp4 <- homeless_data %>%
  group_by(defendant, case_number) %>%
  summarise()
temp5 <- temp4 %>%
  group_by(defendant) %>%
  summarise(total_cases = n())
temp6 <- homeless_data %>%
  group_by(defendant) %>%
  summarise(total_charges = n())

# summarising court costs
temp7 <- filtered_crimes %>%
  group_by(defendant) %>%
  summarise(homeless_fines = sum(total_assessed))
temp8 <- homeless_data %>%
  group_by(defendant) %>%
  summarise(total_fines = sum(total_assessed))

# summarising fees paid
temp9 <-filtered_crimes %>%
  group_by(defendant) %>%
  summarise(homeless_paid = sum(total_paid))
temp10 <- homeless_data %>%
  group_by(defendant) %>%
  summarise(total_paid = sum(total_paid))



# joining everything together
impacts <- temp2 %>%
  left_join(temp3, by = "defendant") %>%
  left_join(temp5, by = "defendant") %>%
  left_join(temp6, by = "defendant") %>%
  left_join(temp7, by = "defendant") %>%
  left_join(temp8, by = "defendant") %>%
  left_join(temp9, by = "defendant") %>%
  left_join(temp10, by = "defendant") %>%
  mutate(other_fines = (total_fines - homeless_fines),
         other_cases = (total_cases - crim_cases),
         other_charges = (total_charges - crim_charges),
         other_paid = (total_paid - homeless_paid)) %>%
  select(defendant, crim_cases, crim_charges, homeless_fines, homeless_paid, other_cases, other_charges, other_fines, other_paid, total_fines, total_paid)



rm(temp, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10)

test <- filtered_crimes %>%
  filter(defendant == "kenneth ivan shultz iii") %>%
  mutate()



glimpse(filtered_crimes) 


```

```{r}

names <- as.list(homeless_names['defendant'])

for (i in names){
  
  filtered_crimes %>%
    filter(defendant == "kenneth ivan shultz iii") %>%
    select(arrest_date) %>%
    arrange(arrest_date) %>%
    filter(row_number()==1 | row_number()==n())
  
  
  print(paste0("Finished ", i))
  
}


```


```{r}

filtered_crimes %>%
  group_by(court_type) %>%
  summarise(count = n())


```

```{r}

temp <- filtered_crimes %>%
  group_by(arrest_charge, court_action) %>%
  summarise(count = n()) %>%
  
  
  
  rulings <- c("*adj w/h", "*guilty", "*p/t diversion", "*dismissed")

#for (i in rulings){
# name <- i

temp %>%
  filter(court_action == i) %>%
  ungroup
#}


```


```{r}

temp <- master_data %>%
  group_by(defendant, case_number) %>%
  summarise()
temp2 <- temp %>%
  group_by(defendant) %>%
  summarise(crim_cases = n())
temp3 <- master_data %>%
  group_by(defendant) %>%
  summarise(crim_cases = n())

temp4 <- temp2 %>%
  left_join(temp3, by = "defendant")

```

```{r}

temp10 <- master_data %>%
  filter(defendant == "jermaine oliver jones")

```



# Examining which LEO agencies charge more

We cannot sort criminalization by city for the cities where the Okaloosa Sheriff's Office is hired to act as the law enforcement organization in cities like Destin because it appears the sheriff's office rarely inputs the city in the jurisdiction when they make arrests there.

Given the size of the sheriff's office's jurisdiction, which includes other cities in addition to Destin, I would expect the sheriff's office to be charging homeless people with these crimes more than Fort Walton Beach if Destin is criminalizing homelessness more than Fort Walton Beach.

```{r}

temp <- master_data %>%
  group_by(arresting_agency) %>%
  summarise(total_count = n()) %>%
  mutate(temp = (total_count/99181)*100) %>%
  mutate(perc_of_total = round(temp, 2)) %>%
  select(-temp)

temp2 <- homeless_data %>%
  group_by(arresting_agency) %>%
  summarise(homeless_count = n()) %>%
  mutate(temp = (homeless_count/8533)*100) %>% 
  mutate(perc_of_homeless = round(temp, 2)) %>%
  select(-temp)

temp %>%
  full_join(temp2, by = "arresting_agency") %>%
  select(arresting_agency, perc_of_total, perc_of_homeless) %>%
  arrange(desc(perc_of_total))

rm(temp)
rm(temp2)

# Fort Walton Beach Police has the biggest change in their percentage of total charges in our database. FWB jumps from 12% to 19%. Okaloosa County Sheriff's Office also increases, but the increase is much lower. It increased from 66.5% to 67%. 

```

```{r}

# comparing the three rates of arrests
temp <- master_data %>%
  group_by(arresting_agency) %>%
  summarise(total_count = n()) %>%
  mutate(temp = (total_count/99181)*100) %>%
  mutate(perc_of_total = round(temp, 2)) %>%
  select(-temp)

temp2 <- homeless_data %>%
  group_by(arresting_agency) %>%
  summarise(homeless_count = n()) %>%
  mutate(temp = (homeless_count/8533)*100) %>% 
  mutate(perc_of_homeless = round(temp, 2)) %>%
  select(-temp)

temp3 <- crimes_data %>%
  group_by(arresting_agency) %>%
  summarise(crimes_count = n()) %>%
  mutate(temp = (crimes_count/2123)*100) %>% 
  mutate(perc_of_crimes = round(temp, 2)) %>%
  select(-temp)

temp <- temp %>%
  inner_join(temp2, by = "arresting_agency")

temp %>%
  inner_join(temp3, by = "arresting_agency") %>%
  select(arresting_agency, perc_of_total, perc_of_homeless, perc_of_crimes) %>%
  arrange(desc(perc_of_crimes))

rm(temp)
rm(temp2)
rm(temp3)

```

```{r}
# Only specific crimes
# c("316.130", "316.2045", "810.08", "810.09", "856.011"))

temp <- crimes_data %>%
  filter(str_detect(arresting_agency, "oka")) %>%
  group_by(arrest_charge) %>%
  summarise(sheriff_charges = n())

temp2 <- crimes_data %>%
  filter(str_detect(arresting_agency, "ft")) %>%
  group_by(arrest_charge) %>%
  summarise(fwb_charges = n())

temp %>%
  inner_join(temp2, by = "arrest_charge") %>%
  select(arrest_charge, fwb_charges, sheriff_charges) %>%
  mutate(temp = (fwb_charges + sheriff_charges)) %>%
  mutate(perc_sheriff = (sheriff_charges/temp)*100) %>%
  arrange(desc(perc_sheriff))


rm(temp)
rm(temp2)


```

```{r}

affray <- master_data %>%
  filter(str_detect(arrest_charge, "870.01"))


```

```{r}

# All homeless data

temp <- homeless_data %>%
  filter(str_detect(arresting_agency, "oka")) %>%
  group_by(arrest_charge) %>%
  summarise(sheriff_charges = n())

temp2 <- homeless_data %>%
  filter(str_detect(arresting_agency, "ft")) %>%
  group_by(arrest_charge) %>%
  summarise(fwb_charges = n())

temp %>%
  inner_join(temp2, by = "arrest_charge") %>%
  select(arrest_charge, fwb_charges, sheriff_charges) %>%
  mutate(temp = (fwb_charges + sheriff_charges)) %>%
  mutate(perc_sheriff = (sheriff_charges/temp)*100) %>%
  arrange(desc(sheriff_charges)) %>%
  select(-temp) 

rm(temp)
rm(temp2)


```






# BELOW IS CODE THAT WAS USED TO ANALYZE DATA TO IMPROVE CODE ABOVE THIS SUBHEAD

```{r}
# What are the different spellings for General Delivery in the dataset? Are there any other terms being used that might relate to homeless like At Large?
master_data %>%
  filter(!str_detect(address,"[:digit:]")) %>%
  group_by(address) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# GENERAL DELIVERY, GENRAL DELIVERY, AT LARGE, GENREAL DELIVERY, GENERAL DELIVERLY, HOMELESS, GERNERAL DELIVERY, GENERAL DELIVER, GENERAL DELVIERY, NOT LISTED. GENERAL DEIVERY, GRNERAL DELIVERY

# general delivery, genral delivery, at large, genreal delivery, general deliverly, homeless, gerneral delivery, general deliver, general delviery, not listed. general deivery, grneral delivery

# What is EXTENDED STAY AMERICA? C/O RIGHT WAY MINISTRIES? HOLIDAY LODGE? C/O FAMILIES FIRST NETWORK? CENTURY WORK CAMP? JOSEPH SHANE DEWS C/O PANAMA CITY RESCUE MISSION? SALVATION ARMY? NWF RECEPTION CENTER ANNEX? WATERFRONT MISSION?
```

```{r}

# This code was used to identify addresses that are associated with homelessness by identify the people who have been charged with crimes that can be used to criminalize homelessness, grouping by their address and counting the number of times that address has been identified

temp <- crimes_data %>%
  group_by(defendant) %>%
  summarise(count = n()) #%>%
#select(defendant)

not_homeless_names <- temp %>%
  anti_join(homeless_names)

yes_homeless_names <- temp %>%
  inner_join(homeless_names)

crimes_names <- temp %>%
  left_join(master_data)


temp <- master_data %>%
  filter(str_detect(defendant, "william curtis howard jr"))

temp2 <- master_data %>%
  filter(str_detect(address, "428 mclaughlin ave"))

temp3 <- crimes_data %>%
  filter(str_detect(address, "320 sims st"))

#Identifying addressess associated with homelessness

# 428 mclaughlin ave is owned by the First United Methodist Church of Crestview
# it was identified by sorting the list of names who have been charged with crimes that criminalize homelessness who did not match the list of names found by searching the list of terms like general delivery. William Curtis Howard Jr. had the most convictions of this list. Arrest records identify him as homeless. 
# this was the former location of Helping Hands, a shelter in Crestview
# 307 harbor blvd is owned by St. Andrew's Episcopal Church, home to The Blue Door, the only homeless ministry in Destin
# 2018 mm 004108 f, Billy Oscar Lane, was identified as homeless by address "at large" on his arrest record despite this address being listed in the court charge database
# 183 eglin parkway ne is the CoC's address


top_address <- not_homeless_names %>%
  inner_join(crimes_data) %>%
  group_by (address) %>%
  summarise (arrests = n())


```

```{r}


homeless_data %>%
  filter(str_detect(defendant, "wittman"))

# This confirms that at least one person known to be homeless -- reported homeless in the NWF Daily News -- was listed as "general delivery" in the database.
```

# Jurisdiction and city of general delivery addresses entries appear unreliable

```{r}

master_data %>%
  group_by(jurisdiction) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))

# The data for jursidiction seems wrong. A little more than 1% of the overall charges seems exceptionally low. It is likely that the sheriff's office is not properly listing the jurisdiction when they make arrests in Destin.

```

```{r}

master_data %>%
  filter(!str_detect(court_type, "traffic")) %>%
  group_by(jurisdiction) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))


```

```{r}

homeless_data %>%
  filter(str_detect(court_type, "traffic"))

```

```{r}

homeless_data %>%
  group_by(city) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))

# It seems unlikely that the city listed for anyone with a homeless address can be trusted as the place they are actually residing. 

```

```{r}

homeless_data %>%
  group_by(jurisdiction) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))

# When filtering for homeless, the percentage of Destin cases shrinks even further. The data shows, however, that the Okaloosa County Sheriff's Office is arresting homeless people more than Fort Walton Beach. They do have a larger jurisdiction, but you would expect to find more homeless in the two largest cities in the county.

```

```{r}

homeless_data %>%
  #filter(str_detect(arrest_charge, "856")) %>%
  group_by(arresting_agency, arrest_charge) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))

# 918.13 = tampering with or fabricating evidence
# 951.22 = contraband in county jail
# 943.0435(9) = sexual offenders required to register
# 901 = Judicial officers have committing authority.—Each state judicial officer is a conservator of the peace and has committing authority to issue warrants of arrest, commit offenders to jail, and recognize them to appear to answer the charge. He or she may require sureties of the peace when the peace has been substantially threatened or disturbed.

# 893.147(1) = sale controlled substances
# 893.13(6a) = sale controlled substances that could be legally obtained with a prescription (i.e. opioids)
# 893.13(6b) = possession cannabis less than 20 grams
# 893.12 = allows for seizure of illegal drugs

#856.011 = 

# 843.15(1b) = Failure of defendant on bail to appear for misdemeanor.
# 843.02 = Resisting officer without violence to his or her person.

# 832.05(2b) = Worthless check

# 831.02 = Uttering forged instruments.

# 812.014(2c1)(3a) = theft
# 812.019 = dealing in stolen property

# 810.09(2a) = Trespass on property other than structure or conveyance. trespass on property other than a structure or conveyance is a misdemeanor of the first degree, punishable as provided in s. 775.082 or s. 775.083.
# 810.08(2a) = Trespass in structure or conveyance.
# 810.02(4) = Felony trespass
# 806.12(1b2) = If the damage to such property is greater than $200 but less than $1,000, it is a misdemeanor of the first degree, punishable as provided 
# 806.13(1v3) = If the damage is $1,000 or greater, or if there is interruption or impairment of a business operation or public communication, transportation, supply of water, gas or power, or other public service which costs $1,000 or more in labor and supplies to restore, it is a felony of the third degree, punishable as provided in s. 775.082, s. 775.083, or s. 775.084.

# 790.23(1a) = felon and deliquents possesion of firearms
# 784.021(1a) = assault with a deadly weapon
# 784.03(1a1) = Felony battery, intentional strike
# 784.07(2b) = Misdemeanor battery
# 741.31(4a) = domestic violence injuction/order violation

# 539.011(8b8a) = A statement that the pledgor or seller of the item represents and warrants that it is not stolen, that it has no liens or encumbrances against it

#322.34(2c) = Driving with suspended license, felony because of third conviction
```



```{r}

crimes_data %>%
  filter(str_detect(arrest_charge, "810")) %>%
  filter(str_detect(arresting_agency, "ft")) %>%
  group_by(defendant) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))

```

```{r}

crimes_data %>%
  filter(str_detect(arrest_charge, "810.02")) %>%
  filter(str_detect(arresting_agency, "oka")) %>%
  group_by(defendant) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))

```

```{r}

crimes_data %>%
  filter(str_detect(arresting_agency, "oka"))%>%
  group_by(arrest_month) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))


```

```{r}

crimes_data %>%
  filter(str_detect(arrest_charge, "810.02")) %>%
  group_by(offense_month) %>%
  summarise(charges = n()) %>%
  arrange(desc(charges))


```

```{r}

test <- crimes_data %>%
  filter(str_detect(arrest_charge, "810.02")) %>%
  filter(offense_month == 3)

```

```{r}

temp <- crimes_data %>%
  filter(str_detect(arresting_agency, "oka")) %>%
  group_by(defendant, date_of_birth, arrest_charge) %>%
  summarise(charges = n()) %>%
  arrange(defendant)
temp %>%
  group_by(defendant, date_of_birth) %>%
  summarise(arrest_incidents = n(),
            total_charges = sum(charges)) %>%
  arrange(desc(arrest_incidents))

```


```{r}


master_data %>%
  filter(str_detect(defendant, "roy ronald rowell"))


```


```{r}
# attemptimg to see how many times someone has been arrested
temp <- crimes_data %>%
  filter(str_detect(arresting_agency, "ft")) %>%
  group_by(defendant, date_of_birth, arrest_charge) %>%
  summarise(charges = n()) %>%
  arrange(defendant)

temp %>%
  group_by(defendant, date_of_birth) %>%
  summarise(arrest_incidents = n(),
            total_charges = sum(charges)) %>%
  arrange(desc(arrest_incidents))

```


```{r}
# Looking up defense attorneys who have reprsented the most people with addresses listed as general delivery to source on background.

homeless_data %>%
  group_by(defense_attorney) %>%
  summarise(cases = n()) %>%
  arrange(desc(cases))

```
