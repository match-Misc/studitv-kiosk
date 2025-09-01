#!/bin/bash

# Copy service file to systemd
sudo cp kiosk.service /etc/systemd/system/

# Reload systemd daemon
sudo systemctl daemon-reload

# Enable the service
sudo systemctl enable kiosk.service

# Configure auto-login for user pi
sudo raspi-config nonint do_boot_behaviour B4  # Auto login to desktop

# Disable screen blanking
sudo sed -i 's/#xserver-command=X/xserver-command=X -s 0 -dpms/' /etc/lightdm/lightdm.conf

echo "Service setup complete. Reboot to start kiosk mode."