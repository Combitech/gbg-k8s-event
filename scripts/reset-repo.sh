#!/usr/bin/env bash

# Reset and prepare environment entire environment, incl. the floskl repository

set -eu # 👉 https://explainshell.com/explain?cmd=set+-eux

printf "\n▶️  Reset and clean the current repository...\n"
git reset --hard
git clean -xdf
git co main
git pull

# Invoke floskl-specific reset
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
${SCRIPT_DIR}/reset-floskl-repo.sh
