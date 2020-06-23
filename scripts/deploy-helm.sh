docker build \
  --build-arg CONTAINER_REGISTRY=ikenom.azurecr.io \
  --build-arg CONTAINER_REGISTRY_USERNAME=ikenom \
  --build-arg CONTAINER_REGISTRY_PASSWORD=JVBGYF5K6j8LA0oxGj1L9Ndw78/J4iH2 \
  -t deploy-helm \
  .
docker run deploy-helm