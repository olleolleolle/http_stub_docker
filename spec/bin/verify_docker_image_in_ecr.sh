#!/usr/bin/env bash

set -e

repository_name=$1
image_tag=$2

eval $(aws ecr get-login --region "$AWS_REGION")
echo "Verifying repository $repository_name has image with tag $image_tag..."
aws ecr describe-images --repository-name "$repository_name" --image-ids imageTag="$image_tag"
