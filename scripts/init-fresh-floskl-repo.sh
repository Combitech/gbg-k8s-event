#!/usr/bin/env bash

# Clone the "floskl" repo.
# If there already is a clone, remove that version first.

set -eu # 👉 https://explainshell.com/explain?cmd=set+-eux

REPO_DIR=./repos/floskl

printf "\n▶️  Prepare fresh ${REPO_DIR} repository...\n"

[ -d "${REPO_DIR}" ] && rm -rf ${REPO_DIR}

git clone https://github.com/uivraeus/floskl $REPO_DIR

# Invoke reset script to cover environment preparation
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
${SCRIPT_DIR}/reset-floskl-repo.sh
