# https://cran.rstudio.com/bin/windows/contrib/3.4/RCurl_1.95-4.8.zip
# install packages
library(jsonlite)
library(httr)

get_guideline_list <- function(wrd_url){
  guideline_list_part <- "/API/WaterQualityGuideline"
  request_url <- paste(wrd_url, guideline_list_part)
  response <- GET(request_url)
  guideline_list_data <- content(response)
  
  return(guideline_list_data)
}

get_guideline_detail_list <- function(wrd_url){
  guideline_detail_list_part <- "/API/WaterQualityGuideline/Detail"
  request_url <- paste(wrd_url, guideline_detail_list_part)
  response <- GET(request_url)
  guideline_detail_list_data <- content(response)
  
  return(guideline_detail_list_data)
}

get_location_list <- function(wrd_url, curl_handler){
  location_list_part <- "/API/WaterQuality/Location/List"
  request_url <- paste(wrd_url, location_list_part)
  data <- GET(request_url)
  return(content(data))
}

authenticate_wrd <- function(wrd_url, username, password){
  loginurl <- paste(wrd_url, "/Account/LogOn")
  #Set user account data and agent
  pars=list(
    Username=username,
    Password=password
  )
  agent="Mozilla/5.0" #or whatever 
  
  res <- POST(loginurl, body = pars, encode = "form")
}

get_report_data <- function(wrd_url, curl_handler, 
                            start_date, end_date, station, analytes, guidelines){
  report_data_url <- paste(wrd_url, "/API/WaterQuality/Graph")
  
  analyte_data = lapply(analytes, function(x){ return(list(Analyte=x,LocationName=station))})
  guideline_data = lapply(guidelines, function(x){ return(list(GuidelineName=x))})
  
  args=list(
    StartDate=start_date,
    EndDate=end_date,
    StationName=station,
    WaterQualityDatasets=analyte_data,
    WaterQualityStandards=guideline_data
  )
  res <- POST(
    url = report_data_url,
    body = toJSON(args, auto_unbox=TRUE),
    content_type_json(),
    encode = "json",
    verbose()
  )
  return(content(res))
}






