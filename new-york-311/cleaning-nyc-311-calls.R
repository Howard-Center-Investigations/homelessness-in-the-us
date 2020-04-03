# Cleaning nyc-311 data

library(tidyverse)
library(janitor)
library(data.table)
library(lubridate)
library(ggplot2)
library(dplyr)

#library(tidyr)
#library(disk.frame)
#library(bit64)

## Cleaning Work
### Column Names

##Load the csv in chunks, clean names, maniuplate date_time columns into separate year, month, and time columns

ccolumns <- list("Unique Key", "Created Date", "Closed Date", "Agency", "Agency Name", "Complaint Type", "Descriptor", "Location Type", "Incident Zip", "Incident Address", "Street Name", "Cross Street 1", "Cross Street 2", "Intersection Street 1", "Intersection Street 2", "Address Type", "City", "Landmark", "Facility Type", "Status", "Due Date", "Resolution Description", "Resolution Action Updated Date", "Community Board", "BBL", "Borough", "X Coordinate (State Plane)", "Y Coordinate (State Plane)", "Open Data Channel Type", "Park Facility Name", "Park Borough", "Vehicle Type", "Taxi Company Borough", "Taxi Pick Up Location", "Bridge Highway Name", "Bridge Highway Direction", "Road Ramp", "Bridge Highway Segment", "Latitude", "Longitude", "Location")

#coltypess <- c("double", "date", "date", "text", "text", "text", "text", "text", "double", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "date", "text", "date", "text", "double", "text", "double", "double", "text", "text", "text", "text", "text", "text", "text", "text", "text", "text", "double", "double", "double")

#col_datetime(format = "%m/%d/%Y %I:%M:%S %p")



### Read in CSV 1 million lines at a time, save as RDS


#########################
##### First Million #####
#########################

sskip = 1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_01 <- read_csv("/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_01$dates <- as.Date(nyc_calls_01$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_01, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_01.Rds")




#########################
######Second Million#####
#########################

sskip = 1e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_02 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ") 
   
   nyc_calls_02$dates <- as.Date(nyc_calls_02$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_02, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_02.Rds")



########################
#####Third Million######
########################

sskip = 2e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_03 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ") 
   
   nyc_calls_03$dates <- as.Date(nyc_calls_03$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_03, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_03.Rds")



#########################
#### Fourth Million #####
#########################

sskip = 3e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_04 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_04$dates <- as.Date(nyc_calls_04$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_04, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_04.Rds")



#########################
##### Fifth Million #####
#########################

sskip = 4e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_05 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_05$dates <- as.Date(nyc_calls_05$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_05, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_05.Rds")


#########################
####### 6 Million #######
#########################

sskip = 5e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_06 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_06$dates <- as.Date(nyc_calls_06$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_06, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_06.Rds")




#########################
####### 7 Million #######
#########################

sskip = 6e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_07 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_07$dates <- as.Date(nyc_calls_07$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_07, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_07.Rds")




#########################
####### 8 Million #######
#########################

sskip = 7e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_08 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_08$dates <- as.Date(nyc_calls_08$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_08, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_08.Rds")




#########################
####### 9 Million #######
#########################

sskip = 8e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_09 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_09$dates <- as.Date(nyc_calls_09$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_09, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_09.Rds")



#########################
####### 10 Million ######
#########################

sskip = 9e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_10 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_10$dates <- as.Date(nyc_calls_10$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_10, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_10.Rds")



#########################
###### 11 Million #######
#########################

sskip = 1e7 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_11 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_11$dates <- as.Date(nyc_calls_11$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_11, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_11.Rds")





#########################
###### 12 Million #######
#########################

sskip = 11e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_12 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_12$dates <- as.Date(nyc_calls_12$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_12, "~/GitHub/homelessness-in-the-us/new-york-311//NYC-311-Service-Requests_12.Rds")






#########################
###### 13 Million #######
#########################

sskip = 12e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_13 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_13$dates <- as.Date(nyc_calls_13$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_13, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_13.Rds")




#########################
##### 14 Million #####
#########################

sskip = 13e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_14 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_14$dates <- as.Date(nyc_calls_14$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_14, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_14.Rds")




#########################
##### 15 Million #####
#########################

sskip = 14e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_15 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_15$dates <- as.Date(nyc_calls_15$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_15, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_15.Rds")

#########################
###### 16 Million #######
#########################

sskip = 15e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_16 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_16$dates <- as.Date(nyc_calls_16$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_16, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_16.Rds")



#########################
###### 17 Million #######
#########################

sskip = 16e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_17 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_17$dates <- as.Date(nyc_calls_17$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_17, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_17.Rds")



#########################
##### 18 Million #####
#########################

sskip = 17e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_18 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_18$dates <- as.Date(nyc_calls_18$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_18, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_18.Rds")



#########################
###### 19 Million #######
#########################

sskip = 18e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_19 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_19$dates <- as.Date(nyc_calls_19$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_19, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_19.Rds")




#########################
###### 20 Million #######
#########################

sskip = 19e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_20 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_20$dates <- as.Date(nyc_calls_20$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_20, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_20.Rds")



#########################
##### 21 Million #####
#########################

sskip = 2e7 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_21 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_21$dates <- as.Date(nyc_calls_21$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_21, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_21.Rds")




#########################
###### 22 Million #######
#########################

sskip = 21e6 +1
nn_max = 0

while(nn_max < 1e6) {  
   #22.4e6 is the total number of rows in the dataset
   
   nn_max = nn_max + 100000
   
   nyc_calls_22 <- read_csv("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", col_names = as.character(ccolumns), col_types = cols(.default = col_character()), n_max = nn_max, skip = sskip) %>%
      clean_names() %>%
      separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
      separate("dates", c("month", "day", "year"), remove=FALSE) %>%
      unite("time", "hour":"AM/PM", sep = " ")
   
   nyc_calls_22$dates <- as.Date(nyc_calls_22$dates, format = "%m/%d/%Y")
   
   sskip = sskip + 100000
}

#save as Rds(for faster processing)
saveRDS(nyc_calls_22, "~/GitHub/homelessness-in-the-us/new-york-311/NYC-311-Service-Requests_22.Rds")


########################
########Bind Em#########
########################

#bind RDS files to an all in one list
#all_nyc_calls <- mget(ls(pattern = "calls_[0-9]{2}"))
#saveRDS(all_nyc_calls, "~/GitHub/homelessness-in-the-us/new-york-311/ALL-NYC-311-Service-Requests.Rds")

memory.limit(size = 40000)

##load all call sheets
require(data.table)
folder <- "C:/Users/TDiff/Documents/GitHub/homelessness-in-the-us/new-york-311/"
files = list.files(path = folder, pattern = 'NYC-311-Service-Requests_[0-9]{2}.Rds$')
all_calls_list <- lapply(file.path(folder, files), function (x) data.table(readRDS(x)))

#if want to bind all
#all_nyc_calls = rbindlist(all_calls_list, fill = TRUE)

#
empty_frame <- c(all_calls_list[[1]][0])

#get column names
ccolumns2 <- colnames(all_calls_list[[1]])

filter_for_year <- function(filter_year) {
  
  #create empty df with appropriate column names
  empty_frame <- c(all_calls_list[[1]][0])
  
   for (sheet in all_calls_list) {
      #filter sheet based on filter year
      subset <- sheet %>%
         filter(year == filter_year)
      #order sheet
      subset[order(subset$month, subset$day, subset$time),]
      #assign filtered rows to empty dataframe
      empty_frame <- bind_rows(empty_frame, subset)
   }
   
   #save dataframe with filtered rows as RDS
   saveRDS(empty_frame, paste0("~/GitHub/homelessness-in-the-us/new-york-311/", filter_year, "-NYC-Service-Requests.Rds"))
   #return the created data frame 
   return(assign(paste0("calls_", filter_year), empty_frame, envir = parent.frame()))
}

all_years = paste0("20", 10:20)
for (year in all_years) {
  filter_for_year(year)
}

##########################
###For Loops to Read In###
##########################

#i want to look at each sheet in turn
for (sheet in all_nyc_calls) 
   {
   #find out what years are included in sheet
   all_years = paste0("20", 10:20)
   for (year1 in all_years) 
      {
      empty_frame <- data.frame(matrix(ncol=length(ccolumns), nrow=0))
      colnames(empty_frame) <- ccolumns
      }
   years_list = unique(sheet$year)
   #for each year included I want to:
   for (year2 in years_list) 
      {
      #filter the sheet based on the year
      x <- sheet %>%
         filter(year == year2)
      x[order(x$month, x$day, x$time),]
      #assign filtered rows to dataframes named for each year
      rbind(paste0("calls_", year1==year2), x)
      }
   }

#############################
####Filter based on Year#####
#########Long Form###########
#############################

#2011
calls_2011 <- all_nyc_calls %>%
   filter(year == 2011) 
calls_2011[order(calls_2011$month, calls_2011$day, calls_2011$time),]
saveRDS(calls_2011, "~/GitHub/homelessness-in-the-us/new-york-311/2011-NYC-Service-Requests.Rds")

#2012 
calls_2012 <- all_nyc_calls %>%
   filter(year == 2012) 
calls_2012[order(calls_2012$month, calls_2012$day, calls_2012$time),]
saveRDS(calls_2012, "~/GitHub/homelessness-in-the-us/new-york-311/2012-NYC-Service-Requests.Rds")

#2013
calls_2013 <- all_nyc_calls %>%
   filter(year == 2013) 
calls_2013[order(calls_2013$month, calls_2013$day, calls_2013$time),]
saveRDS(calls_2013, "~/GitHub/homelessness-in-the-us/new-york-311/2013-NYC-Service-Requests.Rds")

#2014
calls_2014 <- all_nyc_calls %>%
   filter(year == 2014) 
calls_2014[order(calls_2014$month, calls_2014$day, calls_2014$time),]
saveRDS(calls_2014, "~/GitHub/homelessness-in-the-us/new-york-311/2014-NYC-Service-Requests.Rds")

#2015
calls_2015 <- all_nyc_calls %>%
   filter(year == 2015) 
calls_2015[order(calls_2015$month, calls_2015$day, calls_2015$time),]
saveRDS(calls_2015, "~/GitHub/homelessness-in-the-us/new-york-311/2015-NYC-Service-Requests.Rds")

#2016
calls_2016 <- all_nyc_calls %>%
   filter(year == 2016) 
calls_2016[order(calls_2016$month, calls_2016$day, calls_2016$time),]
saveRDS(calls_2016, "~/GitHub/homelessness-in-the-us/new-york-311/2016-NYC-Service-Requests.Rds")

#2017
calls_2017 <- all_nyc_calls %>%
   filter(year == 2017) 
calls_2017[order(calls_2017$month, calls_2017$day, calls_2017$time),]
saveRDS(calls_2017, "~/GitHub/homelessness-in-the-us/new-york-311/2017-NYC-Service-Requests.Rds")

#2018
calls_2018 <- all_nyc_calls %>%
   filter(year == 2018) 
calls_2018[order(calls_2018$month, calls_2018$day, calls_2018$time),]
saveRDS(calls_2018, "~/GitHub/homelessness-in-the-us/new-york-311/2018-NYC-Service-Requests.Rds")

#2019
calls_2020 <- all_nyc_calls %>%
   filter(year == 2019) 
calls_2019[order(calls_2019$month, calls_2019$day, calls_2019$time),]
saveRDS(calls_2019, "~/GitHub/homelessness-in-the-us/new-york-311/2019-NYC-Service-Requests.Rds")

#2020
calls_2020 <- all_nyc_calls %>%
   filter(year == 2020) 
calls_2020[order(calls_2020$month, calls_2020$day, calls_2020$time),]
saveRDS(calls_2020, "~/GitHub/homelessness-in-the-us/new-york-311/2020-NYC-Service-Requests.Rds")


##############################################
#############DISK FRAME ATTEMPT###############
##############################################

##Try Loading Data with disk.frame

#set up disk.frame so it can use multiple CPUS
#setup_disk.frame()

# this allows large datasets to be transferred between sessions
#options(future.globals.maxSize = Inf)

#disk.frame is an r package that will apparently load big sets of data more quickly because it makes use of multiple processors and then saves the chunks as lists in .fts files. When the file is worked on (i.e. filter, summarise), the output is a data frame
#all_nyc_calls <- csv_to_disk.frame("~/GitHub/homelessness-in-the-us/new-york-311/NYC_311_Service_Requests_from_2010_to_Present.csv", in_chunk_size = 1e6, colClasses = list(character=c("Unique Key", "Created Date", "Closed Date", "Agency", "Agency Name", "Complaint Type", "Descriptor", "Location Type", "Incident Zip", "Incident Address", "Street Name", "Cross Street 1", "Cross Street 2", "Intersection Street 1", "Intersection Street 2", "Address Type", "City", "Landmark", "Facility Type", "Status", "Due Date", "Resolution Description", "Resolution Action Updated Date", "Community Board", "BBL", "Borough", "X Coordinate (State Plane)", "Y Coordinate (State Plane)", "Open Data Channel Type", "Park Facility Name", "Park Borough", "Vehicle Type", "Taxi Company Borough", "Taxi Pick Up Location", "Bridge Highway Name", "Bridge Highway Direction", "Road Ramp", "Bridge Highway Segment", "Latitude", "Longitude", "Location"))) 

#getting errors here
#all_nyc_calls %>%
#   janitor::make_clean_names() %>%
#   separate(created_date, c("dates", "hour", "AM/PM"), " ") %>%
#   separate("dates", c("month", "day", "year"), remove=FALSE) %>%
#   unite("time", "hour":"AM/PM", sep = " ")


### Create disk.frame for each year, filtered from all NYC calls

#Currently getting errors bc clean names and separate aren't working
#Filter all calls for each year and save disk.frame

#2010
#calls_2010 <- all_nyc_calls %>%
#   collect() %>%
#   filter(year==2010) %>%
#   group_by(month, day, time)

#calls_2010[order(calls_2010$month, calls_2010$day, calls_2010$time),]
#write_disk.frame(calls_2010, "~/GitHub/homelessness-in-the-us/new-york-311/2010-NYC-Service-Requests.df")

#2011
#calls_2011 <- all_nyc_calls %>%
#   filter(year == 2011) 
#calls_2011[order(calls_2011$month, calls_2011$day, calls_2011$time),]
#write_disk.frame(calls_2011, "~/GitHub/homelessness-in-the-us/new-york-311/2011-NYC-Service-Requests.df")

#2012 
#calls_2012 <- all_nyc_calls %>%
#   filter(year == 2012) 
#calls_2012[order(calls_2012$month, calls_2012$day, calls_2012$time),]
#write_disk.frame(calls_2012, "~/GitHub/homelessness-in-the-us/new-york-311/2012-NYC-Service-Requests.df")

#2013
#calls_2013 <- all_nyc_calls %>%
#   filter(year == 2013) 
#calls_2013[order(calls_2013$month, calls_2013$day, calls_2013$time),]
#write_disk.frame(calls_2013, "~/GitHub/homelessness-in-the-us/new-york-311/2013-NYC-Service-Requests.df")

#2014
#calls_2014 <- all_nyc_calls %>%
#   filter(year == 2014) 
#calls_2014[order(calls_2014$month, calls_2014$day, calls_2014$time),]
#write_disk.frame(calls_2014, "~/GitHub/homelessness-in-the-us/new-york-311/2014-NYC-Service-Requests.df")

#2015
#calls_2015 <- all_nyc_calls %>%
#   filter(year == 2015) 
#calls_2015[order(calls_2015$month, calls_2015$day, calls_2015$time),]
#write_disk.frame(calls_2015, "~/GitHub/homelessness-in-the-us/new-york-311/2015-NYC-Service-Requests.df")

#2016
#calls_2016 <- all_nyc_calls %>%
#   filter(year == 2016) 
#calls_2016[order(calls_2016$month, calls_2016$day, calls_2016$time),]
#write_disk.frame(calls_2016, "~/GitHub/homelessness-in-the-us/new-york-311/2016-NYC-Service-Requests.df")

#2017
#calls_2017 <- all_nyc_calls %>%
#   filter(year == 2017) 
#calls_2017[order(calls_2017$month, calls_2017$day, calls_2017$time),]
#write_disk.frame(calls_2017, "~/GitHub/homelessness-in-the-us/new-york-311/2017-NYC-Service-Requests.df")

#2018
#calls_2018 <- all_nyc_calls %>%
#   filter(year == 2018) 
#calls_2018[order(calls_2018$month, calls_2018$day, calls_2018$time),]
#write_disk.frame(calls_2018, "~/GitHub/homelessness-in-the-us/new-york-311/2018-NYC-Service-Requests.df")

#2019
#calls_2019 <- all_nyc_calls %>%
#   filter(year == 2019) 
#calls_2019[order(calls_2019$month, calls_2019$day, calls_2019$time),]
#write_disk.frame(calls_2019, "~/GitHub/homelessness-in-the-us/new-york-311/2019-NYC-Service-Requests.df")