#!/usr/bin/env bash
set -e
source ./ci/config.sh

export VERSION=$1
export IMAGE_URL="$ECR_REGISTRY/$2"
APP_SPEC_FILE="ci/appspec-$VERSION.json"

# parse deployment definition
envsubst < "ci/appspec.json.tpl" > $APP_SPEC_FILE

# parse task definition
envsubst < "ci/ecs-task.json.tpl" > "ci/ecs-task.json"

aws ecs register-task-definition \
    --cli-input-json file://ci/ecs-task.json \
    --region eu-west-1

#aws deploy create-deployment \
#    --application-name newweb-experiment \
#    --deployment-group-name newweb-experiment-deploy \
#    --description "Deployment" \
#    --s3-location bucket=newweb-experiment-deployment,bundleType=JSON,key=appspec.json



