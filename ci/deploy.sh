#!/usr/bin/env bash
set -e
source ./config.sh

export VERSION=$1
export IMAGE_URL="$ECR_REGISTRY/$2"
APP_SPEC_FILE="appspec-$VERSION.json"

# parse deployment definition
envsubst < "appspec.json.tpl" > $APP_SPEC_FILE

# parse task definition
envsubst < "ecs-task.json.tpl" > "ecs-task.json"

aws ecs register-task-definition \
    --cli-input-json file://ecs-task.json \
    --region eu-west-1

#aws deploy create-deployment \
#    --application-name newweb-experiment \
#    --deployment-group-name newweb-experiment-deploy \
#    --description "Deployment" \
#    --s3-location bucket=newweb-experiment-deployment,bundleType=JSON,key=appspec.json



