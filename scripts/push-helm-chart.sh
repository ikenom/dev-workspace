#!/bin/bash

# Parse arguments.
while getopts 'c:u:n:p:r:s:v:' arg; do
  case "${arg}" in
    c) CONTAINER_REGISTRY=${OPTARG} ;;
    u) CONTAINER_REGISTRY_USERNAME=${OPTARG} ;;
    p) CONTAINER_REGISTRY_PASSWORD=${OPTARG} ;;
    r) DOCKER_CONTAINER_REGISTRY=${OPTARG} ;;
    s) DOCKER_CONTAINER_REGISTRY_USERNAME=${OPTARG} ;;
    v) DOCKER_CONTAINER_REGISTRY_PASSWORD=${OPTARG} ;;
  esac
done

HELM_CHART_NAME=dev-workspace

echo $DOCKER_CONTAINER_REGISTRY_PASSWORD | docker login ${DOCKER_CONTAINER_REGISTRY} \
  --username $DOCKER_CONTAINER_REGISTRY_USERNAME \
  --password-stdin

docker build -t push-helm-chart . --file Dockerfile.push-helm-chart

docker run \
  --env HELM_CHART_NAME=$HELM_CHART_NAME \
  --env CONTAINER_REGISTRY=$CONTAINER_REGISTRY \
  --env CONTAINER_REGISTRY_USERNAME=$CONTAINER_REGISTRY_USERNAME \
  --env CONTAINER_REGISTRY_PASSWORD=$CONTAINER_REGISTRY_PASSWORD \
  push-helm-chart \
