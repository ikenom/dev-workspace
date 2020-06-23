#!/bin/bash

# Parse arguments.
while getopts 'c:u:n:p:' arg; do
  case "${arg}" in
    c) CONTAINER_REGISTRY=${OPTARG} ;;
    u) CONTAINER_REGISTRY_USERNAME=${OPTARG} ;;
    p) CONTAINER_REGISTRY_PASSWORD=${OPTARG} ;;
  esac
done

HELM_CHART_NAME=dev-workspace

echo $CONTAINER_REGISTRY_PASSWORD | docker login ${CONTAINER_REGISTRY} \
  --username $CONTAINER_REGISTRY_USERNAME \
  --password-stdin

docker build -t push-helm-chart . --file Dockerfile.push-helm-chart

docker run \
  --env HELM_CHART_NAME=$HELM_CHART_NAME \
  --env CONTAINER_REGISTRY=$CONTAINER_REGISTRY \
  --env CONTAINER_REGISTRY_USERNAME=$CONTAINER_REGISTRY_USERNAME \
  --env CONTAINER_REGISTRY_PASSWORD=$CONTAINER_REGISTRY_PASSWORD \
  push-helm-chart \
