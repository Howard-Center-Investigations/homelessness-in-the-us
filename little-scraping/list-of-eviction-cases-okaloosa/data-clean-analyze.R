
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
library(svMisc)

march_to_now <- clean_data

#dirty_data <- read_csv("./data/search-results-june-4.csv") %>%
  
temp <- read_csv("./data/0119.csv")
temp2 <- read_csv("./data/0219and0319.csv")
temp3 <- read_csv("./data/0419and0519.csv")
temp4 <- read_csv("./data/0619and0719.csv")
temp5 <- read_csv("./data/0819and0919.csv")
temp6 <- read_csv("./data/1019.csv")
temp7 <- read_csv("./data/1119and1219.csv")
temp8 <- read_csv("./data/0120and0220.csv")


dirty_data <- temp %>%
  rbind(temp2) %>%
  rbind(temp3) %>%
  rbind(temp4) %>%
  rbind(temp5) %>%
  rbind(temp6) %>%
  rbind(temp7) %>%
  rbind(temp8) %>%
  clean_names() %>%
  select(-citation_number, -booking_number)




#applying tolower
dirty_data$name <- tolower(dirty_data$name)
dirty_data$party_type <- tolower(dirty_data$party_type)
dirty_data$case_number <- tolower(dirty_data$case_number)
dirty_data$status <- tolower(dirty_data$status)

#removing spaces from case numbers -- for some reason this works if you run it 3 times, not questioning
searchString <- ' '
replacementString <- ''
dirty_data$case_number <- sub(searchString, replacementString, dirty_data$case_number)

#creating plaintiffs frame
plaintiff <- dirty_data %>%
  filter(party_type == "plaintiff") %>%
  mutate(plaintiff = name) %>%
  select(plaintiff, case_number, status)

#creating defendant frame
defendant <- dirty_data %>%
  filter(party_type == "defendant") %>%
  mutate(defendant = name) %>%
  select(defendant, case_number, status)

clean_data <- defendant %>%
  left_join(plaintiff, by = c("case_number", "status")) %>%
  select(case_number, status, plaintiff, defendant)

landlords <- clean_data %>%
  group_by(plaintiff) %>%
  summarise(evictions = n())

case_number_list <- unique(clean_data$case_number)
print(case_number_list)

