#!/bin/sh
BASE_ASSET_MODEL_NAME="Test IoT Device"

#Create the base device Asset Model in Sitewise
RESPONSE=$(aws iotsitewise create-asset-model --asset-model-name "$BASE_ASSET_MODEL_NAME" --cli-input-json file://iotdevice-assetmodel.json --profile dedp-session --region ca-central-1 2>&1)

if [ $? -ne 0 ]; then
 	echo "Creating sitewise base asset model command failed. \n*ERROR*-> " $RESPONSE
    exit 1
else
    BAM_ID = echo $RESPONSE | jq '.assetModelId'
fi

echo $RESPONSE
echo $BAM_ID

BASE_ASSET_MODEL_ID=$(aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 | jq --arg asset_name "$BASE_ASSET_MODEL_NAME" '.assetModelSummaries[] | select(.name == $asset_name) | .id' 2>&1)

#aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 | jq '.[] | select(.id == "c720cb80-3ac1-40da-99d2-f5d922e55b13")'
echo "Created Asset Model Id: " $BASE_ASSET_MODEL_ID

#Create Assets (instances of this asset model for devices 1,2,3,4,5,6)
#These incllude the property aliases for each specific device property. (needed for the IOT Core rule mappings)

#Create Zone 1 Asset Model
#Create asset insatnce of this asset model.
#Update child hierarchies/asset associations for device assets 1,2

#Create Zone 2 Asset Model
#Create asset insatnce of this asset model.
#Update child hierarchies/asset associations for device assets 3,4


#Create Main Datacenter Asset Model
#Create asset insatnce of this asset model.
#Update child hierarchies/asset associations for zone assets 1,2

