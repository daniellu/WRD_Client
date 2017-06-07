## Compatible with WRD V5.0.2.2

## R
Depend on libraries jsonlit, httr
### Authenticate client
Parameters: 
- url Of WRD (url must not end with slash "/"), 
- username, 
- password

Example: 
```R
library(jsonlite)
library(httr)
authenticate_wrd("http://exampleWRD", "example_username", "example_password")
```
Output:

### Get location list
Parameters: 
- url Of WRD (url must not end with slash "/"), 

Example: 
```R
location_list_data <- get_location_list(wrd_url)
```
Output: 
```R
list of location data
```

### Get location detail
Parameters: 
- Location Ids string

Example: 
```R

```
Output: 
```R

```

### Get guidelines list
Parameters: None

Example: 
```R
list_data <- get_guideline_list(wrd_url)
```
Output: 
```R

```

### Get guidelines detail list
Parameters: None

Example: 
```R
detail_data <- get_guideline_detail_list(wrd_url)
```
Output: 
```json

```

### Get analyte data and calculated guideline data
Parameters: 
- Start Date, 
- End Date, 
- Station Name, 
- Analyte Names, 
- Guideline Names

Example: 
```python
report_data <- get_report_data(wrd_url, 
                               "Jan 01, 2016", "May 26, 2017", "DR-195.8", 
                               c("Aluminum (Al)-Total", "Aluminum (Al)-Dissolved"), 
                               c("BC_WWS_ST", "Yukon"))
```
Output: