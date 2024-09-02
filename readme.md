# Create Sitewise Asset Models and Assets for the DFO asset monitoring POC
- This repo contains the artifacts needed to deploy the needed Sitewise and IoT Core rules to direct messages to the Sitewise assets.
- Note that this uses cloudformation YAML templates and CLI commands to deploy. Setting up the CLI and necessary credentials is a prerequisite.
- These YAML and JSON files can be modified to create similar Sitewise representations for assets and properties unique to respective business case. These represent only the DFO specific assets for the POC effort.

# Create Sitewise Asset Models
- Create generic asset model that represents the device being mointored. 
    - The attributes are to be updated when creating the asset for this generic model. (ie: thresholds and category of the specific asset that inherits this generic model.)

` aws cloudformation create-stack --stack-name dfo-sw-assetmodel-generic-device --template-body file://dfo-assetmodel-generic-device.yaml --profile asea-session --region ca-central-1 `

- Create the asset models that represent the hierachy. **DFO->Regions->Labs->Assets**

``` aws cloudformation create-stack --stack-name dfo-sw-assetmodel-generic-hierachy --template-body file://dfo-assetmodel-generic-hierarchy.yaml --profile asea-session --region ca-central-1 ```

- Create the respective assets that reference the asset models created in previous steps.

``` aws cloudformation create-stack --stack-name dfo-sw-generic-assets --template-body file://dfo-assets-create-from-generic-model.yaml --profile asea-session --region ca-central-1 ```

- Update the attributes for the created assets. These will override any default values created/inherited from the asset model defiition(s).
- *Note that these files will need to be updated with the respective Asset and Property Ids created in previous steps. It also requires that a current timestamp value in ms (timeInSeconds) is needed to ensure the changes are applied. At the moment there is no easier way to do this so tedious copy and paste/replace is required...but this is only required once...*

` aws iotsitewise batch-put-asset-property-value --cli-input-json file://batch-update-microscope-attributes.json --profile asea-session --region ca-central-1 `

` aws iotsitewise batch-put-asset-property-value --cli-input-json file://batch-update-flowcam-attributes.json --profile asea-session --region ca-central-1 `

` aws iotsitewise batch-put-asset-property-value --cli-input-json file://batch-update-particleanalyzer-attributes.json --profile asea-session --region ca-central-1 `

# Setup the IoT Core rule to route topic data to Sitewise 

` aws iot create-topic-rule --rule-name "Dfo_AssetUsage_To_Sitewise" --topic-rule-payload file://dfo-iot-2-sw-routing.json --profile asea-session --region ca-central-1 `

<<TODO>>
Create a rule for directing Iot core messages to location service

# Cleanup

- Delete the assets and assetmodels in this order. *(The assets first, the hierarchies second, and the generic asset model last)*

` aws cloudformation delete-stack --stack-name dfo-sw-generic-assets --profile asea-session --region ca-central-1 `
` aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-generic-hierachy --profile asea-session --region ca-central-1 `
` aws cloudformation delete-stack --stack-name dfo-sw-assetmodel-generic-device --profile asea-session --region ca-central-1 `

# Notes for development

- Provide script/yaml for following scenarios:
    - Creating a new Region asset (post initialization)
    - Creating a new Lab asset (post initialization)
    - Assigning new assets to a new Lab asset
    - Assigning existing assets to a different Lab