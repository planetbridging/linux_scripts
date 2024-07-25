#!/bin/bash

# Create a daemon.json file to configure Docker log rotation
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "500m",
    "max-file": "8"
  }
}
EOF

# Restart Docker to apply the configuration
sudo systemctl restart docker

echo "Docker log rotation configuration applied to limit log size to 4GB."
