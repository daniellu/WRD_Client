#Compatible with WRD V5.0.2.2
# install packages
library(jsonlite)
library(httr)

get_guideline_list <- function(wrd_url){
  guideline_list_part <- "/API/WaterQualityGuideline"
  request_url <- paste(wrd_url, guideline_list_part, sep="")
  response <- GET(request_url)
  
  if(status_code(response) == 200){
    guideline_list_data <- content(response)
    return(guideline_list_data)
  }
  
  stop("Fail to get guideline list data from WRD, please try again or contact the EIS team.")
}

get_guideline_detail_list <- function(wrd_url){
  guideline_detail_list_part <- "/API/WaterQualityGuideline/Detail"
  request_url <- paste(wrd_url, guideline_detail_list_part, sep="")
  response <- GET(request_url)
  
  if(status_code(response) == 200){
    guideline_detail_list_data <- content(response)
    return(guideline_detail_list_data)
  }
  
  stop("Fail to get guideline detail data from WRD, please try again or contact the EIS team.")
}

get_location_list <- function(wrd_url){
  location_list_part <- "/API/WaterQuality/Location/List"
  request_url <- paste(wrd_url, location_list_part, sep="")
  res <- GET(request_url)
  if(status_code(res) == 200){
    location_content = content(res)
    
    data = lapply(location_content, function(x){ 
      return(
        list(LocationIdentifier=x$LocationIdentifier,
             Description=x$LocationDescription,
             Latitude=x$Latitude,
             Longtitude=x$Longtitude,
             LocationType=x$LocationType)
        )
      })
    
    return(data)  
  }
  else{
    stop("Fail to fetch location list data from WRD, please try again or contact the EIS team.")
  }
  
}

get_location_detail <- function(wrd_url, locationId){
  location_detail_part <- "/API/WaterQuality/Location/Detail/"
  request_url <- paste(wrd_url, location_detail_part, locationId, sep="")
  res <- GET(request_url)
  if(status_code(res) == 200){
    location_content = content(res)
    
    location_data = lapply(location_content$Locations, function(x){ 
      return(
        list(LocationName=x$Name,
             LocationType=x$Type,
             Notes=x$Notes)
      )
    })
    
    wq_data = lapply(location_content$WaterQualityDatasets, function(x){ 
      return(
        list(LocationName=x$LocationName,
             Analyte=x$Analyte,
             NumberOfRecords=x$NumberOfRecords,
             FirstRecordDate=x$FirstRecordDate,
             LastRecordDate=x$LastRecordDate)
      )
    })
    
    data = list(Locations=location_data, Analytes=wq_data)
    
    return(data)  
  }
  else{
    stop("Fail to fetch location detail data from WRD, please try again or contact the EIS team.")
  }
}

authenticate_wrd <- function(wrd_url, username, password){
  loginurl <- paste(wrd_url, "/Account/LogOn", sep="")
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
  report_data_url <- paste(wrd_url, "/API/WaterQuality/Graph", sep="")
  
  analyte_data = lapply(analytes, function(x){ return(list(Analyte=x,LocationName=station))})
  guideline_data = lapply(guidelines, function(x){ return(list(GuidelineName=x))})
  
  args=list(
    StartDate=start_date,
    EndDate=end_date,
    StationName=station,
    WaterQualityDatasets=analyte_data,
    WaterQualityStandards=guideline_data
  )
  response <- POST(
    url = report_data_url,
    body = toJSON(args, auto_unbox=TRUE),
    content_type_json(),
    encode = "json"
  )
  
  if(status_code(response) == 200){
    raw_content = content(response)
    
    analyte_result_data = lapply(raw_content$AnalytesData, 
                                 function(x){ 
                                   return(
                                     list(AnalyteName=x$AnalyteName,
                                          Location=x$StationId,
                                          Unit=x$Unit,
                                          Points=lapply(x$Points, function(p){
                                            return(list(
                                              DateTime=p$DateTime,
                                              Value=p$Value,
                                              DetectionLimit=p$DetectionLimit
                                            ))
                                          }))
                                     )})
    
    guideline_result_data = lapply(raw_content$StandardData, 
                                 function(x){ 
                                   return(
                                     list(GuidelineName=x$GuidelineName,
                                          AnalyteName=x$AnalyteName,
                                          Location=x$StationId,
                                          Unit=x$Unit,
                                          Points=lapply(x$StandardValuePoints, function(p){
                                            return(list(
                                              DateTime=p$DateTime,
                                              Value=p$Value
                                            ))
                                          }))
                                   )})
    
    result <- list(AnalytesData=analyte_result_data,GuidelineData=guideline_result_data)
    return(result)
  }
  
  stop("Fail to get report data from WRD, please try again or contact the EIS team.")
  
}






