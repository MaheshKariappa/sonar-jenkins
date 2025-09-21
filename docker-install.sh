#!/bin/bash

set -e

echo "🚀 Starting Docker installation..."

# Update package index
echo "📦 Updating packages..."
sudo apt update && sudo apt upgrade -y

# Install prerequisites
echo "🔧 Installing prerequisite packages..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
echo "🔑 Adding Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "📝 Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update again
echo "🔄 Updating package list (with Docker repo)..."
sudo apt update

# Install Docker
echo "🐳 Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Post-installation steps
echo "👤 Adding current user (${USER}) to 'docker' group..."
sudo usermod -aG docker $USER

echo "✅ Docker installation complete!"

echo "📌 You may need to log out and back in, or run 'newgrp docker' to use Docker without sudo."

# Test Docker
echo "🧪 Testing Docker with hello-world image..."
docker run hello-world || echo "⚠️ You may need to re-login or run with sudo for the first time."

