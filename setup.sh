#!/bin/bash

# Color codes
GREEN="\e[32m"
RESET="\e[0m"

# Function for system update and basic setup
system_setup() {
    echo -e "${GREEN}Updating and upgrading system packages...${RESET}"
    sudo apt update -y
    sudo apt upgrade -y

    echo -e "${GREEN}Installing commonly used packages...${RESET}"
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
        netcat \
        tcpdump \
        screen
}

# Run the setup
system_setup

# Final update and upgrade for good measure
sudo apt update -y && sudo apt upgrade -y

echo -e "${GREEN}Setup complete!${RESET}"