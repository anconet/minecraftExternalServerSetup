#!/usr/bin/env bash
set -euo pipefail

# Add a user to the docker group so Docker can be used without sudo.
# This does not grant general sudo access.

TARGET_USER="${1:-${SUDO_USER:-${USER:-}}}"

if [[ -z "${TARGET_USER}" ]]; then
  echo "Usage: $0 [username]" >&2
  exit 1
fi

if ! getent group docker >/dev/null; then
  echo "Creating docker group..."
  sudo groupadd docker
fi

echo "Adding ${TARGET_USER} to the docker group..."
sudo usermod -aG docker "${TARGET_USER}"

echo "Done. Log out and back in, or run: newgrp docker"
