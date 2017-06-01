# Author D.L
# Last update at May 29, 2017
import requests


class WRDClient():
    def __init__(self, wrdUrl, username, password):
        self.logon_url = "/Account/LogOn"
        self.location_list_url = "/API/WaterQuality/Location/List"
        self.location_detail_url = "/API/WaterQuality/Location/Detail/"
        self.guideline_list_url = "/API/WaterQualityGuideline"
        self.guideline_detail_url = "/API/WaterQualityGuideline/Detail"
        self.graph_data_url = "/API/WaterQuality/Graph"
        self.root_url = wrdUrl

        headers = {'User-Agent': 'Mozilla/5.0'}
        payload = {'Username': username, 'Password': password}

        self.session = requests.session()
        r = self.session.post(self.root_url + self.logon_url, headers=headers, data=payload)
        if 200 == r.status_code:
            return
        else:
            print("Authentication session fail with status code:" + r.status_code)
            raise RuntimeError("Get location fail with status code" + r.status_code)

    def __del__(self):        
        self.session.close()

    def get_locations(self):
        response = self.__httpGet(self.root_url + self.location_list_url)
        data = list(map(lambda x: {
            "Name": x["LocationIdentifier"],
            "Description": x["LocationDescription"],
            "Latitude": x["Latitude"],
            "Longtitude": x["Longtitude"]}, response))
        return data

    def get_locations_detail(self, locationIds):
        response = self.__httpGet(self.root_url + self.location_detail_url + locationIds)
        data = {
            "Location": response["Locations"][0]["Name"],
            "Analytes": list(map(lambda x:
                                 {"Analyte": x["Analyte"],
                                  "FirstRecordDate": x["FirstRecordDate"],
                                  "LastRecordDate": x["LastRecordDate"],
                                  "NumberOfRecords": x["NumberOfRecords"]}, response["WaterQualityDatasets"]))
        }
        return data

    def get_guidelines(self):
        response = self.__httpGet(self.root_url + self.guideline_list_url)
        data = list(map(lambda x: {
            "Id": x["Id"],
            "GuidelineName": x["GuidelineName"],
            "GuidelineLongName": x["GuidelineLongName"]}, response))
        return data

    def get_guidelines_detail(self):
        return self.__httpGet(self.root_url + self.guideline_detail_url)

    def get_graph_data(self, start_date, end_date, station_name, analytes, guidelines):
        payload = {
            "StartDate": start_date,
            "EndDate": end_date,
            "IncludeDischargeData": False,
            "StationName": station_name,
            "WaterQualityStandards": list(map(lambda x: {"GuidelineName": x}, guidelines)),
            "WaterQualityDatasets": list(map(lambda x: {"Analyte": x, "LocationName": station_name}, analytes))
        }
        http_data = self.__httpPost(url=(self.root_url + self.graph_data_url), json_data=payload)

        data = {"Location": station_name,
                "AnalytesData": list(map(lambda x: {
                    "Location": x["StationId"],
                    "Analyte": x["AnalyteName"],
                    "Unit": x["Unit"],
                    "Points": list(map(lambda p: {
                        "DateTime": p["DateTime"],
                        "Value": p["Value"],
                        "DetectionLimit": p["DetectionLimit"]}, x["Points"]))}, http_data["AnalytesData"])),
                "GuidelineData": list(map(lambda x: {
                    "GuidelineName": x["GuidelineName"],
                    "Analyte": x["AnalyteName"],
                    "Points": list(map(lambda p: {
                        "DateTime": p["DateTime"],
                        "Value": p["Value"]}, x["StandardValuePoints"]))}, http_data["StandardData"]))}
        return data

    def __httpGet(self, url):
        response = self.session.get(url)
        if 200 == response.status_code:
            return response.json()
        else:
            print("Get data fail with status code" + str(response.status_code))
            raise ConnectionError("Get data fail with status code" + str(response.status_code))

    def __httpPost(self, url, json_data):
        response = self.session.post(url, json=json_data)
        if 200 == response.status_code:
            return response.json()
        else:
            print("Get data fail with status code" + str(response.status_code))
            raise ConnectionError("Get data fail with status code" + str(response.status_code))
