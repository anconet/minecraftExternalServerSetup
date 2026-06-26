#!/usr/bin/env bash
set -euo pipefail

# Uninstall old versions of Docker that came with the distro
OLD_PKGS=(
  docker.io
  docker-doc
  docker-compose
  docker-compose-v2
  podman-docker
  containerd
  runc
)

echo "Removing old Docker packages..."
for pkg in "${OLD_PKGS[@]}"; do
    sudo apt-get remove -y "$pkg" || true
done

# Add Docker's official GPG key
echo "Adding Docker GPG key..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# Test the install
echo "Testing Docker installation..."
sudo docker run --rm hello-world

echo "Docker installation complete."

