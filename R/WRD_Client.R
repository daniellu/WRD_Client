# https://cran.rstudio.com/bin/windows/contrib/3.4/RCurl_1.95-4.8.zip
# install packages
library(rjson)
library(RCurl)

get_guideline_list <- function(wrd_url){
  guideline_list_part <- "/API/WaterQualityGuideline"
  request_url <- paste(wrd_url, guideline_list_part)
  guideline_list_data <- fromJSON(getURL(request_url))
  
  return(guideline_list_data)
}

get_guideline_detail_list <- function(wrd_url){
  guideline_detail_list_part <- "/API/WaterQualityGuideline/Detail"
  request_url <- paste(wrd_url, guideline_detail_list_part)
  data <- fromJSON(getURI(request_url))
  
  return(data)
}

get_location_list <- function(wrd_url, curl_handler){
  location_list_part <- "/API/WaterQuality/Location/List"
  request_url <- paste(wrd_url, location_list_part)
  data <- fromJSON(getURI(request_url, curl = curl_handler))
  
  return(data)
}

log_on <- function(wrd_url, username, password){
  loginurl <- paste(wrd_url, "/Account/LogOn")
  #Set user account data and agent
  pars=list(
    Username=username,
    Password=password
  )
  agent="Mozilla/5.0" #or whatever 
  
  #Set RCurl pars
  curl = getCurlHandle()
  curlSetOpt(cookiejar="cookies.txt",  useragent = agent, followlocation = TRUE, curl=curl)
  
  #Post login form
  html=postForm(loginurl, .params = pars, curl=curl)
  
  return(curl)
}

wrd_url <- "http://localhost:50772"

list_data <- get_guideline_list(wrd_url)
detail_data <- get_guideline_detail_list(wrd_url)

curl_handler <- log_on(wrd_url, "Wellgreen", "Welcome123!")

location_list_data <- get_location_list(wrd_url, curl_handler)
print(location_list_data)



