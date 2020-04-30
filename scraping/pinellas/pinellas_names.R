#scraper to find most charged people
#Riin Aljas, aljasriin@gmail.com

library(tidyverse)
library(RSelenium)
library(rvest)
library(tidytext)
library(tidyr)
library(stringr)
library(readxl)
#read in the data and join by final_name----
pinellas_cases <- read_excel("pinellas_charges.xlsx")
pinellas_top <- read_excel("pinellas_most_charged.xlsx")


pinellas_joined <- left_join(pinellas_top, pinellas_cases, by = 'final_name') 

##group by final_name and court docket nr, then choose the first one for each---- 
##check that unique nr is same that original 50 
short <- pinellas_joined %>% 
  group_by(final_name, court_docket_no) %>% 
  count() 

finalnames_p <- pinellas_top$final_name

findnr_f <- function(name) {short %>% 
    filter(final_name == name) %>% 
    head(1) %>% 
    ungroup() %>% 
    select(court_docket_no)}
findnr_p <- lapply(finalnames_p, findnr_f) %>% 
  unlist() %>% 
  as.data.frame()
n_distinct(findnr_p)   

#we use APC as tests show those case_nrs work for sure, 
#we need one per name, so as long as we get 50, we're fine
findnr_f <- function(name) {short %>% 
    filter(final_name == name,
           str_detect(court_docket_no, "APC")) %>% 
    head(1) %>% 
    ungroup() %>% 
    select(court_docket_no)
}
findnr_p <- lapply(finalnames_p, findnr_f) %>% 
  unlist() %>% 
  as.data.frame()
n_distinct(findnr_p)  

####SELENIUM SCRAPE PART ----

#create empty df for future loop
pinellas_data <- data.frame(matrix
                            (ncol=4, nrow=0))
colnames(pinellas_data) <-c("full_name", 
                            "DOB", 
                            "court_docket_no",
                            "final_name") 
#create driver and locate the right page
driver <- rsDriver(browser = c("chrome"), chromever = "80.0.3987.106")
remote_driver <- driver[["client"]] 
myurl <- remote_driver$navigate(
  "https://ccmspa.pinellascounty.org/PublicAccess/default.aspx")

temp <- remote_driver$findElement(using = "xpath", 
                                  value = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]")
temp$clickElement()

temp <- remote_driver$findElement(using = "id", 
                                  value = "Case")
temp$clickElement()

temp <- remote_driver$findElement(using = "id", 
                                  value = "CrossRefNumberOption")
temp$clickElement()

temp <- remote_driver$findElement(using = "id", 
                                  value = "CaseSearchValue")
temp$clickElement()
for (casenr in findnr_p$.){
  
  temp$sendKeysToElement(list(casenr))
  temp <- remote_driver$findElement(using = "id",value = "SearchSubmit")
 
  temp$clickElement()


  Sys.sleep(1)

  sourcecode <- remote_driver$getPageSource()
  temp_data <- read_html(sourcecode[[1]]) %>% 
    html_nodes("body > table:nth-child(5) > tbody > tr:nth-child(3) > td:nth-child(3) > div:nth-child(1)") %>% 
    html_text() %>% 
    as.data.frame() %>% 
    mutate(DOB = read_html(sourcecode[[1]]) %>% 
             html_nodes("body > table:nth-child(5) > tbody > tr:nth-child(3) > td:nth-child(3) > div:nth-child(2)") %>% 
             html_text()) %>% 
    rename(full_name = 1) %>% 
    mutate(court_docket_no = casenr) %>% 
    left_join(short, by = "court_docket_no") %>% 
    select(-n)
  
  pinellas_data <- bind_rows(pinellas_data, 
                             temp_data)
  myurl <- remote_driver$navigate(
    "https://ccmspa.pinellascounty.org/PublicAccess/default.aspx")
  
  temp <- remote_driver$findElement(using = "xpath", 
                                    value = "/html/body/table/tbody/tr[2]/td/table/tbody/tr[1]/td[2]/a[1]")
  temp$clickElement()
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "Case")
  temp$clickElement()
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "CrossRefNumberOption")
  temp$clickElement()
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "CaseSearchValue")}







