#!/bin/bash

# This script installs the HiWiTV Kiosk.

if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo." >&2
  exit 1
fi

SCRIPT_DIR="$(dirname "$0")"

# Install unclutter for hiding mouse cursor
apt update
apt install -y unclutter

# Make scripts executable
chmod +x "${SCRIPT_DIR}/setup/kiosk_watchdog.sh"
chmod +x "${SCRIPT_DIR}/setup/setup_services.sh"
chmod +x "${SCRIPT_DIR}/setup/setup_cron.sh"
chmod +x "${SCRIPT_DIR}/setup/kiosk_launcher.sh"

# Run setup scripts
"${SCRIPT_DIR}/setup/setup_services.sh"
if [ $? -ne 0 ]; then
    echo "Error: Service setup failed." >&2
    exit 1
fi

"${SCRIPT_DIR}/setup/setup_cron.sh"
if [ $? -ne 0 ]; then
    echo "Error: Cron setup failed." >&2
    exit 1
fi

echo "
Installation complete."
read -p "Reboot now? (y/n): " choice
case "$choice" in 
  y|Y ) sudo reboot;;
  n|N ) echo "Please reboot manually later.";;
  * ) echo "Invalid choice. Please reboot manually.";;
esac
