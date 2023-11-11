#!/usr/bin/env bash

# Clone the "floskl" repo.
# If there already is a clone, remove that version first.

set -eu # 👉 https://explainshell.com/explain?cmd=set+-eux

REPO_DIR=./repos/floskl

[ -d "${REPO_DIR}" ] && rm -rf ${REPO_DIR}

git clone https://github.com/uivraeus/floskl $REPO_DIR
