#!/usr/bin/env bash

set -e

REPOSITORY_NAME=$1
IMAGE_TAG=$2

eval $(aws ecr get-login --region "$AWS_REGION")
aws ecr describe-images --repository-name "$REPOSITORY_NAME" --image-ids imageTag="$IMAGE_TAG"
