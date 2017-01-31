#!/usr/bin/env bash

set -e

REPOSITORY_NAME=$1
IMAGE_TAG=$2

echo "Default Region: $AWS_DEFAULT_REGION"
eval $(aws ecr get-login --region "$AWS_REGION")
echo "Verifying repository $REPOSITORY_NAME has image with tag $IMAGE_TAG..."
aws ecr describe-images --repository-name "$REPOSITORY_NAME" --image-ids imageTag="$IMAGE_TAG"
