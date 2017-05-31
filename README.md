# WRD_Client
WRD client in various language

## Python

### initial client
Parameters: url Of WRD, username, password
Example: client = wrd_client.WRDClient(wrdUrl='http://exampleWRD', username="example_username", password="example_password")
Output:

### Get location list
Parameters: None
Example: locationData = client.get_locations()
Output: [{'Name': 'TestStation-1', 'Longtitude': -133.521, 'Description': 'TestStation-1', 'Latitude': 65.461}, {'Name': 'TestStation-2', 'Longtitude': -134.525, 'Description': 'TestStation-2 Description', 'Latitude': 65.4671}]

### Get location detail
Parameters: Location Ids string
Example: locationDetailData = client.get_locations_detail("Examplle-Station")
Output: {'Location': 'Test-Location-0.1', 'Analytes': [{'Analyte': 'Anion Sum', 'NumberOfRecords': 5, 'LastRecordDate': '2015-12-17T16:20:00', 'FirstRecordDate': '2015-06-24T14:30:00'}, {'Analyte': 'Antimony (Sb)-Dissolved', 'NumberOfRecords': 18, 'LastRecordDate': '2016-10-17T10:00:00', 'FirstRecordDate': '2014-01-23T00:00:00'}]}

### Get guidelines list
Parameters: None
Example: guidelineData = client.get_guidelines()
Output: [{'GuidelineName': 'BC_AWQG_STMAX', 'GuidelineLongName': 'BC Approved Water Quality Guideline - Freshwater Aquatic Life - Short Term Max', 'Id': 1}, {'GuidelineName': 'BC_AWQG_LTAVE', 'GuidelineLongName': 'BC Approved Water Quality Guideline - Freshwater Aquatic Life - Long Term Average', 'Id': 2}]

### Get guidelines detail list
Parameters: None
Example: guidelineDetailData = client.get_guidelines_detail()
Output: [{'AvailableAnalytes': [{'StandardValue': '0.0013', 'ReferenceSource': '', 'Unit': 'mg/L', 'Id': 65, 'AnalyteName': 'Cadmium (Cd)-Dissolved'}, {'StandardValue': '0.332', 'ReferenceSource': '', 'Unit': 'mg/L', 'Id': 66, 'AnalyteName': 'Zinc (Zn)-Total'}], 'GuidelineName': 'Test', 'Id': 123, 'GuidelineLongName': 'Test Long Name'}]

### Get analyte data and calculated guideline data
Parameters: Start Date, End Date, Station Name, Analyte Names, Guideline Names
Example: graphData = client.get_graph_data(start_date="Jan 01, 2016", end_date="Dec 31, 2016", station_name="DR-195.8", analytes=["Aluminum (Al)-Total"], guidelines=["BC_WWS_ST"])
Output: