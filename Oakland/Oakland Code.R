## Install packages
library(tidyverse)

#helps with cleaning data 
library(janitor)

library(lubridate)
# Read in oakland data, read_csv is "a bit smarter" than read.csv

oakdata <- read_csv("oaklanddata.csv")

# Look at columns to see how each variable is interpreted (factors, characters, dates, 
#etc.) problem is that date was read in as a character, not a date 
glimpse(oakdata)

# Cleaning 
#this makes the names lowercase, seperates the date variable base don where there is a space
#changes the date character strong into a month-day-year date, and then pulls out the year
#in a seperate column 

#didn't work :round_date(date, "month") #gives error "subcript out of bounds" 

oakdata <- oakdata %>%
  clean_names() %>%
  separate(datetimeinit, c("date", "time", "am_pm"), sep=" ") %>%
  mutate(date = mdy(date)) %>%
  mutate(year = year(date)) %>%
  mutate(month= month(date)) %>%
  separate(reqaddress, c("latitude", "longitude"), sep=" ")
  

oakdata$month_yr <- format(as.Date(oakdata$date), "%Y-%m")

#remove commas and parentheses 
oakdata$latitude <- substring(oakdata$latitude, 2,11)
oakdata$longitude<- substring(oakdata$longitude, 1, 12)

options(digits=11)
oakdata$latitude <- as.numeric(as.character(oakdata$latitude))
options(digits=12)
oakdata$longitude <- as.numeric(as.character(oakdata$longitude))
glimpse(oakdata)




#Identify pertinent variables 
issue<- oakdata$description

reqcategory<- oakdata$reqcategory

#this is too messy- need to find a way to group some addresses together based on proximity 

#Counts/Descriptions
library (plyr)
library(dplyr)

#count based on one variable


issuecount = count(oakdata, "oakdata$description")
categorycount = count(oakdata, "oakdata$reqcategory")
yearcount= count(oakdata, "oakdata$year")

#not including 2020 because only january and february right now 
completeyears <- oakdata %>%
  filter(year != "2020" )
monthcount = count(completeyears, "completeyears$month")


#new dataframe with only homeless encampment data 
he_data <- oakdata %>% 
  filter(oakdata$description == "Homeless Encampment")

he_completeyears<- he_data %>%
  filter(year != "2020")

he_year= count(he_data, "he_data$year")

he_month = count(he_data, "he_data$month")

he_month_yr = count(he_data, "he_data$month_yr")


#many more homeless reports in july, august, sept, than jan, feb, march, april 


#graph data on homeless encampments over the years 
month_year<- he_month_yr$`he_data$month_yr`

library(ggplot2)

heyear<- he_year$he_data.year
heyearcount<- he_year$freq
plot(x=heyear,
     y= heyearcount,
     type = "b",
     xlab="Year",
     ylab="# of Homeless Encampment Reports",
     main="Homeless Encampment Reports: Oakland 2009-2020",
     xlim = c(2009, 2020),
     ylim = c(0, 3500),
     col="steelblue")

library(chron)

#graph data on homeless encampments by month-year date 

install.packages("zoo")
library(zoo)
he_over_month_yr <- read.zoo(he_month_yr, FUN= as.yearmon)
plot (he_over_month_yr,
      xlab= "Month-Year",
      ylab= "# of Homeless Encampment Reports",
     main="Homeless Encampment Reports: Oakland 2009-2020",
     col = "steelblue") 

# had a hard time converting "month_yr" to date format, so I took the shortcut above
# to get the graph, below are my failed attempts 
#as.Date(as.yearmon(he_month_yr$he_data.month_yr))
#parse_date_time(he_month_yr$he_data.month_yr, "ym")
#glimpse(he_month_yr) #month_yr still in character format 


#mapping the data 

#testing out some leaflet functions
#library (leaflet)
#testmap <- leaflet() %>%
  #addTiles() %>%  # Add default OpenStreetMap map tiles
 #setView(lng=37.813, lat=-122.288, zoom =12)
#testmap

#split the lat/long coordinates into seperate columns in the initial function at the 
#top of the script 


library(leaflet)
#map of all homeless encampment reports 
he_data_map<- leaflet(data = he_data) %>% 
  addTiles() %>%
  addMarkers(~longitude, ~latitude)
# 2363 missing or invalud lat/lon values- may want to skim data to make sure this 
#sounds right
he_data_map


addTiles(he_data_map,
         urlTemplate = "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
         attribution = NULL, layerId = NULL, group = NULL,
         options = tileOptions(), data = he_data)

#are the (30, 140) coordinates mistakes?
#removing them and the NA coordinates
#only filtering out the <37 latitudes also filtered out the outlier longitudes

he_data_cleaned <- he_data %>%
  filter(latitude > 37)

#cleaned map of all homeless encampment reports 
he_data_map_cleaned<- leaflet(data = he_data_cleaned) %>% 
  addTiles() %>%
  addMarkers(~longitude, ~latitude)
he_data_map_cleaned


#trying to get all the data onto one map in different colors 
getColor <- function(he_data_cleaned) {
  sapply(he_data_cleaned$year, function(year) {
    if(year = 2009) {
      "green"
    } else if(year = 2010) {
      "orange"
    } else {
      "red"
    } })
}

getColor <- function(he_data_cleaned) {
  sapply(he_data_cleaned$year, function(year) {
    if(year = 2009) {
      "green"
    } else if(year = 2010) {
      "blue"
    } else if(year = 2011) {
      "orange"
    } else if(year = 2012) {
      "yellow"
    } else if(year = 2013) {
      "red"
    } else if(year = 2014) {
      "black"
    } else if(year = 2015) {
      "pink"
    } else if(year = 2016) {
      "green"
    } else if(year = 2017) {
      "white"
    } else if(year = 2018) {
      "purple"
    } else if(year = 2019) {
      "gray"
    } else if(year = 2020) {
      "brown"
    } })
}


icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(he_data_cleaned)
)

he_by_year_map<- leaflet(he_data_cleaned) %>% addTiles() %>%
  addAwesomeMarkers(~long, ~lat, icon=icons, label=~as.character(year))

#divide the homeless encampment data by year 
he_2009<- he_data_cleaned %>%
  filter(year == "2009")
he_2010<- he_data_cleaned %>%
  filter(year == "2010")
he_2011<- he_data_cleaned %>%
  filter(year == "2011")
he_2012<- he_data_cleaned %>%
  filter(year == "2012")
he_2013<- he_data_cleaned %>%
  filter(year == "2013")
he_2014<- he_data_cleaned %>%
  filter(year == "2014")
he_2015<- he_data_cleaned %>%
  filter(year == "2015")
he_2016<- he_data_cleaned %>%
  filter(year == "2016")
he_2017<- he_data_cleaned %>%
  filter(year == "2017")
he_2018<- he_data_cleaned %>%
  filter(year == "2018")
he_2019<- he_data_cleaned %>%
  filter(year == "2019")
he_2020<- he_data_cleaned %>%
  filter(year == "2020")

#Map of 2019 homeless encampments 
he_2019_map<-leaflet(data = he_2019) %>% 
  addTiles() %>%
  addMarkers(~longitude, ~latitude)
he_2019_map

#heat map of 2019 homeless encampments ?

#map of 2009 homeless encampments 
he_2009_map<- leaflet(data = he_2009) %>% 
  addTiles() %>%
  addMarkers(~longitude, ~latitude)
he_2009_map

#Goal: create a map that shows each year of data as a layer that a user can easily control 

experiment_map<- leaflet() %>%
  addTiles() %>%
  addMarkers(data = he_2019, group = "2019") %>%
  addMarkers(data = he_2014, group = "2014") %>%
  addMarkers(data = he_2009, group = "2009")
experiment_map

experiment_map_2 <- leaflet() %>%
  # Base groups
  addTiles() %>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  # Overlay groups
  addCircles(~long, ~lat, ~10^mag/5, stroke = F, group = "Quakes") %>%
  addPolygons(data = outline, lng = ~long, lat = ~lat,
              fill = F, weight = 2, color = "#FFFFCC", group = "Outline") %>%
  # Layers control
  addLayersControl(
    baseGroups = c("OSM (default)", "Toner", "Toner Lite"),
    overlayGroups = c("Quakes", "Outline"),
    options = layersControlOptions(collapsed = FALSE)
  )
map

#Goal: have data show up when you click and/or hover over a point 
#what data do i want to show up though?

#Goal: match each call to a census tract by matching the lat/long values
# assign each call to a census tract 
library(sf)
library(tidycensus)   
library(tigris)


# select only homeless encampments, longitude, latitude
#he_location_data <- he_data %>%
  #select( latitude, longitude)

#ca <- tidycensus::get_acs(state = "CA", geography = "tract",
                         # variables = "B19013_001", geometry = TRUE)

#code from stack overflow https://stackoverflow.com/questions/52248394/get-census-tract-from-lat-lon-using-tigris
#ca_tracts <- tracts("CA", class = "sf") %>%
  #select(GEOID, TRACTCE)

#bbox <- st_bbox(ca_tracts)
#?st_bbox

#my_points <- data.frame(
  #x = runif(200000, bbox[1], bbox[3]),
  #y = runif(200000, bbox[2], bbox[4])
#) %>%
  # convert the points to same CRS
  #st_as_sf(coords = c("x", "y"),
           #crs = st_crs(ca_tracts))

#my_points_tract <- st_join(my_points, ca_tracts)

#another tactic 
#?tracts
#CA FIPS code = 06

#CA<- tracts(state = "06") %>%
  #st_as_sf()

#CA_join <- st_join(he_data, CA)
#?st_join

#class(he_data)
#he_data_expmt <- he_location_data %>% 
 # st_as_sf(he_location_data, coords= c("latitude", "longitude"))

#another tactic 
#library(devtools)
#he_data$census_code <-  apply(he_location_data, 2, function(column) call_geolocator_latlon(c('lat'), c('long')))
#?apply
#call_geolocator_latlon(he_data$latitude, he_data$longitude)

#call_geolocator_latlon(lat,long)

#he_data_expmt <- he_data %>% 
  #filter(is.na(latitude) == F & is.na(longitude) == F) %>% 
  #st_as_sf(coords= c("latitude", "longitude"))

#?data.frame
#lat<- he_data

#he_data$census_code <- apply(he_data, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude']))
#?apply
#?row


#another tactic 

#this data frame gives the GEOID, Tract ID, etc 
#CA <- tracts(state = 06)
#CA <- st_as_sf(CA)

#plot(CA)

#CA<- CA%>%
 # clean_names() 

#clean the lat lon columns
#names(CA)[11] <- "latitude"
#names(CA)[12] <- "longitude"
#CA$latitude <- substring(CA$latitude, 2,11)
#glimpse(CA)


#options(digits=5)
#CA$latitude <- substring(CA$latitude, 1,11)
#CA$latitude <- as.numeric(as.character(CA$latitude))
#options(digits=8)
#CA$longitude <- substring(CA$longitude, 1,8)
#CA$longitude <- as.numeric(as.character(CA$longitude))


#now we need to match up this data with the oakland homeless data 
# the struggle will be getting the digits in each latitude column to match. the CA data 
#has 7 digits 
#it appears there are no matches.... 

#only use three digits of long/lat 
#he_tract_data<- merge(he_datamerge_test, CA, by = c("latitude" = "latitude", "longitude" = "longitude"))
#there are matches! roughly 11,000 in the initial homeless encampment data and roughly 117 matches 


#trying to map the CA census tracts
#back to square 1

library(tigris)
library(acs)
library(stringr) # to pad fips codes

?tracts
tracts(state= "CA")
tracts <- tracts(state = 'CA', county= '001')

api.key.install(key="YOUR API KEY")


#using geo locator function but with the data by year so that it will work 

glimpse(coord_2009)

?group_by

coord_2009 <- he_2009 %>%
  mutate(GEOID = apply(he_2009, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

#coord_2009_test<- coord_2009%>%
 # count("GEOID")
#?lapply
#coord_2009[, .(count = .N, var = sum(VAR)), by = GEOID]
#coord_2009[, .N, by=.(GEOID)]

coord_2010 <- he_2010 %>%
  mutate(GEOID = apply(he_2010, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2011 <- he_2011 %>%
  mutate(GEOID = apply(he_2011, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2012 <- he_2012 %>%
  mutate(GEOID = apply(he_2012, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2013 <- he_2013 %>%
  mutate(GEOID = apply(he_2013, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2014 <- he_2014 %>%
  mutate(GEOID = apply(he_2014, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2015 <- he_2015 %>%
  mutate(GEOID = apply(he_2015, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2016 <- he_2016 %>%
  mutate(GEOID = apply(he_2016, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2017 <- he_2017 %>%
  mutate(GEOID = apply(he_2017, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2018 <- he_2018 %>%
  mutate(GEOID = apply(he_2018, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2019 <- he_2019 %>%
  mutate(GEOID = apply(he_2019, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

coord_2020 <- he_2020 %>%
  mutate(GEOID = apply(he_2020, 1, function(row) call_geolocator_latlon(row['latitude'], row['longitude'])))

#saving the global environment 

save.image(file='oakenvironment.RData')

#combinging all geolocated homeless ancampments data again
#checked- 10870 rows which is what the original he_data_cleaned dataset had 
he_with_geoid<- rbind(coord_2009, coord_2010, coord_2011, coord_2012, coord_2013, coord_2014,
            coord_2015, coord_2016, coord_2017, coord_2018, coord_2019, coord_2020)

#get rid of the last four digits so it matches the gentrification data 
he_with_geoid$GEOID<- substring(he_with_geoid$GEOID, 1,11)
glimpse(he_with_geoid)
        
#Importing Gentrification data:
gentdata<- read_csv("US_tr_GentDecline.csv")

#filter out for oakland 
gentdata<- gentdata%>%
  filter(CountyName== "Alameda County")

#add column showing percent change in number of low income people 
gentdata$'% expansion'<- gentdata$StrongExpansionDecline/gentdata$TotPop16
gentdata$percent_expansion<-NULL

gentdatasimple<- gentdata%>%
  select(GEOID, StrongExpansionDecline, TotPop16, '% expansion')

#all homeless encampment data matched with gentrification data- the rows without lat/long
#values are tracts that didn't have any homeless encampments called in them 
#may want to make sure this makes sense 
he_gent<-full_join(gentdata, he_with_geoid, by = "GEOID")

#counts of how many homeless reports happened in each GEOID 
geoid_counts<- count(he_gent, "GEOID")

#all homeless encampment data matched with gentrification data- only GEOIDs with reports 
he_gent2<-left_join(he_with_geoid, gentdata, by ="GEOID")

he_gent3<- inner_join(he_with_geoid, gentdata, by = "GEOID")

#have to eliminate the last four numbers of the GEOID in order to macth to gentdata- 
#11 numbers specifies census tract, the extra four are for block(unnecessary i think)
coord_2009_tract<- coord_2009
coord_2009_tract$GEOID<- substring(coord_2009_tract$GEOID, 1,11)
coord_2009_count<- count(coord_2009_tract, "GEOID")
names(coord_2009_count)[2] <- "freq 2009"

coord_2019_tract<- coord_2019
coord_2019_tract$GEOID<- substring(coord_2019_tract$GEOID, 1,11)
coord_2019_count<- count(coord_2019_tract, "GEOID")
names(coord_2019_count)[2] <- "freq 2019"

count_09_19<- full_join(coord_2009_count, coord_2019_count, by = "GEOID")
#make NA values 0
count_09_19[is.na(count_09_19)] <- 0

#one way we could get around the baseline 0 issue:
#count_09_19[is.na(count_09_19)] <- 0.00000000000000000000001

count_09_19$'change in calls'<- count_09_19$`freq 2019`-count_09_19$`freq 2009`
count_09_19$'%change in calls'<- (count_09_19$'change in calls'/count_09_19$`freq 2009`)



#table with only certain variables

#so only 113/361 census tracts have reported calls 
#there is one census tract that shows up in our data but not in the gent data
#seems like a mistake: 06013353001 should probably be "060013353001" to follow th pattern
#manually fix it ?
he_gent_combined<- full_join(count_09_19, gentdatasimple, by ="GEOID")
names(he_gent_combined)[6] <- "StrongExpDec"

#some findings- homeless calls in only 25 tracts in 2009  ->  113 tracts in 2019 
#(including the same 25)

plot(he_gent_combined$`%change in calls`, he_gent_combined$`% expansion`, xlab = 
       "% Change in Homeless Encampment Calls 2009-2019", ylab = 
       "% Change in Low Income Pop 2000-2016")

ggplot(he_gent_combined, aes(x = '% change in calls', y = 
                               '% expansion')) +geom_point()

#hard to read a lot form this map because so much has changed over the 2009-2019 period- 
#encampment calls have increased in every single tract, and it's hard to distill that
#data in this scatterplot and with only 2 years 