Load Required Packages
----------------------

``` r
library(tidyverse) # Tidy data processing
library(janitor) # Data cleaning
library(readxl) # Read Excel files
library(data.table) # For the %like% function
library(knitr) # Process R Markdown
library(naniar) # For inputting NAs (replace_with_na_all)
library(here) # For consistent file pathing
```

Define Paths and Other Useful Variables
---------------------------------------

This code assumes use of .Rproj for file pathing. If experiencing
difficulties, ensure project “homelesness-project-fall2019” is open.

``` r
# Set paths to files
load_path <- paste0(here(), "/data/input-data/")
save_path <- paste0(here(), "/data/input-data/clean/")

# List of CoCs that have merged over the years, according to 2007-2018-PIT-Counts-by-CoC.xlsx "CoC Mergers" sheet
# Removed CA-527 from this list because it was only problematic prior to 2011
problematic_cocs <- c("AR-502", "AR-506",   "AR-507",   "AR-509",   "AR-510",   "AR-511",   "AR-512",   "CA-605",   "CA-610",   "CT-500",   "CT-501",   "CT-502",   "CT-504",   "CT-506",   "CT-507",   "CT-508",   "CT-509",   "CT-510",   "CT-511",   "CT-512",   "FL-516",   "IL-505",   "IN-500",   "IN-501",   "KS-500",   "LA-504",   "LA-508",   "MA-512",   "MA-513",   "MA-518",   "MA-520",   "ME-501",   "ME-502",   "MI-520",   "MI-521",   "MI-522",   "MI-524",   "MN-507",   "MN-510",   "MN-512",   "MO-601",   "MO-605",   "NC-508",   "NC-512",   "NC-514",   "NC-515",   "NC-517",   "NC-518",   "NC-519",   "NC-520",   "NC-521",   "NC-522",   "NC-523",   "NC-524",   "NC-525",   "NC-526",   "NE-503",   "NE-504",   "NE-505",   "NE-506",   "NJ-505",   "NJ-517",   "NJ-518",   "NJ-519",   "NJ-520",   "NY-502",   "NY-509",   "NY-515",   "NY-517",   "NY-521",   "NY-524",   "NY-605",   "OR-504",   "PA-507",   "PA-602",   "PR-501",   "PR-504",   "PR-510",   "SC-504",   "TN-505",   "TX-501",   "TX-504",   "TX-602",   "TX-608",   "TX-610",   "TX-612",   "TX-613",   "TX-616",   "TX-623",   "TX-702",   "TX-703",   "TX-704",   "VA-509",   "VA-510",   "VA-512",   "VA-517",   "VA-518",   "VA-519",   "WA-506",   "WA-507") %>%
  lapply(tolower)

# List of CoCs that did not have complete information stored for the years we examined
incomplete_cocs <- c("ar-504", "ar-508", "ca-527", "ca-528", "ca-529", "ca-530", "ga-502", "ga-508", "ma-501", "nj-512", "ny-506")
```

Load and Clean Data
-------------------

### HUD PIT Data

#### Sourced From:

-   The U.S. Department of Housing and Urban Development takes Point in
    Time (PIT) counts of the homeless population yearly for many
    Continuums of Care (CoCs), and bi-yearly for the remainder. \[FLAG
    ADD LINK\]

#### Used for:

-   Counts of homelessness in each CoC across the years

#### Notes:

-   Although data is available as far back as 2007, experts we spoke
    with agree the data becomes increasingly less reliable the farther
    back in time one looks. We felt confident using data from 2011
    onward.
-   With the exception of Arkansas, all CoC mergers are reflected
    backards in PIT stats. \[CONFIRMED Snow and Byrne\]
-   Arkansas made changes to its CoC without notifying HUD (according to
    Snow), thereby making its CoC statistics inconsistent in earlier
    years. With our decision not to import data prior to 2011, only the
    CoCs AR-507 and AR-512 remained problematic. To avoid confusion, we
    chose to drop them from our table.
-   Early joins of HUD PIT data and Zillow Cluster study data showed the
    following discrepencies:
    -   The following CoCs were **in the HUD PIT file but not in the
        Zillow file**. Therefore, we therefore chose to remove all
        except al-505 from our dataset.
        -   al-505: this CoC is the only one that did not coincide with
            incomplete data on itself. Byrne said there were some
            problems matching the .shp tracts against the CoCs. That may
            explain this CoC. \[FLAG MAKE DECISION\]
        -   ar-504, ar-508
        -   ca-527, ca-529, ca-530, ca-528: ca-527 was problematic prior
            to 2010, which is probably why Zillow dropped it.
        -   ga-502, ga-508
        -   ma-501
        -   nj-512
        -   ny-506
    -   Early data load in showed the following CoCs had **incomplete
        data**. There was high overlap between these and CoCs not
        present in the Zillow dataset, and we therefore chose to remove
        them from our dataset.
        -   ar-504, ar-508
        -   ca-527, ca-528, ca-529, ca-530
        -   ga-502, ga-508
        -   ma-501
        -   nj-512
        -   ny-506
    -   The following CoCs were **in the Zillow file but not in the HUD
        PIT file**. These CoCs merged into others in 2018. HUD data has
        retroactively corrected for this change, but the Zillow study
        was done prior to the merges and therefore includes the
        now-defunct CoCs. To account for this, we \[FLAG DO SOMETHING\].
        -   la-508 merged into la-509
        -   wa-507 merged into wa-501
        -   ar-512 merged into ar-503

``` r
# Load and join Point in Time (PIT) homeless counts from HUD 2007-2018
hud_pit_all <- read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 1, col_names=TRUE) %>% # 2018 (Note: CoC Category is introduced in the 2018 sheet)
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 2, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2017
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 3, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2016
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 4, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2015
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 5, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2014
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 6, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2013
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 7, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2012
  full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 8, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2011
  # full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 9, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2010
  # full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 10, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2009
  # full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 11, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2008
  # full_join(read_xlsx(paste0(load_path, "2007-2018-PIT-Counts-by-CoC.xlsx"), sheet = 12, col_names=TRUE), by=c("CoC Number", "CoC Name")) %>% # 2007
  # Clean up column names
  clean_names() %>%
  rename_all(~stringr::str_replace_all(., "co_c", "coc")) %>%
  rename(coc_code = coc_number) %>%
  # Replace stray "." values with NA
  replace_with_na_all(condition = ~.x == ".") %>%
  # Get rid of coc_codes that are NA (checked, see below)
  filter(!is.na(coc_code)) %>%
  # Convert all numeric cols to numeric
  mutate_at(vars(4:ncol(.)), as.numeric) %>%
  # Standardize all characters to lowercase
  mutate_if(is.character, tolower) %>%
  # Remove any leading/trailing spaces
  mutate_if(is.character, str_trim) %>%
  # Delete non-records where coc_code > 7; drops rows from spreadsheet that are not actually CoC entries
  filter(nchar(coc_code) <= 7) %>%
  # Strip out a from mo-604a; the a is a footnote reference
  mutate(coc_code=replace(coc_code, coc_code=="mo-604a", "mo-604")) %>%
  # Drop inconsistent AR CoCs
  filter((coc_code != "ar-507") & (coc_code != "ar-512")) %>%
  # Drop CoCs in territories due to poor data
  filter(!str_detect(coc_code, "pr|mp|gu|vi")) %>%  
  # Drop CoCs with incomplete data
  filter(!(coc_code %in% incomplete_cocs)) %>%
  # Add col to designate state for grouping
  separate(coc_code, sep = "-", into = c("state_code", "coc_number"), remove = F) %>%
  # Add col to flag problematic CoCs that have merged over the years
  mutate(is_problematic_coc = case_when(
    coc_code %in% problematic_cocs ~ T,
    T ~ F
  ))
```

### Zillow Cluster Data

#### Sourced from:

-   [Zillow-county-to-FIPs
    crosswalk](input-data/CountyCrossWalk_Zillow.csv)

#### Used for:

-   Crosswalk of population to CoCs
-   Slicing data by Zillow’s [computed
    clusters](memos/papers-studies-etc/memo-inflection-points.html)

``` r
##### ZILLOW #####
# Load Zillow's cluster analysis file from 2017
zillow_cluster <- read_csv(paste0(load_path, "CoC_Cluster.csv")) %>%
  # Clean up column names
  clean_names() %>%
  rename_all(~stringr::str_replace_all(., "co_c", "coc")) %>%
  rename(coc_code = coc_number) %>%
  # Clean up stray "."s
  naniar::replace_with_na_all(condition = ~.x == ".") %>%
  # Convert all numeric cols to numeric
  mutate_at(vars(3:8), as.numeric) %>%
  # Standardize all characters to lowercase
  mutate_if(is.character, tolower) %>%
  # Append year to numeric cols for clarity
  dplyr::rename_if(is.numeric, function(x) paste0(x, "_zillow_2017")) %>%
  # Add col to designate state
  separate(coc_code, sep = "-", into = c("state_code", "coc_number"), remove = F) %>%
  # Explain clusters
  mutate(cluster_location = 
           case_when(
             cluster_number_zillow_2017 == 1 ~ "midwest, mid-Atlantic, southeast",
             cluster_number_zillow_2017 == 2 ~ "New England, Florida, mountain west, central United States",
             cluster_number_zillow_2017 == 3 ~ "west coast, east coast large metropolitan areas",
             cluster_number_zillow_2017 == 4 ~ "El Dorado County CoC, unique",
             cluster_number_zillow_2017 == 5 ~ "Southeast Arkansas, Houma-Terrebonne/Thibodaux (Louisiana), Central Tennessee",
             cluster_number_zillow_2017 == 6 ~ "San Francisco Bay area, unique",
             T ~ NA_character_),
         cluster_description =
           case_when(
             cluster_number_zillow_2017 == 1 ~ "low homeless rates, modest housing costs",
             cluster_number_zillow_2017 == 2 ~ "intermediate homeless rates, average housing costs",
             cluster_number_zillow_2017 == 3 ~ "high homeless rates, high housing costs",
             cluster_number_zillow_2017 == 4 ~ "high homeless rates, modest housing costs, low poverty rates",
             cluster_number_zillow_2017 == 5 ~ "low homeless rates, high poverty rates",
             cluster_number_zillow_2017 == 6 ~ "high homeless rate, high, worsening housing costs",
             T ~ NA_character_
           ))
```

### HUD PIT and Zillow Cluster Joined

Once cleaned in the previous steps, the PIT and Zillow data can be
joined and output for further analysis. The following table contains all
information also contained in the previous two tables, tidied up for use
by reporters.

``` r
##### JOINED #####
# Join the previous two cleaned tables
hud_zillow_joined <- hud_pit_all %>%
  # Inner join to pull only the CoCs that are present in both
  inner_join(zillow_cluster, by= c("coc_code", "state_code", "coc_number")) %>%
  rename(coc_name = coc_name.x) %>%
  select(-coc_name.y)
```

### HUD HMIS

``` r
##### HUD HMIS #####
# INCOMPLETE
#hud_hmis_all <- read_xlsx(paste0(load_path, "hit-System-Performance-Measures-Data-Since-FY-2015.xlsx"), sheet = 1, col_names=TRUE, skip = 1)
# INCOMPLETE
```

Save All CSVs to Files
----------------------

``` r
hud_pit_all %>% 
  write_csv(paste0(save_path, "hud-pit-all.csv"))

zillow_cluster %>% 
  write_csv(paste0(save_path, "zillow-cluster.csv"))

hud_zillow_joined %>%
  write_csv(paste0(save_path, "hud-zillow-joined.csv"))
```

Cleaning Checks
---------------

### Check for consistency between HUD PIT data and Zillow’s Cluster data

``` r
###########################################################
# The following code will not produce meaningful results ##
# without commenting out the load-in cleaning lines that ##
# resolved the issues being explored below. (~line 120)  ##
###########################################################

# IN HUD PIT NOT ZILLOW
# "al-505" "ar-504" "ar-508" "ca-527" "ca-528" "ca-529" "ca-530" "ga-502" "ga-508" "ma-501" "nj-512" "ny-506"
h_test <- hud_pit_all %>%
  anti_join(zillow_cluster, by= c("coc_code")) %>%
  arrange(coc_code)
(not_in_zillow <- h_test$coc_code)
```

    ## [1] "al-505"

``` r
# al-505    gadsden/northeast alabama coc     Gadsden: 38.49 sq mi    population 35,837
# ar-504    delta hills coc                       <- can't find this; might be AR Delta region?
# ar-508    fort smith coc                      68.26 sq mi             population 86,209
# ca-527    tehama county coc                       <- this one was problematic prior to dates we selected
# ca-528    del norte county coc                    1,230 mi                population 27,470
# ca-529    lake county coc                       1,329 mi                population 64,246
# ca-530    alpine, inyo, mono counties coc     alpine: 26.79 sq mi     pop 8,592
#                                           inyo: 10,227 sq mi      pop 18,546
#                                           mono: 3,132 sq mi       pop 14,202
# ga-502    fulton county coc                       534 mi                  pop 1.041 million
# ga-508    dekalb county coc                       271 mi                  pop 753,253
# ma-501    holyoke/franklin, hampden,        holyoke: 22.8 mi        pop 39,880
#         hampshire counties coc            franklin: 27.0 mi       31,635
#                                           hampden: 19.7 sq mi     5,139
#                                           hampshire: 545 sq mi    161,355

# Which CoC codes are incomplete datasets?
# "ar-504" "ar-508" "ca-527" "ca-528" "ca-529" "ca-530" "ga-502" "ga-508" "ma-501" "nj-512" "ny-506"
h_incomplete <- hud_pit_all %>%
  filter(!complete.cases(.)) %>%
  arrange(coc_code)

# Which of CoCs in HUD PIT but not in Zillow are incomplete?
# Only one, al-505, is in the h_test missing group but is a complete row
h_test %>% anti_join(h_incomplete) %>%
  select(coc_code, coc_name)
```

    ## # A tibble: 1 x 2
    ##   coc_code coc_name                     
    ##   <chr>    <chr>                        
    ## 1 al-505   gadsden/northeast alabama coc

``` r
# IN ZILLOW NOT HUD PIT
# "ar-512" "la-508" "wa-507"
z_test <- zillow_cluster %>%
  anti_join(hud_pit_all, by= c("coc_code"))
(not_in_hud <- z_test$coc_code)
```

    ## [1] "ar-512" "la-508" "wa-507"

``` r
# Delete temporary variable(s) and table(s)
rm(h_test, z_test, h_incomplete)
```
