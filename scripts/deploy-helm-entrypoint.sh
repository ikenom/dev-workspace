echo $CONTAINER_REGISTRY_PASSWORD | helm registry login ${CONTAINER_REGISTRY} \
  --username $CONTAINER_REGISTRY_USERNAME \
  --password-stdin
helm chart save dev-workspace ${CONTAINER_REGISTRY}/dev-workspace:latest
helm chart push ${CONTAINER_REGISTRY}/dev-workspace:latest
