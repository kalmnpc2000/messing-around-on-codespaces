#!/bin/bash
# Define variables
GITHUB_USER="your_github_username"  # Replace with your GitHub username
CODESPACE_REPO="your_repository"    # Replace with your repository name
# Function for system update and basic setup
system_setup() {
    echo "Updating and upgrading system packages..."
    sudo apt update -y
    sudo apt upgrade -y
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
}
# Function for installing developer tools
developer_tools() {
    echo "Installing developer tools..."
    sudo apt install -y \
        neovim \
        tmux \
        ranger \
        xclip
}
# Function for SSH setup
ssh_setup() {
    echo "Checking if SSH keys are set up for GitHub..."
    if [ ! -f "$HOME/.ssh/id_rsa" ]; then
        echo "No SSH key found. Generating SSH key..."
        ssh-keygen -t rsa -b 4096 -C "$GITHUB_USER@github.com" -f "$HOME/.ssh/id_rsa" -N ""
        echo "SSH key generated. Add the following SSH key to GitHub:"
        cat "$HOME/.ssh/id_rsa.pub"
    else
        echo "SSH key already exists."
    fi
    echo "SSH setup completed!"
}
# Function for installing yt-dlp (YouTube downloader)
youtube_downloader() {
    echo "Installing yt-dlp..."
    sudo apt install yt-dlp -y
    echo "yt-dlp installation completed!"
}
#Final update for every package
sudo apt update -y && sudo apt upgrade -y