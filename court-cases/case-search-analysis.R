#Court Case Analysis

library(tidyverse)
library(dplyr)
library(readxl)
library(janitor)


setwd("~/GitHub/homelessness-in-the-us")
link = getwd()

#load csvs with court case data
criminal <- read_excel(paste0(link, "/court-cases/homeless and criminal OR criminalize OR crime NOT camp or camping or sleep.xlsx")) %>%
  clean_names()
camping <- read_excel(paste0(link, "/court-cases/homeless and encampment or camping or camp or sleep.xlsx")) %>%
  clean_names()
encampment <- read_excel(paste0(link, "/court-cases/Homeless and encampment.xlsx")) %>%
  clean_names()
panhandle <- read_excel(paste0(link, "/court-cases/homeless AND panhandle OR beg OR solicit NOT encampment or camp or sleep or criminalize.xlsx")) %>%
  clean_names()

##########################Cells are color coded, so make column showing color value
library("xlsx")
wb     <- loadWorkbook("homeless AND panhandle OR beg OR solicit NOT encampment or camp or sleep or criminalize.xlsx")
sheet1 <- getSheets(wb)[[1]]

# get all rows
rows  <- getRows(sheet1)
cells <- getCells(rows)

styles <- sapply(cells, getCellStyle) #This will get the styles

cellColor <- function(style) 
{
  fg  <- style$getFillForegroundXSSFColor()
  rgb <- tryCatch(fg$getRgb(), error = function(e) NULL)
  rgb <- paste(rgb, collapse = "")
  return(rgb)
}

sapply(styles, cellColor)

#filter for those mentioning homelessness
encampment <- encampment %>%
  filter(grepl("homeless", summary))

view(encampment$summary)