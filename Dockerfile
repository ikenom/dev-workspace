FROM dtzar/helm-kubectl

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY . .

ENV HELM_EXPERIMENTAL_OCI 1
COPY scripts/deploy-helm-entrypoint.sh ${APP_HOME}/k8
WORKDIR ${APP_HOME}/k8

ENTRYPOINT ["bash", "deploy-helm-entrypoint.sh"]
