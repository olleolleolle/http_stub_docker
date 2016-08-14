#!/usr/bin/env bash

APP_NAME=$1
APP_VERSION=$2
AWS_IMAGE_TAG="$AWS_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$APP_NAME:$APP_VERSION"

eval $(aws ecr get-login --region "$AWS_REGION")
docker tag "$APP_NAME" "$AWS_IMAGE_TAG"
docker push "$AWS_IMAGE_TAG"
