# https://cran.rstudio.com/bin/windows/contrib/3.4/RCurl_1.95-4.8.zip
# install packages
library(jsonlite)
library(httr)

get_guideline_list <- function(wrd_url){
  guideline_list_part <- "/API/WaterQualityGuideline"
  request_url <- paste(wrd_url, guideline_list_part)
  response <- GET(request_url)
  guideline_list_data <- fromJSON(str(content(response)))
  
  return(guideline_list_data)
}

get_guideline_detail_list <- function(wrd_url){
  guideline_detail_list_part <- "/API/WaterQualityGuideline/Detail"
  request_url <- paste(wrd_url, guideline_detail_list_part)
  response <- GET(request_url)
  guideline_detail_list_data <- fromJSON(str(content(response)))
  
  return(guideline_detail_list_data)
}

get_location_list <- function(wrd_url, curl_handler){
  location_list_part <- "/API/WaterQuality/Location/List"
  request_url <- paste(wrd_url, location_list_part)
  data <- GET(request_url)
  return(data)
}

authenticate_wrd <- function(wrd_url, username, password){
  loginurl <- paste(wrd_url, "/Account/LogOn")
  #Set user account data and agent
  pars=list(
    Username=username,
    Password=password
  )
  agent="Mozilla/5.0" #or whatever 
  
  res <- POST(loginurl, body = pars, encode = "form", verbose())
}

get_report_data <- function(wrd_url, curl_handler, 
                            start_date, end_date, station, analytes, guidelines){
  report_data_url <- paste(wrd_url, "/API/WaterQuality/Graph")
  
  analyte_data = lapply(analytes, function(x){ return(list(Analyte=x,LocationName=station))})
  print(analyte_data)
  guideline_data = lapply(guidelines, function(x){ return(list(GuidelineName=x))})
  print(guideline_data)
  
  pars=list(
    StartDate=start_date,
    EndDate=end_date,
    StationName=station,
    WaterQualityDatasets=analyte_data,
    WaterQualityStandards=guideline_data
  )
  
  print(pars)
  res <- POST(report_data_url, body = pars, encode = "form", verbose())
  return(res)
}


wrd_url <- "http://localhost:50772"

#list_data <- get_guideline_list(wrd_url)
#detail_data <- get_guideline_detail_list(wrd_url)

authenticate_wrd(wrd_url, "Wellgreen", "Welcome123!")
location_list_data <- get_location_list(wrd_url)

analyte_data <- c("Aluminum (Al)-Total")
guideline_data <- c("BC_WWS_ST")

report_data <- get_report_data(wrd_url, curl_handler, 
                               "Jan 01, 2016", "May 26, 2017", "DR-195.8", 
                               analyte_data, guideline_data)
print(report_data)



