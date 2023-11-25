#!/usr/bin/env bash

# Pre-build example images, incl. the floskl repository's PostgreSQL install

set -eu # 👉 https://explainshell.com/explain?cmd=set+-eux

printf "\n▶️  Pre-build app example images...\n"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_ROOT="${SCRIPT_DIR}/.."
pushd "${REPO_ROOT}/app-examples"

pushd cpp
docker build -t temp:temp .
docker image rm --no-prune temp:temp
popd

pushd python
docker build -t temp:temp .
docker image rm --no-prune temp:temp

pushd "${REPO_ROOT}/repos/floskl/dev-db"
docker-compose pull

