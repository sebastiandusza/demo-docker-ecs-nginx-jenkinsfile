#!/usr/bin/env bash
set -e
source ./ci/config.sh

export VERSION=$1

docker build --pull -t "experiment-nginx:latest" -f ./ci/Dockerfile .
docker tag "experiment-nginx:latest" "769910020948.dkr.ecr.eu-west-1.amazonaws.com/experiment-nginx:$VERSION"
$(aws ecr get-login --region "eu-west-1" --no-include-email)
docker push "769910020948.dkr.ecr.eu-west-1.amazonaws.com/experiment-nginx:$VERSION"

echo "Docker image experiment-nginx:$VERSION prepared and pushed"