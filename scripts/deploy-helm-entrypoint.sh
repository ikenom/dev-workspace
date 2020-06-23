#!/bin/bash

set -e

# Parse arguments.
while getopts 'c:u:n:p:' arg; do
  case "${arg}" in
    c) CONTAINER_REGISTRY=${OPTARG} ;;
    u) CONTAINER_REGISTRY_USERNAME=${OPTARG} ;;
    p) CONTAINER_REGISTRY_PASSWORD=${OPTARG} ;;
    n) HELM_CHART_NAME=${OPTARG} ;;
  esac
done

echo $CONTAINER_REGISTRY_PASSWORD | helm registry login ${CONTAINER_REGISTRY} \
  --username $CONTAINER_REGISTRY_USERNAME \
  --password-stdin

OUTPUT=( "$(helm chart save $HELM_CHART_NAME ${CONTAINER_REGISTRY}/dev-workspace)")
OUTPUTS=( $OUTPUT )
IMAGE_NAME=${OUTPUTS[1]}
helm chart push $IMAGE_NAME
