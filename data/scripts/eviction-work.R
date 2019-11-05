#################
#### Setup ######
#################

### Load Packages

# Processing
library(tidyverse) # For tidy data analysis
library(here) # For consistent file pathing
library(ggplot2) # For plotting
library(aws.s3) # To access Amazon Web Services (see https://github.com/cloudyr/aws.s3)
# Uses tidycensus, must be installed not loaded
# Accesses data described at https://data-downloads.evictionlab.org/


# Set system environment to access AWS
Sys.setenv("AWS_ACCESS_KEY_ID" = "AKIA5Y3NHI6ME6UP3VZV", # Replace with your own
           "AWS_SECRET_ACCESS_KEY" = "p2b5XaWzRqo/iah1COSKNB3nslwbW91R8UHYBEf0", # Replace with your own
           "AWS_DEFAULT_REGION" = "us-east-1")

#################
### Functions ###
#################

# Function to iterate over all US states to download and store tract data for each
get_all_eviction <- function(geography = "tract", file_type = "csv", year_choice = 2016) {
  # Store vector holding all states (borrowing the tidycensus package)
  us <- unique(tidycensus::fips_codes$state)[1:51] 
  # Set variable to hold path to data
  path_to_aws <- "s3://eviction-lab-data-downloads/"
  # Set geography variable baased on user input
  if (geography == "block"){
    geography_path <- "/block-groups"
  }
  else if (geography == "city"){
    geography_path <- "/cities"
  }
  else if (geography == "county"){
    geography_path <- "/counties"
  }
  else if (geography == "state"){
    geography_path <- "/states"
  }
  else if (geography == "tract"){
    geography_path <- "/tracts"
  }
  # If geography type is not recognized, exit with an appropriate error.
  else{
    stop("Geography must be \'tract\' or \'city\'.")
  }
  # If file type is CSV
  if (file_type == "csv"){
    # Set file suffix
    file_suffix <- ".csv"
    # Build dataframe using each element in the US states list
    for (i in us) {
      # If dataframe exists, append new dataframe
      if (exists('x')) {
        # Import next state's data
        y <- read_csv(get_object(paste0(path_to_aws, i, geography_path, file_suffix))) %>% 
          filter(year == year_choice) %>%
          mutate_at('GEOID', as.character)
        # Bind the new to the previous
        x <- rbind(x, y) } 
      # Else create dataframe
      else {
        # Import first state's data
        x <- read_csv(get_object(paste0(path_to_aws, i, geography_path, file_suffix))) %>%
          filter(year == year_choice) %>%
          mutate_at('GEOID', as.character) }}
  }
  # If file type is JSON
  else if (file_type == "json"){
    # Set file suffix
    file_suffix <- ".geojson"
    # INCOMPLETE build GEOJSON object using each element in the US states list INCOMPLETE
    #for (i in us) {
    stop("Sorry, the GEOJSON feature is not ready yet.")
    # http://rstudio-pubs-static.s3.amazonaws.com/84577_d3eb8b4712b64dbdb810773578d3c726.html
    }
  # If file type is not recognized, exit with an appropriate error.
  else{
    stop("File Type must be \'csv\' or \'json\'.")
  }
  return(x)
}

#####################
### Download Data ###
#####################

# Only need to run this once

# Pull data from source
evictions_by_tract_2016 <- get_all_eviction() %>%
  dplyr::rename_all(tolower)

# Save to a local csv
write_csv(evictions_by_tract_2016, paste0(here(), "/data/input-data/evictions-by-tract-2016.csv"))


#################
### Load Data ###
#################

# Load the downloaded data
evictions_by_tract_2016 <- read_csv(paste0(here(), "/data/input-data/evictions-by-tract-2016.csv"))

# Load the crosswalk of tracts to CoCs
coc_tract_crosswalk <- read_csv(paste0(here(), "/data/input-data/clean/crosswalk-coc-to-tract.csv"))

####################
### Process Data ###
####################

# Join tract to CoC
evictions_with_coc_2016 <- evictions_by_tract_2016 %>%
  dplyr::rename_all(tolower) %>%
  left_join(coc_tract_crosswalk, by = c("geoid" = "tract_fips"))

# Collapse relevent eviction data into CoCs
evictions_by_coc_2016 <- evictions_with_coc_2016 %>%
  select("coc_code", "zillow_cluster_num", "state_code", "coc_name", ends_with("-rate"), 
         "median-household-income", "median-gross-rent", "rent-burden",
         "median-property-value") %>%
  group_by(coc_code, coc_name, state_code) %>%
  summarize_if(is.numeric, mean, na.rm = T) %>%
  mutate(
    `eviction-rate` = case_when(
      is.nan(`eviction-rate`) ~ NA_real_,
      T ~ `eviction-rate`),
    `eviction-filing-rate` = case_when(
      is.nan(`eviction-filing-rate`) ~ NA_real_,
      T ~ `eviction-filing-rate`),
    zillow_cluster_num = case_when(
      is.nan(`zillow_cluster_num`) ~ NA_real_,
      T ~ `zillow_cluster_num`)
  ) %>%
  # Make variable names friendly
  rename_all(~stringr::str_replace_all(., "-", "_"))

################################
### Explore problematic data ###
################################

# Clean up workspace
#rm(list=setdiff(ls(), c("evictions_by_coc_2016", "wk")))

# "Filing and eviction rates are calculated by dividing the number of filings or evictions in an area by the number of renter homes." Eviction Lab Methodology, p. 42

# View which GEOIDs didn't map to a CoC
wk <- evictions_by_coc_2016 %>%
  filter(is.na(coc_code)) %>%
  # Add col to designate state for grouping
  separate(`parent-location`, sep = ", ", into = c("county", "state_name"), remove = F) %>%
  select(state_name) %>%
  # By state
  group_by(state_name) %>%
  summarize(count_by_state = n()) %>%
  # And by county
  full_join(evictions_by_coc_2016 %>%
              filter(is.na(coc_code)) %>%
              select(`parent-location`) %>%
              group_by(`parent-location`) %>%
              summarize(count_by_county = n()) %>%
              separate(`parent-location`, sep = ", ", into = c("county", "state_name"), remove = F)
  ) %>%
  select(state_name, count_by_state, county, count_by_county) %>%
  arrange(desc(count_by_state))

# 453 out of 73,077
# New York	100
# Alabama	77
# Arkansas	50
# Florida	43
# Michigan	40
# Hawaii	22
# California	17
# Wisconsin	10
# fewer than 10...

################
### Analysis ###
################

wk <- evictions_by_coc_2016 %>%
  select(-zillow_cluster_num)

wk %>% write_csv(paste0(here(), "/data/output-data/evictions-coc.csv"))























