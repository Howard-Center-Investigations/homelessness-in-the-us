#### Work with TidyCensus to pull down variables
# Downloaded files are cleaned in cleaning.Rmd

### Load libraries
library(tidyverse)
library(tidycensus)

# View Census variables
# Function takes year and type (e.g. ACS or Decentennial)
v17 <- tidycensus::load_variables(2017, "acs5", cache = TRUE)


### Define variables
us <- unique(fips_codes$state)[1:51] # store vector with state fips codes (df loads with the tidycensus package)
years <- 2017 # store number or vector with years we want to gather (warning: each one takes a while, do in batches <= 3)
save_path <- paste0(here::here(), "/data/input-data/acs-downloads/")

### Tell Census.gov who you are with your user API key (set up at Census.gov)
census_api_key("549950d36c22ff16455fe196bbbd01d63cfbe6cf")

### Define function
# Get all ACS data for all [geography] in the states included in the "us" vector (defined above) at "year" vector/number (defined above). 
# Only need to rerun to change the geography or variable
get_all_acs <- function(y) { 
  map_df(us, function(x) {
    get_acs(geography = "tract", 
            year = y, 
            variables = c(total_population_count = "B01003_001",
                          total_pop_in_poverty_count = "B17001_002",
                          educational_attainment_count = "B15003_022", #Estimate!!Total!!Bachelor's degree EDUCATIONAL ATTAINMENT FOR THE POPULATION 25 YEARS AND OVER
                          unemployment_count = "B23025_005", #Estimate!!Total!!In labor force!!Civilian labor force!!Unemployed	
                          black_alone_or_combined_count = "B02001_003", #Estimate!!Total!!Black or African American alone	
                          monthly_housing_costs_median = "B25105_001", #Estimate!!Median monthly housing costs
                          housing_units_count = "B25001_001", #Estimate!!Total HOUSING UNITS
                          inequality_gini_derived = "B19083_001", #GINI INDEX OF INCOME INEQUALITY
                          veteran_count = "B21001_002", #Estimate!!Total!!Veteran	SEX BY AGE BY VETERAN STATUS FOR THE CIVILIAN POPULATION 18 YEARS AND OVER
                          occupancy_vacant_count = "B25002_003", #Estimate!!Total!!Vacant	OCCUPANCY STATUS
                          family_income_median = "B19119_001", #Estimate!!Total MEDIAN FAMILY INCOME IN THE PAST 12 MONTHS (IN 2017 INFLATION-ADJUSTED DOLLARS) BY FAMILY SIZE
                          gross_rent_sum = "B25063_001", #Estimate!!Total	GROSS RENT
                          gross_rent_median = "B25064_001", #Estimate!!Median gross rent MEDIAN GROSS RENT (DOLLARS)
                          gross_rent_sum_as_perc_of_income = "B25070_001", #Estimate!!Total	GROSS RENT AS A PERCENTAGE OF HOUSEHOLD INCOME IN THE PAST 12 MONTHS
                          gross_rent_median_as_perc_of_income = "B25071_001", #Estimate!!Median gross rent as a percentage of household income	MEDIAN GROSS RENT AS A PERCENTAGE OF HOUSEHOLD INCOME IN THE PAST 12 MONTHS (DOLLARS)
                          contract_rent_sum = "B25056_001", #Estimate!!Total CONTRACT RENT
                          contract_rent_median = "B25058_001", #Estimate!!Median contract rent	MEDIAN CONTRACT RENT (DOLLARS)
                          bedrooms = "B25041_001" #Estimate!!Total	BEDROOMS
            ),
            survey = "acs5", 
            state = x)
  })
}

### Use lapply to apply the function for all years defined above
# (Get a coffee while this runs, esp. if you have multiple years)
acs_vars <- lapply(years, get_all_acs)

### Convert the list to a data frame
# If you did multilpe years at once, you'll be working with a nested list and should call your list with list_name[number] (e.g. "acs_vars[1]") to get each year
# Years will be ordered left to right (e.g. for years[2013, 2014] acs_vars[1] will be 2013)
acs_vars_2017 <- map_df(acs_vars, ~as.data.frame(.x)) %>%
  dplyr::select(-c(moe, NAME)) %>%
  spread(variable, estimate)

write_csv(acs_vars_2017, paste0(save_path, "acs-vars-2017.csv"))

