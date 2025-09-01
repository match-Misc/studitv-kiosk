#!/bin/bash

# Define source and destination paths
SERVICE_FILE_USER="hiwitv-kiosk-browser.service"
SRC_DIR="$(dirname "$0")"
DEST_DIR_USER="/home/pi/.config/systemd/user"

# --- Install user service file ---
echo "Installing ${SERVICE_FILE_USER}..."

if [ ! -d "${DEST_DIR_USER}" ]; then
    echo "Directory ${DEST_DIR_USER} does not exist. Creating it..."
    sudo -u pi mkdir -p "${DEST_DIR_USER}"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create directory ${DEST_DIR_USER}." >&2
        exit 1
    fi
fi

sudo -u pi cp "${SRC_DIR}/${SERVICE_FILE_USER}" "${DEST_DIR_USER}/${SERVICE_FILE_USER}"
if [ $? -ne 0 ]; then
    echo "Error: Failed to copy ${SERVICE_FILE_USER}." >&2
    exit 1
fi


# --- Enable service ---
echo "Enabling service..."

# Enable the user service for the 'pi' user
sudo -u pi XDG_RUNTIME_DIR=/run/user/1000 systemctl --user enable "${SERVICE_FILE_USER}"
if [ $? -ne 0 ]; then
    echo "Error: Failed to enable ${SERVICE_FILE_USER}." >&2
    exit 1
fi

echo "Service installed and enabled."
