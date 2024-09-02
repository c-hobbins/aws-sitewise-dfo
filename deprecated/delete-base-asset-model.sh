#!/bin/sh
BASE_ASSET_MODEL_NAME="Test IoT Device"

#Create the base device Asset Model in Sitewise
BASE_ASSET_MODEL_ID=$(aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 | jq --arg asset_name "$BASE_ASSET_MODEL_NAME" '.assetModelSummaries[] | select(.name == $asset_name) | .id' 2>&1)

if [ $? -ne 0 ]; then
 	echo "Creating sitewise base asset model command failed. \n*ERROR*-> " $RESPONSE
    exit 1
fi

echo "Deleting Asset Model..." $BASE_ASSET_MODEL_ID

RESP=$(aws iotsitewise delete-asset-model --asset-model-id $BASE_ASSET_MODEL_ID --profile dedp-session --region ca-central-1 2>&1)
if [ $? -ne 0 ]; then
    echo "Failed to delete. \nError-> " $RESP
else
    echo "Deleting...\n" $RESP
fi

#aws iotsitewise delete-asset-model --asset-model-id "ae0463bd-727c-4c71-bf92-8f0074c26919" --profile dedp-session --region ca-central-1 2>&1