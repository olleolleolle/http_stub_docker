#!/usr/bin/env bash

set -e

CONFIG_BUCKET_NAME="http-stub-docker-terraform-config"

function usage() {
  cat << EOF
Usage: $(basename "$0") [command] [environment...]

Commands:
  plan    Preview the changes to be made by Terraform
  apply   Create all necessary AWS resources using Terraform
  destroy Destroy AWS resources created by Terraform
  help    Display this usage information
EOF
}

function log_start() {
  if [ "$TRAVIS" = "true" ]; then
    echo "travis_fold:start:$1"
  else
    echo "$1: Started"
  fi
}

function log_end() {
  if [ "$TRAVIS" = "true" ]; then
    echo "travis_fold:end:$1"
  else
    echo "$1: Finished"
  fi
}

function sync_remote_config() {
  terraform remote config \
    -backend=s3 \
    -backend-config="bucket=$CONFIG_BUCKET_NAME" \
    -backend-config="key=tests.tfstate" \
    -backend-config="region=$AWS_REGION"

  terraform get
}

function run_terraform() {
  cd "spec/ops"
  sync_remote_config
  terraform "$@"
}

COMMAND="$1"
TF_VAR_aws_region="$AWS_REGION"

case "$COMMAND" in
  plan)
    log_start "Terraform plan"
    run_terraform plan
    log_end "Terraform plan"
    ;;
  apply)
    log_start "Terraform apply"
    run_terraform apply
    log_end "Terraform apply"
    ;;
  destroy)
    log_start "Terraform destroy"
    run_terraform destroy
    log_end "Terraform destroy"
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage && exit 1
    ;;
esac
