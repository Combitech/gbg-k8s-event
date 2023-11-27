#!/usr/bin/env bash

# Reset and prepare environment for the floskl repo

set -eu # 👉 https://explainshell.com/explain?cmd=set+-eux

REPO_DIR=./repos/floskl

[ -d "${REPO_DIR}" ] || (echo "Repository ${REPO_DIR} doesn't exist" && exit 1)

pushd ${REPO_DIR}

printf "\n▶️  Reset and clean the ${REPO_DIR} repository...\n"
git reset --hard
git clean -xdf
git checkout main
git pull

printf "\n▶️  Remove old database instance (if any)...\n"
./stop-dev-db.sh --delete

printf "\n▶️  Prepare Python virtual environment...\n"
./prep-venv.sh
