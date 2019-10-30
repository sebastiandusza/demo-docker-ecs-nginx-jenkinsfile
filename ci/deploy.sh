#!/usr/bin/env bash
set -e
source ./ci/config.sh

export VERSION=$1
export IMAGE_URL="$ECR_REGISTRY/$2"
APP_SPEC_FILE="appspec-$VERSION.json"

# parse & publish task definition
envsubst < "ci/ecs-task.json.tpl" > "ci/ecs-task.json"
export TASK_DEFINITION_ARN=`aws ecs register-task-definition --cli-input-json file://ci/ecs-task.json --region eu-west-1 | jq -r .taskDefinition.taskDefinitionArn`

# parse & publish deployment definition
envsubst < "ci/appspec.json.tpl" > "ci/$APP_SPEC_FILE"
aws s3 cp "ci/$APP_SPEC_FILE" s3://newweb-experiment-deployment

# deploy
aws deploy create-deployment \
    --application-name newweb-experiment \
    --deployment-group-name newweb-experiment-deploy \
    --description "Deployment $VERSION" \
    --s3-location bucket=newweb-experiment-deployment,bundleType=JSON,key=$APP_SPEC_FILE



