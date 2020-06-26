#Script for helper functions 
#Riin Aljas; aljasriin@gmail.com
library(tidyverse)
library(rvest)

calc_age <- function(birthDate, refDate = Sys.Date()) {
  
  require(lubridate)
  
  period <- as.period(interval(birthDate, refDate),
                      unit = "year")
  
  period$year
  
} 


##STREETNAMES----

#get data from USPS 

usps <- read_html("https://pe.usps.com/text/pub28/28apc_002.htm") %>% 
  html_nodes('#ep533076') %>% 
  html_table(fill = TRUE) %>% 
  as.data.frame() %>% 
  rename(full = 1, 
         short = 2)

#usps$short <- paste0(" ", usps$short, " ")


test <- head(full_data$city_add, 20)
test <- head(full_data$city_add, 3)
test <- head(full_data$city_add, 200)


standard_streets <- for (i in test){
 
  for (word in as.list(izip(a = usps$full, b = usps$short))){
   r <- str_replace_all(i, word$b, word$a) %>% 
     str_replace_all("APOINT", "APT") %>% 
     str_replace_all("\\dSTREET", "\\dST")
  }
  return(r)}
y <- lapply(test,function(x) {
  
  for (word in as.list(izip(a = usps$full, b = usps$short))){
   r <-   str_replace_all(x, word$b, word$a) %>% 
      str_replace_all("APOINT", "APT") %>% 
      str_replace_all("\\dSTREET", "\\dST")
    
    
    
  }})
test2 <- head(test, 10)
u <- function(i){
  s <- lapply(test2, function(x){
  for (word in as.list(izip(a = usps$full, b = usps$short))){
    str_replace_all(test2, word$b, word$a) %>% 
      str_replace_all("APOINT", "APT") %>% 
      str_replace_all("\\dSTREET", "\\dST")
    
  }})
  }

try <- lapply(test2, u)

emptydf <- as.data.frame(matrix(ncol = 0, nrow = 0))
for (address in test2) {
  emptyaddress <- as.data.frame(matrix(ncol = 0, nrow = 0))
  for (word in as.list(izip(a = usps$full, b = usps$short))){
    if (str_detect(address, word$b)==TRUE) {
      
  tempaddress <- str_replace_all(address, fixed(word$b), word$a)%>% 
      str_replace_all("APOINT", "APT") %>% 
      str_replace_all("\\dSTREET", "\\dST") %>%
    str_replace_all(c("HARBOROR" = "HARBOR", " CLEARWATERRACE" = "CLEARWATER")) %>% 
      as.data.frame()
  emptyaddress <- bind_rows(emptyaddress, tempaddress) 
  emptyaddress <- emptyaddress %>% 
    filter(emptyaddress$. != address)
  print(emptyaddress)
    
    next
    }
    tempaddress <- paste0(address, "didntchange") %>% as.data.frame()
    emptyaddress <- bind_rows(emptyaddress, tempaddress) %>% unique()
   
    }

    tempdf <- bind_rows(emptydf, tempaddress) %>% unique()}
  print(tempdf) 
  emptydf <- bind_rows(emptydf, tempdf) %>% unique()
  print(nrow(emptydf))
  
  
  
  
  
  
  
  addresses <- as.data.frame(matrix(ncol = 0, nrow = 0))  
  for (myaddress in test2) {
    loopaddress <- myaddress 
    for (word in as.list(izip(a = usps$full, b = usps$short))){
      mypattern = paste0(" ", word$b, " ")
      mypattern2 = paste0(" ", word$a, " ")
      if (str_detect(loopaddress, mypattern)==TRUE) {
      
      loopaddress <- str_replace_all(loopaddress, mypattern, mypattern2)%>% 
        str_replace_all("APOINT", "APT") %>% 
        str_replace_all("\\dSTREET", "\\dST") %>%
        str_replace_all(c("STREET PETERSBURG" = "ST PETERSBURG")) %>%
        str_replace_all(c(" N " = " NORTH ", " E " = " EAST ", " S " = " SOUTH ", " W " = " WEST ", " NE | NORTHEAST "= " NORTH EAST ", " SE | SOUTHEAST " = " SOUTH EAST ", " NW | NORTHWEST " = " NORTH WEST ", " SW | SOUTHWEST " = " SOUTH WEST " )) %>% 
        as.data.frame() 
     
      
      next
    }
    loopaddress <- loopaddress
    }
    loopaddress <- as.data.frame(loopaddress)  
    addresses <- bind_rows(addresses, loopaddress)
  }

