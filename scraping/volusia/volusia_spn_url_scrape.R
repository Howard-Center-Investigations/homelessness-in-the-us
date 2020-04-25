#Scraper to find most charged people
#Riin Aljas, aljasriin@gmail.com

#sys.sleep is 20 seconds in the selenium part, as volusia server
#will throw captcha at somepoint if there's too many requests within 60 sec time

library(tidyverse)
library(readxl)
library(RSelenium)
library(rvest)
library(tidytext)
library(tidyr)
library(stringr)
library(lubridate)
library(janitor)
##read in the data and join by final_name----

  volusia_cases <- read_excel("cases_volusia_2019.xlsx")
  volusia_top <- read_excel("2019_volusia.xlsx")

  volusia_joined <- left_join(volusia_top, volusia_cases, by = 'final_name') 

##group, to make everything shorter----
  short_volusia <- volusia_joined %>% 
  group_by(final_name, court_docket_no) %>% 
  count() 

  finalnames_v <- volusia_top$final_name

##create searchable case numbers----  
#we want DB and AWS codes, as tests have shown they work
#not all casenrs do, but we only need one so as long as we 
#get 50, we're fine 

  findnr_f <- function(name) {short_volusia %>% 
    filter(final_name == name) %>% 
    filter(str_detect(court_docket_no,"MM")) %>% 
    filter(str_detect(court_docket_no,"(DB)|(AWS)")) %>% 
    head(1) %>% 
    ungroup() %>% 
    select(court_docket_no)}
  
  findnr_v <- lapply(finalnames_v, findnr_f) %>% 
    unlist() %>% 
    as.data.frame() %>% 
    rename(casenr = 1)
  n_distinct(findnr_v)  


  y <- findnr_v$casenr %>% 
    str_remove('XXX') %>% 
    str_remove("((\\w){3}$)") %>% 
    str_extract("((\\w){6}$)")

  new_case_nr = str_extract(findnr_v$casenr, '20.*') %>% 
    str_remove('XXX')
  findnr_v$new_case_nr <- paste0(str_extract(new_case_nr, "[\\d]{4}"),
                                 y,
                                 str_extract(new_case_nr, "[:upper:]{2}"),
                                 str_extract(new_case_nr, "((\\w){3}$)")) %>% 
    str_replace("ADB", "DB")


##SRAPE URLS WITH REMOTE SERVER----
  
  ##create empty dfs for later 
  vol_data <- as.data.frame(matrix(ncol = 2,
                                 nrow=0))
  colnames(vol_data) <- c('url_id',
                       'casenr')

  ##OPEN UP REMOTE SERVER----

  #create driver and locate the right page 
  driver <- rsDriver(browser = c("chrome"), chromever = "80.0.3987.106")
  remote_driver <- driver[["client"]] 
  myurl <- remote_driver$navigate(
      "https://app02.clerk.org/ccms/")
  Sys.sleep(1)
    
  temp <- remote_driver$findElement(using = "id", 
                                      value = "ctl00_Content1_button_accept")
  temp$clickElement()
  
  for (casenr  in findnr_v$new_case_nr){
      #tryCatch for getting back to date error starts----  
      tryCatch({
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "ctl00_Content1_CaseNum")
    temp$clickElement()
    
    temp$sendKeysToElement(list(casenr))
    
    Sys.sleep(2)
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "ctl00_Content1_lb_submit")
    
    temp$clickElement()
    Sys.sleep(5)
    
   
    
    pagecode <- remote_driver$getPageSource() 
    temp_data <- pagecode[[1]] %>%
      read_html() %>% 
      html_nodes('[id="SPN"]') %>% 
      html_attr('href') %>% 
      as.data.frame() %>% 
      rename(url_id = 1) %>% 
      mutate(casenr = casenr)
    

  
    vol_data <- bind_rows(vol_data, temp_data)
    print(vol_data$url_id)
    
    Sys.sleep(20)
    temp <- remote_driver$findElement(using = "id", 
                                      value = "ctl00_Content1_reset")
    
    temp$clickElement()
    Sys.sleep(2)
    
  },
  error = function(e) {
    print(e, casenr)})}

##create urls----

case_urls <- vol_data %>% 
      mutate(case_urls= paste0('https://app02.clerk.org/ccms/', url_id)) %>% 
      rename(new_case_nr = casenr) %>% 
      left_join(findnr_v, by = 'new_case_nr') %>% 
      rename(court_docket_no = casenr) %>% 
      left_join(short_volusia, by = "court_docket_no") %>% 
      select(final_name, case_urls)
 

  
###if you just start here 
  vol_caseurls <- read_csv("vol_caseurls.csv") %>% 
    rename(case_url = case_urls)
  names_volusia <- as.data.frame(matrix(ncol = 0, 
                                 nrow=0))
  #if you haven't done the upper part and need only names you're fine, if you have, 
  #then close the remote server and save your changes and close R and then start from here again
  #or if you wish start from the for caseurl part 
  driver <- rsDriver(browser = c("chrome"), chromever = "80.0.3987.106")
  remote_driver <- driver[["client"]] 
  myurl <- remote_driver$navigate(
    "https://app02.clerk.org/ccms/")
  Sys.sleep(1)
  
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "ctl00_Content1_button_accept")
  temp$clickElement()
  
  
  for (case_url in vol_caseurls$case_url) {
    #for(case_url in missing$case_url) {
    temp_url <- remote_driver$navigate(case_url) %>% 
      remote_driver$getPageSource()
    Sys.sleep(1)

    
    
    person <- read_html(temp_url[[1]]) %>% 
      html_nodes('#main > div:nth-child(5) > fieldset > table') %>% 
      html_table() %>% 
      unlist() %>% 
      as.data.frame() %>% 
      unique()
    
    person <- person %>% 
      mutate(x2 = str_remove(person$., '^.*'),
        x1 = str_match(person$.,'^.*') %>% 
          str_remove(':')) %>% 
      select(x1, x2) %>% 
      pivot_wider(names_from = x1, values_from = x2) %>% 
      clean_names() %>% 
      mutate(case_url = case_url)
   
    Sys.sleep(4)
    
    names_volusia <- bind_rows(names_volusia, person)
    
    
    }
    
  #sometimes all pages don't load, run same code with missing urls
  
  missing <- anti_join(vol_caseurls, names_volusia, by = "case_url")
  
  write_csv(names_volusia, "volusia_dem_data.csv")




        