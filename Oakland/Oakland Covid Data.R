#looking for covid patterns in the oakland data 

# Install packages
library(tidyverse)
library(janitor)
library(lubridate)
# Read in oakland data, read_csv is "a bit smarter" than read.csv

newoakdata <- read_csv("oaklanddatauptoapril20.csv")

# Cleaning 
#this makes the names lowercase, seperates the date variable base don where there is a space
#changes the date character strong into a month-day-year date, and then pulls out the year
#in a seperate column 

newoakdata <- newoakdata %>%
  clean_names() %>%
  separate(datetimeinit, c("date", "time", "am_pm"), sep=" ") %>%
  mutate(date = mdy(date)) %>%
  mutate(year = year(date)) %>%
  mutate(month= month(date)) %>%
  separate(reqaddress, c("latitude", "longitude"), sep=" ")


newoakdata$month_yr <- format(as.Date(newoakdata$date), "%Y-%m")

#remove commas and parentheses 
newoakdata$latitude <- substring(newoakdata$latitude, 2,11)
newoakdata$longitude<- substring(newoakdata$longitude, 1, 12)

#Counts/Descriptions
library (plyr)
library(dplyr)


#new dataframe with only homeless encampment data 
he_data_covid <- newoakdata %>% 
  filter(newoakdata$description == "Homeless Encampment")

he_march_data<- he_data_covid%>%
  filter(he_data_covid$month== "3")

he_march= count(he_data_covid, "year")

he_covid<- he_data_covid %>%
  filter(year == "2020")

he_month_yr_covid = count(he_covid, "he_covid$month_yr")


#graph data on homeless encampments over 2020
month_year<- he_month_yr$`he_data$month_yr`

library(ggplot2)

install.packages("zoo")
library(zoo)
he_over_month_yr <- read.zoo(he_month_yr_covid, FUN= as.yearmon)
plot (he_over_month_yr,
      xlab= "Month-Year",
      ylab= "# of Homeless Encampment Reports",
      main="Homeless Encampment Reports: Oakland 2020",
      col = "steelblue") 
   
he_over_month_yr <- read.zoo(he_month_yr_covid, FUN= as.yearmon)
plot (he_march_data,
      xlab= "date",
      ylab= "# of Homeless Encampment Reports",
      main="Homeless Encampment Reports: Oakland 2020",
      col = "steelblue") 


