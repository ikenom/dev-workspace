FROM alpine:3.12

RUN apk add docker

ENV APP_HOME /scripts
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY scripts .
