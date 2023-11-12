#!/usr/bin/env bash

# This scripts assumes Ubuntu-22.04 (with systemd)

echo "***************************************************"
echo "Installing VS Code"
echo "***************************************************"

set -uxo pipefail

# Install VS code [https://linuxiac.com/install-visual-studio-code-on-ubuntu-22-04/]
sudo apt install -y software-properties-common apt-transport-https wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
rm packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code

# Extension for DevContainers
# https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-containers

# Also for Docker (mostly to avoid annoying prompt during startup)
# https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
code --install-extension ms-azuretools.vscode-docker

# Customize some settings to non-default values
SETTINGS_DIR=${HOME}/.config/Code/User
[ -d "$SETTINGS_DIR" ] || mkdir -p $SETTINGS_DIR

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cp $SCRIPT_DIR/vscode-settings.json $SETTINGS_DIR/settings.json
