#!/bin/bash
set -x
docker buildx prune -a -f
docker image prune -a -f
