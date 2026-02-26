#!/bin/bash
set -euo pipefail

echo "updating system"
sudo apt update -y

sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install ansible -y

echo "successfully installed ansible"


