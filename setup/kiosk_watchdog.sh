#!/bin/bash

# This script checks if the kiosk browser is active and starts it if it's not.
# It's designed to be run from cron.

# THE KEY PART: We export the DBUS address for systemctl --user to work.
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# The name of the service we are monitoring.
SERVICE_NAME="hiwitv-kiosk-browser.service"

# Check if the service is NOT active.
if ! systemctl --user is-active --quiet "$SERVICE_NAME"; then
    # If it's not active, log the action and try to start it.
    echo "$(date): Service was inactive. Attempting to start..." >> /tmp/hiwitv_kiosk_watchdog.log
    systemctl --user start "$SERVICE_NAME"
fi
