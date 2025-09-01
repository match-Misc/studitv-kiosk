#!/bin/bash

# Update package list
sudo apt update

# Install Chromium browser
sudo apt install -y chromium-browser

# Install unclutter to hide mouse cursor
sudo apt install -y unclutter

# Python3 not needed since we're using GitHub Pages

# Install xdotool for keyboard simulation if needed
sudo apt install -y xdotool

# Install lightdm if not already installed (for auto-login)
sudo apt install -y lightdm

echo "Installation complete. Please reboot the system."