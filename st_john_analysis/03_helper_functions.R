##HELPER FUNCTIONS

calc_age <- function(birthDate, refDate = Sys.Date()) {
  
  require(lubridate)
  
  period <- as.period(interval(birthDate, refDate),
                      unit = "year")
  
  period$year
  
} 
