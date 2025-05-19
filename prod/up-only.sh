#!/bin/bash
set -x
ENV_FILE_PARAMS=""
if [ -f ../environment/env.compose ]; then
  ENV_FILE_PARAMS="--env-file ../environment/env.compose"
fi
docker compose $ENV_FILE_PARAMS -f docker-compose.yaml up -d $@
