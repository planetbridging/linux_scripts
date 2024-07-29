#!/bin/bash

# Function to print messages
print_message() {
 echo "========================================"
 echo "$1"
 echo "========================================"
}

# Update and upgrade system
print_message "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# Install dependencies
print_message "Installing required dependencies..."
sudo apt install -y curl git

# Install SVM
print_message "Installing SVM..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.38.0/install.sh | bash

# Load SVM into the current shell session
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest Node.js using SVM
print_message "Installing the latest version of Node.js and npm..."
nvm install node

# Set the default Node.js version
print_message "Setting the default Node.js version..."
nvm alias default node

# Verify installation
print_message "Verifying Node.js and npm installation..."
node -v
npm -v

print_message "Node.js and npm have been successfully installed and configured using SVM!"
