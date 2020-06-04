#scrape fines info 

#Riin Aljas, aljasriin@gmail.com

####libaries----
library(tidyverse)
library(RSelenium)
library(rvest)
library(tidytext)
library(tidyr)
library(stringr)


##extract case nr-s 

final_homeless <- readRDS("data/final_homeless.rds")


#can one case nr refer to several people?

casenroff <- final_homeless$case_number %>% 
  unique() %>% 
  as.data.frame() %>% 
  head(1723) %>% 
  rename(case_nr = 1)


allcasnrs <- final_homeless$case_number %>%
  unique() %>% 
  as.data.frame() %>% 
  rename(case_nr = 1)

case_nrs <- anti_join(allcasnrs, casenroff)
df <- case_nrs %>% as.data.frame()



####SELENIUM PART ----

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



temp$clickElement()


for (casenr in case_nrs$case_nr) {
  print(casenr)
  
  temp <- remote_driver$findElement(using = "id", 
                                    value = "CaseSearchValue")
  temp$clickElement()

  temp$sendKeysToElement(list(casenr))
  temp <- remote_driver$findElement(using = "id",value = "SearchSubmit")
  
  temp$clickElement()
  temp <- remote_driver$findElement(using = "xpath", 
                                    value = "/html/body/table[4]/tbody/tr[3]/td[1]/a")
  temp$clickElement()
  Sys.sleep(1)
  


##SCRAPE INFORMATION----
#don't close selenium chrome window 

 


 
pagesource <- remote_driver$getPageSource()
mynodes <- read_html(pagesource[[1]])
  
 if (str_detect(pagesource, "Financial Information") == TRUE)
 {
    #get financial information 
    fins <- mynodes %>% 
      html_nodes('#RCDFRPC1+ td , #RCDFRBD1+ td b , tr:nth-child(8) td:nth-child(7) , #RCDFRBFA1+ td') %>% 
      html_text() %>% 
      as.data.frame() %>% 
      rename(values = 1)
    fins$values <- as.character(fins$values)
    fins <- fins %>% 
      rownames_to_column() %>% 
      pivot_wider(names_from = rowname, 
                  values_from = values) %>% 
      select("to_pay" = 1, 
             "paid" = 2, 
             "balance" = 3) %>% 
      mutate(case_number = casenr)
    print(c(casenr, fins$balance)) 
    Sys.time()
    
    
    pinellasdata <- bind_rows(pinellasdata, fins) 
    Sys.sleep(1)
    temp <- remote_driver$findElement(using = "xpath",
                                      value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]")
    
    temp$clickElement()
    
    
    Sys.sleep(1)
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "Case")
    temp$clickElement()
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "CaseNumberOption")
    temp$clickElement()
    
    temp <- remote_driver$findElement(using = "id", 
                                      value = "CaseSearchValue")
  
    next
    
 }

Sys.sleep(1)
temp <- remote_driver$findElement(using = "xpath",
                                  value = "/html/body/table[2]/tbody/tr/td/table/tbody/tr/td[1]/font/a[6]")

temp$clickElement()


Sys.sleep(1)

temp <- remote_driver$findElement(using = "id", 
                                  value = "Case")
temp$clickElement()

temp <- remote_driver$findElement(using = "id", 
                                  value = "CaseNumberOption")
temp$clickElement()

temp <- remote_driver$findElement(using = "id", 
                                  value = "CaseSearchValue")
print(c(casenr, " no fines"))
Sys.time()
}




