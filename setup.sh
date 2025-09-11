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

# DELETE TEXT BELOW THIS IF IT FAILS
set -e

echo "Starting setup for noVNC in GitHub Codespace..."

# Update and upgrade packages
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# Install necessary dependencies
echo "Installing dependencies..."
sudo apt install -y \
    git \
    npm \
    python3 \
    python3-pip

# Check if noVNC directory exists, if not, clone the repository
if [ ! -d "noVNC" ]; then
    echo "Cloning noVNC repository..."
    git clone https://github.com/novnc/noVNC.git
else
    echo "noVNC directory already exists. Skipping cloning."
fi

cd noVNC

# Install websockify
echo "Cloning websockify repository..."
if [ ! -d "websockify" ]; then
    git clone https://github.com/novnc/websockify.git
fi

cd websockify
python3 setup.py install
cd ..

# Start noVNC with websockify
echo "Starting noVNC with websockify..."
./utils/novnc_proxy --vnc localhost:5901 &

# Install http-server globally
echo "Installing http-server..."
npm install -g http-server

# Update npm to the latest version
echo "Updating npm to the latest version..."
npm install -g npm

# Initialize a new npm project
echo "Initializing npm project..."
npm init -y

# Install express
echo "Installing express..."
npm install express

# Create index.js file
echo "Creating index.js file..."
cat <<EOL > index.js
const express = require("express");
const path = require("path");
const app = express();
const PORT = 8000; // http://localhost:8000/

// Serve the noVNC static files
app.use(express.static(path.join(__dirname, 'noVNC')));

// Redirect to noVNC's HTML page
app.get("/", (request, response) => {
    response.sendFile(path.join(__dirname, 'noVNC', 'vnc.html'));
});

app.listen(PORT, () => {
    console.log(\`Express server is serving noVNC at http://localhost:\${PORT}/\`);
});
EOL

# Add "dev" script to package.json
echo "Adding 'dev' script to package.json..."
jq '.scripts.dev="node index.js"' package.json > tmp.json && mv tmp.json package.json

# Start express server (running npm run dev)
echo "Starting the Express server with 'npm run dev'..."
npm run dev &

# Start the noVNC web interface
echo "Serving noVNC interface on http://localhost:8080..."
http-server . -p 8080 &

# Expose the necessary ports for GitHub Codespaces (assuming it's port 8080)
echo "The noVNC web server is running on port 8080."
echo "You need to manually expose port 8080 via the GitHub Codespaces Ports tab."
echo "To do this, go to the Ports tab, find the port 8080, and click 'Expose'."

# Automatically open the noVNC URL in the default web browser (for local environments)
if command -v xdg-open &> /dev/null; then
    echo "Opening noVNC in your default web browser..."
    xdg-open "http://localhost:8080" & # This may not work on GitHub Codespaces, but it will work locally.
else
    echo "xdg-open command not found. You may need to manually open the URL."
fi

echo "Setup complete. You can access noVNC at http://localhost:8080"
