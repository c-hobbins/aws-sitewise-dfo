#!/bin/sh

#Create the Models (lowest in the hierarchy first...IOT Device->Zone Devices->Datacenter Devices)

#Sensor Device

{
    "assetModelName" "SSC Sensor Device Asset Model",
    "assetModelDescription": "Representation of a devices in a particular zone of the datacenter",
    "assetModelProperties": [
        {
            "name": "serialNum",
            "dataType": "STRING",
            "type": {
                "attribute": {
                    "defaultValue": "DPI-SENSOR-KIT-001"
                }
            }
        },
        {
            "name": "devicePlatformOs",
            "dataType": "STRING",
            "type": {
                "attribute": {
                    "defaultValue": "Pi3"
                }
            }
        },
        {
            "name": "Temperature",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            },
            "unit": "celsius"
        },
        {
            "name": "Humidity",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            }
        },
        {
            "name": "Co2",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            },
            "unit": "ppm"
        },
        {
            "name": "Sound",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            },
            "unit": "db"
        },
        {
            "name": "Gas",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            },
            "unit": "ppm"
        },
        {
            "name": "Dust",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            },
            "unit": "pm"
        },
        {
            "name": "Tvoc",
            "dataType": "DOUBLE",
            "type": {
                "measurement": {}
            }
        }
    ],
    "assetModelHierarchies": [],
    "tags": {
        "Owner": "chobbins",
        "Project": "datacenter-iot-poc"
    }
}