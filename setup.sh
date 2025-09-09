#!/bin/bash

# Define variables
GITHUB_USER="your_github_username"  # Replace with your GitHub username
CODESPACE_REPO="your_repository"    # Replace with your repository name
VNC_PASSWORD="your_vnc_password"    # Replace with your preferred VNC password

# Step 1: Update and upgrade system packages
echo "Updating and upgrading system packages..."
sudo apt update -y && sudo apt upgrade -y

# Step 2: Install commonly used packages
echo "Installing commonly used packages..."
sudo apt install -y \
    nano \
    xfce4 \
    tigervnc-standalone-server \
    tigervnc-viewer \
    neofetch \
    git \
    curl \
    build-essential \
    unzip \
    vim \
    htop \
    tree \
    zip \
    wget \
    software-properties-common \
    python3-pip \
    python3-dev \
    python3-venv \
    bash-completion \
    xauth

# Step 3: Check if SSH key already exists
SSH_KEY_PATH="$HOME/.ssh/id_rsa"

if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "SSH key not found. Generating a new SSH key..."
    # Generate a new SSH key
    ssh-keygen -t rsa -b 4096 -C "$GITHUB_USER@github.com" -f "$SSH_KEY_PATH" -N ""
    echo "SSH key generated at $SSH_KEY_PATH"
else
    echo "SSH key already exists at $SSH_KEY_PATH"
fi

# Step 4: Add SSH key to GitHub (You must have a GitHub token with `write:public_key` scope)
echo "Adding SSH key to GitHub..."
echo "Copy the public key from $HOME/.ssh/id_rsa.pub and add it to GitHub manually"
echo "Visit: https://github.com/settings/keys and click 'New SSH Key'"

# Step 5: Configure SSH to forward X11 (add to ssh config file)
SSH_CONFIG="$HOME/.ssh/config"
echo "Configuring SSH for X11 forwarding..."

if ! grep -q "ForwardX11" "$SSH_CONFIG"; then
    echo "Host codespaces.github.com" >> "$SSH_CONFIG"
    echo "    ForwardX11 yes" >> "$SSH_CONFIG"
    echo "    ForwardX11Trusted yes" >> "$SSH_CONFIG"
    echo "Added X11 forwarding to SSH config."
else
    echo "X11 forwarding already configured in SSH config."
fi

# Step 6: Install X11 dependencies for VNC server (and X server if not already installed)
echo "Installing X11 dependencies and VNC server..."
if ! dpkg -l | grep -q "xauth"; then
    sudo apt install -y xauth
fi

# Step 7: Configure VNC server
echo "Configuring VNC server..."

# Set the VNC password
echo "$VNC_PASSWORD" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start the VNC server with XFCE
echo "Starting VNC server for XFCE4..."
vncserver :1 -geometry 1280x1024 -depth 24

# Step 8: Install additional desktop environment and necessary tools
echo "Installing additional tools..."
sudo apt install -y \
    gnome-terminal \
    gnome-tweaks \
    firefox \
    xclip \
    ranger \
    terminator \
    tmux

# Step 9: Install Neofetch and display system information
echo "Displaying system information with Neofetch..."
neofetch

# Step 10: Update .devcontainer.json to expose VNC port (5901)
echo "Configuring GitHub Codespaces to expose VNC port..."
echo '{
  "name": "Your Codespace",
  "image": "mcr.microsoft.com/vscode/devcontainers/python:3.9",
  "portsAttributes": {
    "5901": {
      "label": "VNC Server on Port 5901",
      "onAutoForward": "openBrowser"
    }
  },
  "forwardPorts": [5901]
}' > .devcontainer/devcontainer.json

# Step 11: Final steps
echo "You can now SSH into your Codespace with X11 forwarding."
echo "To connect via SSH, use the following command (replace 'your_coded_url'):"
echo "ssh -X $GITHUB_USER@codespaces.github.com"

# Bonus: Provide the SSH command to clone repository (optional)
echo "If you want to clone your repository, use the following command:"
echo "git clone git@github.com:$GITHUB_USER/$CODESPACE_REPO.git"

# Step 12: Final instructions for connecting to VNC
echo "VNC server is running on port 5901."
echo "You can connect to the VNC server using a VNC client, connecting to 'localhost:5901'."
echo "Alternatively, you can open the VNC port in GitHub Codespaces through the Ports tab."
echo "Remember to use the password you set earlier when connecting to VNC."

echo "Setup completed!"