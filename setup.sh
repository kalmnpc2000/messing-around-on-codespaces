#!/bin/bash

# Define variables
GITHUB_USER="your_github_username"  # Replace with your GitHub username
CODESPACE_REPO="your_repository"    # Replace with your repository name

# Function to display the main menu
display_main_menu() {
    clear
    echo "----------------------------------------"
    echo "  Welcome to the Codespace Setup Menu   "
    echo "----------------------------------------"
    echo "1. System Setup (Update & Install Basics)"
    echo "2. Developer Tools Setup (Neovim, Git, etc.)"
    echo "3. SSH Setup"
    echo "4. YouTube Downloader (yt-dlp)"
    echo "5. Exit"
    echo -n "Please select an option [1-5]: "
    read -r choice
    case $choice in
        1) system_setup ;;
        2) developer_tools ;;
        3) ssh_setup ;;
        4) youtube_downloader ;;
        5) exit 0 ;;
        *) echo "Invalid option. Please try again."; sleep 2; display_main_menu ;;
    esac
}

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

    echo "Basic system setup completed!"
    read -p "Press any key to return to the main menu..." -n1 -s
    display_main_menu
}

# Function for installing developer tools
developer_tools() {
    echo "Installing developer tools..."
    sudo apt install -y \
        neovim \
        tmux \
        ranger \
        xclip

    echo "Developer tools installation completed!"
    read -p "Press any key to return to the main menu..." -n1 -s
    display_main_menu
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
    read -p "Press any key to return to the main menu..." -n1 -s
    display_main_menu
}

# Function for installing yt-dlp (YouTube downloader)
youtube_downloader() {
    echo "Installing yt-dlp..."
    sudo apt install yt-dlp -y

    echo "yt-dlp installation completed!"
    read -p "Press any key to return to the main menu..." -n1 -s
    display_main_menu
}
#Final update for every package
sudo apt update -y && sudo apt upgrade -y
# Start the script by displaying the menu
display_main_menu
