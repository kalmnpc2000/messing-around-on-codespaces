#!/bin/bash
# Function for system update and basic setup
system_setup() {
    echo "Updating and upgrading system packages"
    sudo apt update -y
    sudo apt upgrade -y

    echo "Installing commonly used CLI packages"
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
        bash-completion \
        yt-dlp \
        neovim \
        tmux \
        ranger \
        xclip \
        # Kali Linux CLI tools for security testing and web analysis
        nikto \
        sqlmap \
        hydra \
        nmap \
        metasploit-framework \
        dirb \
        john \
        wfuzz \
        dnsutils \
        net-tools \
        proxychains4 \
        gobuster \
        aircrack-ng \
        # Additional useful CLI tools
        netcat \
        tcpdump \
        screen
}

# Run the setup function
system_setup

# Final update and upgrade for every package
sudo apt update -y && sudo apt upgrade -y