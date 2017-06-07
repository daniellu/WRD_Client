library(jsonlite)
library(httr)

wrd_url <- "http://localhost:50772"
authenticate_wrd(wrd_url, "Wellgreen", "Welcome123!")

guideline_list_data <- get_guideline_list(wrd_url)

df1 <- Reduce(rbind, guideline_list_data)


guideline_detail_data <- get_guideline_detail_list(wrd_url)
df2 <- Reduce(rbind, guideline_detail_data)

location_list_data <- get_location_list(wrd_url)
df3 <- Reduce(rbind, location_list_data)

location_detail_date <- get_location_detail(wrd_url, "AdC-0.1")

report_data <- get_report_data(wrd_url, 
                               "Jan 01, 2016", "May 26, 2017", "DR-195.8", 
                               c("Aluminum (Al)-Total", "Aluminum (Al)-Dissolved"), 
                               c("BC_WWS_ST", "Yukon"))

