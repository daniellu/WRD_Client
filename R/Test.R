library(jsonlite)
library(httr)

wrd_url <- "http://localhost:50772"

#list_data <- get_guideline_list(wrd_url)
#detail_data <- get_guideline_detail_list(wrd_url)

authenticate_wrd(wrd_url, "Wellgreen", "Welcome123!")
#location_list_data <- get_location_list(wrd_url)

analyte_data <- c("Aluminum (Al)-Total")
guideline_data <- c("BC_WWS_ST")

report_data <- get_report_data(wrd_url, curl_handler, 
                               "Jan 01, 2016", "May 26, 2017", "DR-195.8", 
                               analyte_data, guideline_data)
print(report_data)

