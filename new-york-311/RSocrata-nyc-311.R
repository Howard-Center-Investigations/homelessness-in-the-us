install.packages("RSocrata")
library("RSocrata")

nyc_calls <- read.socrata("https://data.cityofnewyork.us/resource/erm2-nwe9.json", app_token = "sav4xaGEwiE0R6flJydiXCMM9", email = "theresarose0830@gmail.com", password = "Harfleur8**")