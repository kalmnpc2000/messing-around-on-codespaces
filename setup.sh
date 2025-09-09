#!/bin/bash

# Define variables
GITHUB_USER="your_github_username"  # Replace with your GitHub username
CODESPACE_REPO="your_repository"    # Replace with your repository name

# Step 1: Update and upgrade system packages
echo "Updating and upgrading system packages..."
sudo apt update -y

# Step 2: Install commonly used packages
echo "Installing commonly used packages..."
sudo apt install -y \
    nano \
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
    bash-completion

# Step 3: Install additional tools
echo "Installing additional tools..."
sudo apt install -y \
    gnome-terminal \
    xfce4 \
    firefox \
    xclip \
    ranger \
    terminator \
    tmux
sudo apt upgrade -y
# Step 4: Display system information with Neofetch
echo "Displaying system information with Neofetch..."
neofetch

# Step 5: Configure GitHub Codespaces
echo "Configuring GitHub Codespaces..."

# Step 6: Final steps
echo "You can now use your Codespace."
echo "If you want to clone your repository, use the following command:"
echo "git clone https://github.com/$GITHUB_USER/$CODESPACE_REPO.git"

echo "Setup completed!"