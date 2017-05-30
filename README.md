# WRD_Client
WRD client in various language

## Python

### initial client
Parameters: url Of WRD, username, password
Example: client = wrd_client.WRDClient(wrdUrl='http://exampleWRD', username="example_username", password="example_password")

### Get location list
Parameters: None
Example: locationData = client.get_locations()

### Get location detail
Parameters: Location Ids string
Example: locationDetailData = client.get_locations_detail("Examplle-Station")

### Get guidelines list
Parameters: None
Example: guidelineData = client.get_guidelines()

### Get guidelines detail list
Parameters: None
Example: guidelineDetailData = client.get_guidelines_detail()

### Get analyte data and calculated guideline data
Parameters: Start Date, End Date, Station Name, Analyte Names, Guideline Names
Example: graphData = client.get_graph_data(start_date="Jan 01, 2016", end_date="Dec 31, 2016", station_name="DR-195.8", analytes=["Aluminum (Al)-Total"], guidelines=["BC_WWS_ST"])