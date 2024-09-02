#!/bin/sh
aws iot create-topic-rule --rule-name "Dfo_AssetUsage_To_Sitewise" --topic-rule-payload file://dfo-iot-2-sw-routing.json --profile asea-session --region ca-central-1