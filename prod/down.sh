#!/bin/bash
set -x
docker compose -f docker-compose.yaml down $@
