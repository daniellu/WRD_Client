\name{get_location_detail}
\alias{get_location_detail}
\title{Get location detail data}
\usage{
get_location_detail(url, location id)
}
\description{
Fetch location list with detail data in the WRD system
}
\examples{
data <- get_location_detail("http://wrd_url", "test_locationId")
}
