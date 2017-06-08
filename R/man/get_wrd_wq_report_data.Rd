\name{get_wrd_wq_report_data}
\alias{get_wrd_wq_report_data}
\title{Get water quality report data}
\usage{
get_wrd_wq_report_data(url, start_date, end_date, location_name, analytes_list, guideline_list)
}
\description{
Fetch water quality report data in the WRD system
}
\examples{
report_data <- get_wrd_wq_report_data("http://wrd_url", 
                               "Jan 01, 2016", "May 26, 2017", "test-location", 
                               c("Aluminum (Al)-Total", "Aluminum (Al)-Dissolved"), 
                               c("guidline1", "guidelin2"))
}
