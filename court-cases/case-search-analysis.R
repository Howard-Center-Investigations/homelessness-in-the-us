#Court Case Analysis

library(tidyverse)
library(dplyr)
library(readxl)
library(janitor)

#load csvs with court case data
criminal <- read_excel("GitHub/homelessness-in-the-us/court-cases/homeless and criminal OR criminalize OR crime NOT camp or camping or sleep.xlsx") %>%
  clean_names()
camping <- read_excel("GitHub/homelessness-in-the-us/court-cases/homeless and encampment or camping or camp or sleep.xlsx") %>%
  clean_names()
encampment <- read_excel("GitHub/homelessness-in-the-us/court-cases/Homeless and encampment.xlsx") %>%
  clean_names()
panhandle <- read_excel("GitHub/homelessness-in-the-us/court-cases/homeless AND panhandle OR beg OR solicit NOT encampment or camp or sleep or criminalize.xlsx") %>%
  clean_names()



#filter for those mentioning homelessness
encampment <- encampment %>%
  filter(grepl("homeless", summary))

view(encampment$summary)