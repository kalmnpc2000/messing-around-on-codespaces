#!/bin/bash

# Install necessary dependencies
echo "Installing necessary packages..."
sudo apt update -y && sudo apt upgrade -y

# Install VNC and XFCE
echo "Installing VNC Server and XFCE..."
sudo apt install -y xfce4 xfce4-goodies tightvncserver

# Install dependencies for Remote Manager (for VNC use)
echo "Installing VS Code extensions and setting up Remote Manager..."
code --install-extension mavenshu.remote-manager

# Setup TightVNC Server (or use other VNC servers)
echo "Setting up TightVNC server..."
vncserver :1 -geometry 1280x1024 -depth 24

# Configure the VNC password
echo "Setting up password for VNC..."
vncpasswd

# Set up XFCE for use with VNC
echo "Configuring XFCE session..."
echo "xfce4-session" > ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

# Restart the VNC server
echo "Restarting VNC Server..."
vncserver -kill :1
vncserver :1

# Provide feedback on the server's status
echo "VNC Server is running. You can now connect to it using your VNC client."
echo "Server details:"
echo "VNC Server: localhost:1"
echo "Password: Set during configuration"

# Final message
echo "Remote Manager setup is complete. You should now be able to connect via VNC, SSH, or RDP using the VS Code Remote Manager extension."

# Optional: Start Remote Manager after setup
echo "Starting Remote Manager in VS Code..."
code --command "RemoteManager.openConnectionsPanel"
