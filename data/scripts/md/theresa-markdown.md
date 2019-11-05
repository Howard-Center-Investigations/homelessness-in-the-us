Load packages
-------------

``` r
##for debugging
rm(list=ls())

# install.packages("tidyverse")
# install.packages("stringr")
# install.packages("lubridate")
# install.packages("readxl")
# install.packages("janitor")
# install.packages("weathermetrics")
# install.packages("ggplot2")
# install.packages("reshape")
# install.packages("writexl")
# install.packages("purrr")
# install.packages("dplyr")
# install.packages("naniar")

library(tidyverse)
library(stringr)
library(lubridate)
library(readxl)
library(janitor)
library(weathermetrics)
library(ggplot2)
library(reshape)
library(writexl)
library(dplyr)
library(naniar)

rm(list=ls())
```

Load Vulnerability Survey Data
------------------------------

The SPDAT (Service Prioritization Decision Assistance Tool) was created
by OrgCode Consulting, Inc. The survey is intended to be administered by
a trained indidivual to assess a homeless individuals along four
categories: Wellness, Risks, Socialization & Daily Functions, and
History of Housing.

``` r
#here looks for where the project is located
#would need to install.packages("here")
load_path <- paste0(here::here(), "/data/input-data/")

unsheltered_surveys <- read_xlsx(paste0(load_path, "vulnerability-survey.xlsx"))
sheltered_surveys <- read_xlsx(paste0(load_path, "vulnerability-survey.xlsx"), sheet=2)
```

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK2245 / R2245C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL2245 / R2245C64: got 'self resolve'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM2245 / R2245C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK3365 / R3365C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL3365 / R3365C64: got 'self resolve'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM3365 / R3365C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN3365 / R3365C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO3365 / R3365C67: got 'self resolve'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP3365 / R3365C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK4253 / R4253C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL4253 / R4253C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK8111 / R8111C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL8111 / R8111C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK8964 / R8964C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL8964 / R8964C64: got 'family'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM8964 / R8964C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK9055 / R9055C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL9055 / R9055C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM9055 / R9055C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK9335 / R9335C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL9335 / R9335C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM9335 / R9335C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK9355 / R9355C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL9355 / R9355C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM9355 / R9355C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK11238 / R11238C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL11238 / R11238C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM11238 / R11238C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK14354 / R14354C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK14453 / R14453C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL14453 / R14453C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM14453 / R14453C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN14453 / R14453C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO14453 / R14453C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP14453 / R14453C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK14492 / R14492C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL14492 / R14492C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM14492 / R14492C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK14510 / R14510C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL14510 / R14510C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM14510 / R14510C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN14510 / R14510C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO14510 / R14510C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP14510 / R14510C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ14510 / R14510C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR14510 / R14510C70: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK14709 / R14709C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL14709 / R14709C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM14709 / R14709C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK15361 / R15361C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL15361 / R15361C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM15361 / R15361C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK17655 / R17655C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM17655 / R17655C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN17655 / R17655C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO17655 / R17655C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP17655 / R17655C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK17674 / R17674C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL17674 / R17674C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM17674 / R17674C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN17674 / R17674C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO17674 / R17674C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP17674 / R17674C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ17674 / R17674C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR17674 / R17674C70: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BS17674 / R17674C71: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK17774 / R17774C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL17774 / R17774C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM17774 / R17774C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK17999 / R17999C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL17999 / R17999C64: got 'deceased'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18043 / R18043C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18043 / R18043C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18043 / R18043C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN18043 / R18043C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO18043 / R18043C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP18043 / R18043C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ18043 / R18043C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR18043 / R18043C70: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BS18043 / R18043C71: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18111 / R18111C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18111 / R18111C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18111 / R18111C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18306 / R18306C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18306 / R18306C64: got 'SSVF'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18306 / R18306C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN18306 / R18306C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO18306 / R18306C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP18306 / R18306C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18338 / R18338C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18338 / R18338C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18338 / R18338C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN18338 / R18338C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO18338 / R18338C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP18338 / R18338C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ18338 / R18338C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR18338 / R18338C70: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18386 / R18386C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18386 / R18386C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18386 / R18386C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18642 / R18642C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18642 / R18642C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18642 / R18642C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18655 / R18655C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18655 / R18655C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18655 / R18655C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN18655 / R18655C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO18655 / R18655C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP18655 / R18655C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18814 / R18814C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18814 / R18814C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18814 / R18814C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK18857 / R18857C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL18857 / R18857C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM18857 / R18857C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK19265 / R19265C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL19265 / R19265C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM19265 / R19265C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN19265 / R19265C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO19265 / R19265C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK19364 / R19364C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL19364 / R19364C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM19364 / R19364C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK19546 / R19546C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL19546 / R19546C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM19546 / R19546C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK19834 / R19834C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL19834 / R19834C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM19834 / R19834C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK19883 / R19883C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL19883 / R19883C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM19883 / R19883C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20030 / R20030C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20030 / R20030C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20120 / R20120C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20120 / R20120C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20120 / R20120C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN20120 / R20120C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO20120 / R20120C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP20120 / R20120C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ20120 / R20120C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR20120 / R20120C70: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BS20120 / R20120C71: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20155 / R20155C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20155 / R20155C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20155 / R20155C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20298 / R20298C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20298 / R20298C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20298 / R20298C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20469 / R20469C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20469 / R20469C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20469 / R20469C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN20469 / R20469C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO20469 / R20469C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP20469 / R20469C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20497 / R20497C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20497 / R20497C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20497 / R20497C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN20497 / R20497C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO20497 / R20497C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP20497 / R20497C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20705 / R20705C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20705 / R20705C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20718 / R20718C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20718 / R20718C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20718 / R20718C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20797 / R20797C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20797 / R20797C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20797 / R20797C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK20902 / R20902C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL20902 / R20902C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM20902 / R20902C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21201 / R21201C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21201 / R21201C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21252 / R21252C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21252 / R21252C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21274 / R21274C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21274 / R21274C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21338 / R21338C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21338 / R21338C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM21338 / R21338C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21607 / R21607C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21607 / R21607C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21819 / R21819C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21819 / R21819C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM21819 / R21819C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21855 / R21855C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21855 / R21855C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM21855 / R21855C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21860 / R21860C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21860 / R21860C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK21902 / R21902C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL21902 / R21902C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK23215 / R23215C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL23215 / R23215C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK25743 / R25743C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL25743 / R25743C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM25743 / R25743C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN25743 / R25743C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO25743 / R25743C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP25743 / R25743C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ25743 / R25743C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR25743 / R25743C70: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BS25743 / R25743C71: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK25815 / R25815C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL25815 / R25815C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM25815 / R25815C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK25904 / R25904C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL25904 / R25904C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK26182 / R26182C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL26182 / R26182C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM26182 / R26182C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK26600 / R26600C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL26600 / R26600C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM26600 / R26600C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN26600 / R26600C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO26600 / R26600C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP26600 / R26600C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK27021 / R27021C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL27021 / R27021C64: got 'incarcerated'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK27312 / R27312C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL27312 / R27312C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM27312 / R27312C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN27312 / R27312C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO27312 / R27312C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK27922 / R27922C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL27922 / R27922C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK28168 / R28168C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL28168 / R28168C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK28298 / R28298C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL28298 / R28298C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK28932 / R28932C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL28932 / R28932C64: got 'family'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM28932 / R28932C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN28932 / R28932C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO28932 / R28932C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP28932 / R28932C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK29260 / R29260C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL29260 / R29260C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK31837 / R31837C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL31837 / R31837C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM31837 / R31837C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK32188 / R32188C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL32188 / R32188C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK32296 / R32296C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL32296 / R32296C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK32500 / R32500C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL32500 / R32500C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM32500 / R32500C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK32983 / R32983C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL32983 / R32983C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM32983 / R32983C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK33040 / R33040C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL33040 / R33040C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK33120 / R33120C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL33120 / R33120C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK33311 / R33311C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL33311 / R33311C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM33311 / R33311C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN33311 / R33311C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO33311 / R33311C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK33451 / R33451C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL33451 / R33451C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM33451 / R33451C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK33917 / R33917C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL33917 / R33917C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM33917 / R33917C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK34200 / R34200C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL34200 / R34200C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM34200 / R34200C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK34469 / R34469C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL34469 / R34469C64: got 'incarcerated'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35708 / R35708C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35708 / R35708C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35708 / R35708C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35738 / R35738C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35738 / R35738C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35738 / R35738C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35792 / R35792C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35792 / R35792C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35792 / R35792C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN35792 / R35792C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO35792 / R35792C67: got 'SSVF'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP35792 / R35792C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ35792 / R35792C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR35792 / R35792C70: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35805 / R35805C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35805 / R35805C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35805 / R35805C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35820 / R35820C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35820 / R35820C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35820 / R35820C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN35820 / R35820C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO35820 / R35820C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35823 / R35823C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35823 / R35823C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35823 / R35823C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN35823 / R35823C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO35823 / R35823C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP35823 / R35823C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ35823 / R35823C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR35823 / R35823C70: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BS35823 / R35823C71: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35824 / R35824C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35824 / R35824C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35824 / R35824C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35840 / R35840C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35840 / R35840C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35840 / R35840C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN35840 / R35840C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO35840 / R35840C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP35840 / R35840C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35850 / R35850C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35850 / R35850C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35850 / R35850C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35870 / R35870C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35870 / R35870C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35870 / R35870C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35943 / R35943C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35943 / R35943C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35966 / R35966C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35966 / R35966C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35966 / R35966C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK35995 / R35995C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL35995 / R35995C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM35995 / R35995C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN35995 / R35995C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO35995 / R35995C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP35995 / R35995C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ35995 / R35995C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR35995 / R35995C70: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36061 / R36061C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36061 / R36061C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM36061 / R36061C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN36061 / R36061C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO36061 / R36061C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36071 / R36071C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36071 / R36071C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM36071 / R36071C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36360 / R36360C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36360 / R36360C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM36360 / R36360C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN36360 / R36360C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO36360 / R36360C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36525 / R36525C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36525 / R36525C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36539 / R36539C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36539 / R36539C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36736 / R36736C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36736 / R36736C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36816 / R36816C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36816 / R36816C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK36967 / R36967C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL36967 / R36967C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37589 / R37589C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37589 / R37589C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37589 / R37589C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN37589 / R37589C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO37589 / R37589C67: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP37589 / R37589C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BQ37589 / R37589C69: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BR37589 / R37589C70: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BS37589 / R37589C71: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37622 / R37622C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37622 / R37622C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37622 / R37622C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37630 / R37630C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37630 / R37630C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37630 / R37630C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37636 / R37636C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37636 / R37636C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37636 / R37636C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN37636 / R37636C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO37636 / R37636C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP37636 / R37636C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37714 / R37714C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37714 / R37714C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37751 / R37751C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37751 / R37751C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37752 / R37752C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37752 / R37752C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37752 / R37752C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37759 / R37759C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37759 / R37759C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37759 / R37759C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN37759 / R37759C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO37759 / R37759C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37782 / R37782C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37782 / R37782C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37782 / R37782C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK37946 / R37946C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL37946 / R37946C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM37946 / R37946C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38002 / R38002C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38002 / R38002C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38002 / R38002C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38055 / R38055C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38055 / R38055C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38363 / R38363C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38363 / R38363C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38363 / R38363C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN38363 / R38363C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO38363 / R38363C67: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BP38363 / R38363C68: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38369 / R38369C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38369 / R38369C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38369 / R38369C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN38369 / R38369C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO38369 / R38369C67: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38375 / R38375C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38375 / R38375C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38375 / R38375C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38414 / R38414C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38414 / R38414C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38414 / R38414C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38651 / R38651C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38651 / R38651C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38651 / R38651C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38666 / R38666C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38666 / R38666C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38666 / R38666C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38673 / R38673C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38673 / R38673C64: got 'psh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38673 / R38673C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38675 / R38675C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38675 / R38675C64: got 'rrh'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BM38675 / R38675C65: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BN38675 / R38675C66: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BO38675 / R38675C67: got 'incarcerated'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38690 / R38690C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38690 / R38690C64: got 'pending'

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BK38708 / R38708C63: got a date

    ## Warning in read_fun(path = enc2native(normalizePath(path)), sheet_i =
    ## sheet, : Expecting logical in BL38708 / R38708C64: got 'unknown'

Clean Survey
------------

``` r
#clean the names of each column, words are now separated by _
unsheltered_survey <- clean_names(unsheltered_surveys) %>%
  separate(date_of_assessment, sep = "-", into = c("year", "month", "day"), remove = F)
sheltered_survey <- clean_names(sheltered_surveys) %>%
  separate(date_of_assessment, sep = "-", into = c("year", "month", "day"), remove = F)
```

Unsheltered VI-SPDAT Data
-------------------------

### Basic Information

-   Age
    -   The mean age of a sheltered respondant is 47
-   Other information is personally identifiable and thus unavailable

``` r
#What is the average age of unsheltered individuals who took this survey?
mean(unsheltered_survey$age)
```

    ## [1] 46.86456

### Hisotry of Housing and Homelessness Section

Questions include:

-   How long has it been since you lived in permanent stable housing?
    -   Average response was 2633 days, maximum was 15000 days, minimum
        was 6 days
-   In the last three years, how many times have you been homeless?
    -   Average response was 1.91, maximum was 14

``` r
#How many days (min, max and average) since an individual had permanent stable housing?
mean(unsheltered_survey$how_long_has_it_been_since_you_lived_in_permanent_stable_housing_at_time_of_vi_spdat)
```

    ## [1] 2632.762

``` r
max(unsheltered_survey$how_long_has_it_been_since_you_lived_in_permanent_stable_housing_at_time_of_vi_spdat, na.rm=TRUE)
```

    ## [1] 15000

``` r
min(unsheltered_survey$how_long_has_it_been_since_you_lived_in_permanent_stable_housing_at_time_of_vi_spdat, na.rm=TRUE)
```

    ## [1] 6

``` r
#Create a histogram to show frequency of responses; most respondants have been homeless once or twice in the past three years
hist(unsheltered_survey$in_the_last_three_years_how_many_times_have_you_been_homeless)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
max(unsheltered_survey$in_the_last_three_years_how_many_times_have_you_been_homeless)
```

    ## [1] 14

``` r
mean(unsheltered_survey$in_the_last_three_years_how_many_times_have_you_been_homeless)
```

    ## [1] 1.91027

### Risks Section

Questions include:

In the past six months, how many times have you…

-   Received health care at an emergency department/room?
    -   Average response: 7.73973
-   Taken an ambulance to the hospital?
    -   Average response: 2.73583
-   Been hospitalized as an inpatient?
    -   Average response: 7.73973
-   Used a crisis service, including sexual assault crisis, mental
    health crisis, family/intimate violence, distress centers and
    suicide prevention hotlines?
    -   Average response: 0.9651737
-   Talked to police because you witnessed a crime, were the victim of a
    crime, or the alleged perpetrator of a crime or because the police
    told you that you must move along?
    -   Average response: 20.6056
-   Stayed one or more nights in a holding cell, jail or prison, whether
    that was a short-term stay like the drunk tank, a longer stay for a
    more serious offence, or anything in between?
    -   Average response: 6.799266
-   Have you been attacked or beaten up since you’ve become homeless?
    -   No = 23627, Yes = 2273, %yes = 8.8%
-   Have you threatened to or tried to harm yourself or anyone else in
    the last year?
    -   No = 22626, Yes = 3274, %yes = 12.64%
-   Do you have any legal stuff going on right now that may result in
    you being locked up, having to pay fines, or that make it more
    difficult to rent a place to live?
    -   No = 20445, Yes = 5455, %yes = 21.05%
-   Does anybody force or trick you to do things that you do not want to
    do?
    -   No = 22829, Yes = 3071, %yes = 15.05%
-   Do you ever do things that may be considered to be risky like
    exchange sex for money, run drugs for someone, have unprotected sex
    with someone you don’t know, share a needle, or anything like that?
    -   No = 22001, Yes = 3899, %yes = 15.05%

``` r
#Created a histogram for each question to show frequency in addition to calculating the average

#Emergency Room
hist(unsheltered_survey$er)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
mean(unsheltered_survey$er)
```

    ## [1] 7.73973

``` r
#Ambulance
hist(unsheltered_survey$ambulance)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-5-2.png)

``` r
mean(unsheltered_survey$ambulance)
```

    ## [1] 2.73583

``` r
#Crisis Service
hist(unsheltered_survey$crisis)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-5-3.png)

``` r
mean(unsheltered_survey$crisis)
```

    ## [1] 0.9651737

``` r
#Police Interaction
hist(unsheltered_survey$police)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-5-4.png)

``` r
mean(unsheltered_survey$police)
```

    ## [1] 20.6056

``` r
#Jail or Prison
hist(unsheltered_survey$jail_or_prison)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-5-5.png)

``` r
mean(unsheltered_survey$jail_or_prison)
```

    ## [1] 6.799266

``` r
#Attacked or Beaten
count(unsheltered_survey, have_you_been_attacked_or_beaten_up_since_you_ve_become_homeless)
```

    ## # A tibble: 2 x 2
    ##   have_you_been_attacked_or_beaten_up_since_you_ve_become_homeless     n
    ##   <chr>                                                            <int>
    ## 1 n                                                                23627
    ## 2 y                                                                 2273

``` r
#Threateneded or tried to harm self/someone else
count(unsheltered_survey, have_you_threatened_to_or_tried_to_harm_yourself_or_anyone_else_in_the_last_year)
```

    ## # A tibble: 2 x 2
    ##   have_you_threatened_to_or_tried_to_harm_yourself_or_anyone_else_in…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   22626
    ## 2 y                                                                    3274

``` r
#Legal Obstacles?
count(unsheltered_survey, do_you_have_any_legal_stuff_going_on_right_now_that_may_result_in_you_being_locked_up_having_to_pay_nes_or_that_make_it_more_dif_cult_to_rent_a_place_to_live)
```

    ## # A tibble: 2 x 2
    ##   do_you_have_any_legal_stuff_going_on_right_now_that_may_result_in_…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   20445
    ## 2 y                                                                    5455

``` r
#Forced or Tricked?
count(unsheltered_survey, does_anybody_force_or_trick_you_to_do_things_that_you_do_not_want_to_do)
```

    ## # A tibble: 2 x 2
    ##   does_anybody_force_or_trick_you_to_do_things_that_you_do_not_want_…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   22829
    ## 2 y                                                                    3071

``` r
#Risky Behavior
count(unsheltered_survey, do_you_ever_do_things_that_may_be_considered_to_be_risky_like_exchange_sex_for_money_food_drugs_or_a_place_to_stay_run_drugs_for_someone_have_unprotected_sex_with_someone_you_don_t_know_share_a_needle_or_anything_like_that)
```

    ## # A tibble: 2 x 2
    ##   do_you_ever_do_things_that_may_be_considered_to_be_risky_like_exch…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   22001
    ## 2 y                                                                    3899

### Socialization and Daily Functioning

Questions:

-   Is there any person, past landlord, business, bookie, dealer, or
    government group like the IRS that thinks you owe them money?
    -   Y = 4803, N = 21097, Yes = 18.5% of total
-   Do you get any money from the government, a pension, an inheritance,
    working under the table, a regular job, or anything like that?
    -   

-   Do you have planned activities, other than just surviving, that make
    you feel happy and fulfilled?
    -   

-   Are you currently able to take care of basic needs like bathing,
    changing clothes, using a restroom, getting food and clean water and
    other things like that?
    -   

-   Is your current homelessness in any way caused by a relationship
    that broke down, an unhealthy or abusive relationship, or because
    family or friends caused you to become evicted?
    -   

``` r
#Owe Money to Someone?
count(unsheltered_survey, is_there_any_person_past_landlord_business_bookie_dealer_or_government_group_like_the_irs_that_thinks_you_owe_them_money)
```

    ## # A tibble: 2 x 2
    ##   is_there_any_person_past_landlord_business_bookie_dealer_or_govern…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   21097
    ## 2 y                                                                    4803

### Wellness

Questions:

-   Have you ever had to leave an apartment, shelter program, or other
    place you were staying because of your physical health?
    -   

-   Do you have any chronic health issues with your liver, kidneys,
    stomach, lungs or heart?
    -   No = 13930, yes = 11970, %yes = 46.2%
-   If there was space available in a program that specifically assists
    people that live with HIV or AIDS, would that be of interest to you?
    -   

-   Do you have any physical disabilities that would limit the type of
    housing you could access, or would make it hard to live
    independently because you’d need help?
    -   

-   When you are sick or not feeling well, do you avoid getting help?
    -   No = 13631, yes = 12269, %yes = 47.37%
-   FOR FEMALE RESPONDENTS ONLY: Are you currently pregnant?
    -   

-   Has your drinking or drug use led you to being kicked out of an
    apartment or program where you were staying in the past?
    -   

-   Will drinking or drug use make it difficult for you to stay housed
    or afford your housing?
    -   

-   Have you ever had trouble maintaining your housing, or been kicked
    out of an apartment, shelter program or other place you were
    staying, because of:
    -   A mental health issue or concern? ++ No = 13068, Yes = 12832,
        %yes = 49.5%
    -   A past head injury?
    -   A learning disability, developmental disability, or other
        impairment?
-   Do you have any mental health or brain issues that would make it
    hard for you to live independently because you’d need help?
    -   

-   Are there any medications that a doctor said you should be taking
    that, for whatever reason, you are not taking?
    -   

-   Are there any medications like painkillers that you don’t take the
    way the doctor prescribed or where you sell the medication?
    -   

-   Has your current period of homelessness been caused by an experience
    of emotional, physical, psychological, sexual, or other type of
    abuse, or by any other trauma you have experienced?
    -   

``` r
#Chronic Issues
count(unsheltered_survey, do_you_have_any_chronic_health_issues_with_your_liver_kidneys_stomach_lungs_or_heart)
```

    ## # A tibble: 2 x 2
    ##   do_you_have_any_chronic_health_issues_with_your_liver_kidneys_stom…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   13930
    ## 2 y                                                                   11970

``` r
#Avoid Getting Help?
count(unsheltered_survey, when_you_are_sick_or_not_feeling_well_do_you_avoid_getting_medical_help)
```

    ## # A tibble: 2 x 2
    ##   when_you_are_sick_or_not_feeling_well_do_you_avoid_getting_medical…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   13631
    ## 2 y                                                                   12269

``` r
#Mental Health
count(unsheltered_survey, a_mental_health_issue_or_concern)
```

    ## # A tibble: 2 x 2
    ##   a_mental_health_issue_or_concern     n
    ##   <chr>                            <int>
    ## 1 n                                13068
    ## 2 y                                12832

``` r
count(unsheltered_survey, sub_score_trimorbidity)
```

    ## # A tibble: 4 x 2
    ##   sub_score_trimorbidity     n
    ##                    <dbl> <int>
    ## 1                      0   286
    ## 2                      1  2880
    ## 3                      2  9794
    ## 4                      3 12940

``` r
#0 = 286            1 = 2880 (11.12%)           2 = 9794 (37.82%)           3 = 12940   (49.96%)

count(unsheltered_survey, trimorbidity)
```

    ## # A tibble: 2 x 2
    ##   trimorbidity     n
    ##          <dbl> <int>
    ## 1            0 12960
    ## 2            1 12940

``` r
#What percentage of unsheltered individuals identified as LGBTQQI?
count(unsheltered_survey, identifies_as_lgbtqqi2 == "y")
```

    ## # A tibble: 2 x 2
    ##   `identifies_as_lgbtqqi2 == "y"`     n
    ##   <lgl>                           <int>
    ## 1 TRUE                             2209
    ## 2 NA                              23691

``` r
#Returns 2209 true, 23691 n/a; 8.5% reported being LGBTQ
#Compare this to 2017 gallup poll that found 4.5% adult Americans are LGBT
```

Sheltered VI-SPDAT Data
-----------------------

### Basic Information

-   Age
    -   The mean age of a sheltered respondant is 46
-   Other information is personally identifiable

``` r
#Average age of sheltered respondant
mean(sheltered_survey$age)
```

    ## [1] 45.82521

### Hisotry of Housing and Homelessness Section VI-SPDAT

Questions include:

-   How long has it been since you lived in permanent stable housing?
    -   Average response to this question is 410.4 days, maximum is
        14600, while minimum is 1
-   In the last three years, how many times have you been homeless?
    -   Average: 1.097, maximum: 44

``` r
#How many days (min, max, average) since permanent stable housing?
mean(sheltered_survey$how_long_has_it_been_since_you_lived_in_permanent_stable_housing_at_time_of_vi_spdat, na.rm=TRUE)
```

    ## [1] 410.414

``` r
max(sheltered_survey$how_long_has_it_been_since_you_lived_in_permanent_stable_housing_at_time_of_vi_spdat, na.rm=TRUE)
```

    ## [1] 14600

``` r
min(sheltered_survey$how_long_has_it_been_since_you_lived_in_permanent_stable_housing_at_time_of_vi_spdat, na.rm=TRUE)
```

    ## [1] 1

``` r
#Create a histogram to show frequency of responses; most respondants have been homeless once or twice in the past three years
hist(sheltered_survey$in_the_last_three_years_how_many_times_have_you_been_homeless)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-9-1.png)

``` r
max(sheltered_survey$in_the_last_three_years_how_many_times_have_you_been_homeless, na.rm=TRUE)
```

    ## [1] 44

``` r
mean(sheltered_survey$in_the_last_three_years_how_many_times_have_you_been_homeless, na.rm=TRUE)
```

    ## [1] 1.09714

### Risks Section

Questions include: In the past six months, how many times have you… \*
Received health care at an emergency department/room? + Average
response: 7.73973 \* Taken an ambulance to the hospital? + Average
response: 2.73583 \* Been hospitalized as an inpatient? + Average
response: 7.73973 \* Used a crisis service, including sexual assault
crisis, mental health crisis, family/intimate violence, distress centers
and suicide prevention hotlines? + \* Talked to police because you
witnessed a crime, were the victim of a crime, or the alleged
perpetrator of a crime or because the police told you that you must move
along? + Average response: 20.6056 \* Stayed one or more nights in a
holding cell, jail or prison, whether that was a short-term stay like
the drunk tank, a longer stay for a more serious offence, or anything in
between? + Average response: 6.799266 \* Have you been attacked or
beaten up since you’ve become homeless? + \* Have you threatened to or
tried to harm yourself or anyone else in the last year? + \* Do you have
any legal stuff going on right now that may result in you being locked
up, having to pay fines, or that make it more difficult to rent a place
to live? + \* Does anybody force or trick you to do things that you do
not want to do? + \* Do you ever do things that may be considered to be
risky like exchange sex for money, run drugs for someone, have
unprotected sex with someone you don’t know, share a needle, or anything
like that? +

### Socialization and Daily Functioning

Questions:

-   Is there any person, past landlord, business, bookie, dealer, or
    government group like the IRS that thinks you owe them money?
    -   

-   Do you get any money from the government, a pension, an inheritance,
    working under the table, a regular job, or anything like that?
    -   

-   Do you have planned activities, other than just surviving, that make
    you feel happy and fulfilled?
    -   

-   Are you currently able to take care of basic needs like bathing,
    changing clothes, using a restroom, getting food and clean water and
    other things like that?
    -   

-   Is your current homelessness in any way caused by a relationship
    that broke down, an unhealthy or abusive relationship, or because
    family or friends caused you to become evicted?
    -   

``` r
#Owe Money to Someone?
count(sheltered_survey, is_there_any_person_past_landlord_business_bookie_dealer_or_government_group_like_the_irs_that_thinks_you_owe_them_money)
```

    ## # A tibble: 3 x 2
    ##   is_there_any_person_past_landlord_business_bookie_dealer_or_govern…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   28477
    ## 2 y                                                                   10368
    ## 3 yy                                                                      1

### Wellness

Questions:

-   Have you ever had to leave an apartment, shelter program, or other
    place you were staying because of your physical health?
    -   

-   Do you have any chronic health issues with your liver, kidneys,
    stomach, lungs or heart?
    -   

-   If there was space available in a program that specifically assists
    people that live with HIV or AIDS, would that be of interest to you?
    -   

-   Do you have any physical disabilities that would limit the type of
    housing you could access, or would make it hard to live
    independently because you’d need help?
    -   

-   When you are sick or not feeling well, do you avoid getting help?
    -   

-   FOR FEMALE RESPONDENTS ONLY: Are you currently pregnant?
    -   

-   Has your drinking or drug use led you to being kicked out of an
    apartment or program where you were staying in the past?
    -   

-   Will drinking or drug use make it difficult for you to stay housed
    or afford your housing?
    -   

-   Have you ever had trouble maintaining your housing, or been kicked
    out of an apartment, shelter program or other place you were
    staying, because of:
    -   A mental health issue or concern? ++
    -   A past head injury?
    -   A learning disability, developmental disability, or other
        impairment?
-   Do you have any mental health or brain issues that would make it
    hard for you to live independently because you’d need help?
    -   

-   Are there any medications that a doctor said you should be taking
    that, for whatever reason, you are not taking?
    -   

-   Are there any medications like painkillers that you don’t take the
    way the doctor prescribed or where you sell the medication?
    -   

-   Has your current period of homelessness been caused by an experience
    of emotional, physical, psychological, sexual, or other type of
    abuse, or by any other trauma you have experienced?

``` r
count(sheltered_survey, have_you_been_attacked_or_beaten_up_since_you_ve_become_homeless == "y")
```

    ## # A tibble: 2 x 2
    ##   `==...`     n
    ##   <lgl>   <int>
    ## 1 FALSE   27031
    ## 2 TRUE    11815

``` r
# True = 11815, False = 27031 = 30% have been attacked/beaten

count(sheltered_survey, is_there_any_person_past_landlord_business_bookie_dealer_or_government_group_like_the_irs_that_thinks_you_owe_them_money == "y")
```

    ## # A tibble: 2 x 2
    ##   `==...`     n
    ##   <lgl>   <int>
    ## 1 FALSE   28478
    ## 2 TRUE    10368

``` r
#FALSE  28478           TRUE    10368       % True = 26.7%

count(sheltered_survey, do_you_ever_do_things_that_may_be_considered_to_be_risky_like_exchange_sex_for_money_food_drugs_or_a_place_to_stay_run_drugs_for_someone_have_unprotected_sex_with_someone_you_don_t_know_share_a_needle_or_anything_like_that =="y")
```

    ## # A tibble: 2 x 2
    ##   `==...`     n
    ##   <lgl>   <int>
    ## 1 FALSE   33332
    ## 2 TRUE     5514

``` r
#FALSE  33332           TRUE    5514      %True = 14.2%

count(sheltered_survey, do_you_have_any_chronic_health_issues_with_your_liver_kidneys_stomach_lungs_or_heart)
```

    ## # A tibble: 2 x 2
    ##   do_you_have_any_chronic_health_issues_with_your_liver_kidneys_stom…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   37166
    ## 2 y                                                                    1680

``` r
#n = 37166       y = 1680     %y = 4.33%

count(sheltered_survey, when_you_are_sick_or_not_feeling_well_do_you_avoid_getting_medical_help)
```

    ## # A tibble: 2 x 2
    ##   when_you_are_sick_or_not_feeling_well_do_you_avoid_getting_medical…     n
    ##   <chr>                                                               <int>
    ## 1 n                                                                   37832
    ## 2 y                                                                    1014

``` r
#n = 37832        y =   1014        %y = 2.61%

count(sheltered_survey, a_mental_health_issue_or_concern)
```

    ## # A tibble: 2 x 2
    ##   a_mental_health_issue_or_concern     n
    ##   <chr>                            <int>
    ## 1 n                                32119
    ## 2 y                                 6727

``` r
#n = 32119          y = 6727            %y = 17.32%

count(sheltered_survey, sub_score_trimorbidity)
```

    ## # A tibble: 4 x 2
    ##   sub_score_trimorbidity     n
    ##                    <dbl> <int>
    ## 1                      0 13984
    ## 2                      1 18734
    ## 3                      2  5499
    ## 4                      3   629

``` r
#0 = 13984          1 = 18734   (48.23%)        2 = 5499 (14.16%)           3 = 629 (1.62%)

count(sheltered_survey, identifies_as_lgbtqqi2 == "y")
```

    ## # A tibble: 2 x 2
    ##   `identifies_as_lgbtqqi2 == "y"`     n
    ##   <lgl>                           <int>
    ## 1 TRUE                             3471
    ## 2 NA                              35375

``` r
#Returns 3471 true, 35375 n/a; 8.9% reported being LGBTQ
#Compare this to 2017 gallup poll that found 4.5% adult Americans are LGBT
```

Criminalization over Time
-------------------------

Have homeless indidivudals experienced higher rates of
incarceration/interactions with the law in a certain year? Do any
correspond with increases in homeless criminilization policies?

``` r
ggplot(unsheltered_survey, aes(x=jail_or_prison)) + 
  geom_histogram() + 
  facet_wrap(~year)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-13-1.png)

``` r
ggsave(filename = "unsheltered-jail-prison-time.png", 
       device = "png", path = paste0(here::here(), "/graphs/unsheltered"))

ggplot(sheltered_survey, aes(x=jail_or_prison)) + 
  geom_histogram() + 
  facet_wrap(~year)
```

![](theresa-markdown_files/figure-markdown_github/unnamed-chunk-13-2.png)

``` r
ggsave(filename = "sheltered-jail-prison-time.png", 
       device = "png", path = paste0(here::here(), "/graphs/sheltered"))
```

Overall score over time
-----------------------

Geographic Areas
----------------

Urban/Suburban/Rural
--------------------
