#!/bin/bash
set -x
if [ ! -e "../ssl" ]; then
  mkdir ../ssl
fi
ENV_FILE_PARAMS=""
if [ -f ../environment/env.compose ]; then
  ENV_FILE_PARAMS="--env-file ../environment/env.compose"
fi
touch ../ssl/ssl.pem
touch ../ssl/ssl.key
docker pull ghcr.io/scse-tools/coverage-analyzer-ng-server:latest \
&& docker pull ghcr.io/scse-tools/coverage-analyzer-ng-nginx:latest \
&& docker compose $ENV_FILE_PARAMS -f docker-compose.yaml up -d $@
