#!/bin/bash

# This script sets up a cron job to run the kiosk watchdog.

WATCHDOG_SCRIPT="/home/pi/hiwitv-kiosk/setup/kiosk_watchdog.sh"
CRON_JOB="* * * * * ${WATCHDOG_SCRIPT}"

# Add the cron job for the 'pi' user
sudo -u pi crontab -l | { cat; echo "$CRON_JOB"; } | sudo -u pi crontab -

echo "Cron job for kiosk watchdog has been set up for user pi."