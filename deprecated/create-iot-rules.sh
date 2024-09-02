#!/bin/sh
aws iot create-topic-rule --rule-name "SendToSitewise_Sensor1" --topic-rule-payload file://iot-topic-rule001.json --profile dedp-session --region ca-central-1
aws iot create-topic-rule --rule-name "SendToSitewise_Sensor2" --topic-rule-payload file://iot-topic-rule002.json --profile dedp-session --region ca-central-1
aws iot create-topic-rule --rule-name "SendToSitewise_Sensor3" --topic-rule-payload file://iot-topic-rule003.json --profile dedp-session --region ca-central-1
aws iot create-topic-rule --rule-name "SendToSitewise_Sensor4" --topic-rule-payload file://iot-topic-rule004.json --profile dedp-session --region ca-central-1
aws iot create-topic-rule --rule-name "SendToSitewise_Sensor5" --topic-rule-payload file://iot-topic-rule005.json --profile dedp-session --region ca-central-1
aws iot create-topic-rule --rule-name "SendToSitewise_Sensor6" --topic-rule-payload file://iot-topic-rule006.json --profile dedp-session --region ca-central-1