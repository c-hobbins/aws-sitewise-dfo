#!/bin/bash

BASE_ASSET_MODEL_NAME="IoT Device"

#if ! grep -q aws_access_key_id ~/.aws/config; then
#  if ! grep -q aws_access_key_id ~/.aws/credentials; then
#    echo "AWS config not found or CLI not installed. Please run \"aws configure\"."
#    exit 1
#  fi
#fi

#echo "This script will create the S3 IAM user, generate IAM keys, add to IAM group, generate user policy."
#read -r -p "Enter the client name: " CLIENT

#create the sitewise asset models. create the hierarchy and pass in the value of the asset id??
#will require 
#BASE_ASSET_MODEL_ID=$(aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 --query 'assetModelSummaries[?name==`IoT Device"`].id' 2>&1)


#BASE_ASSET_MODEL_ID=$(aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 | jq '.[] | select(.name == "IoT Device")')
BASE_ASSET_MODEL_ID=$(aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 | jq --arg asset_name "$BASE_ASSET_MODEL_NAME" '.assetModelSummaries[] | select(.name == $asset_name) | .id')

#aws iotsitewise list-asset-models --profile dedp-session --region ca-central-1 | jq '.[] | select(.id == "c720cb80-3ac1-40da-99d2-f5d922e55b13")'
echo "Asset Model Id: " $BASE_ASSET_MODEL_ID

# aws cloudformation validate-template --template-body file://base-asset-model.yaml --profile asea-session --region ca-central-1

# aws cloudformation create-stack --stack-name dfo-sw-assetmodel-microscope --template-body file://dfo-assetmodel-microscope.yaml --profile asea-session --region ca-central-1
# aws cloudformation create-stack --stack-name dfo-sw-assetmodel-flowcam --template-body file://dfo-assetmodel-flowcam.yaml --profile asea-session --region ca-central-1
# aws cloudformation create-stack --stack-name dfo-sw-assetmodel-particle-analyzer --template-body file://dfo-assetmodel-particle_analyzer.yaml --profile asea-session --region ca-central-1
# aws cloudformation create-stack --stack-name dfo-sw-assetmodel-hierachy --template-body file://dfo-assetmodel-hierarchy.yaml --profile asea-session --region ca-central-1
# aws cloudformation create-stack --stack-name dfo-sw-assets --template-body file://dfo-assets-create.yaml --profile asea-session --region ca-central-1

# aws cloudformation delete-stack --stack-name dfo-sw-assets --profile asea-session --region ca-central-1
# aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-hierachy --profile asea-session --region ca-central-1 
# aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-particle-analyzer --profile asea-session --region ca-central-1
# aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-flowcam --profile asea-session --region ca-central-1
# aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-microscope --profile asea-session --region ca-central-1

aws cloudformation update-stack --stack-name dfo-sw-assetmodel-microscope --template-body file://dfo-assetmodel-microscope.yaml --profile asea-session --region ca-central-1
aws cloudformation update-stack --stack-name dfo-sw-assets --template-body file://dfo-assets-create.yaml --profile asea-session --region ca-central-1


#Test generic model and asset creation
aws cloudformation create-stack --stack-name dfo-sw-assetmodel-generic-device --template-body file://dfo-assetmodel-generic-device.yaml --profile asea-session --region ca-central-1
aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-generic-device --profile asea-session --region ca-central-1

aws iotsitewise batch-put-asset-property-value --cli-input-json file://batch-update-asset-attributes.json --profile asea-session --region ca-central-1

#Note the following plugins are to be created in the ECS Grafana
# grafana-googlesheets-datasource  grafana-iot-sitewise-datasource  yesoreyeram-infinity-datasource
