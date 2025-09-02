#!/bin/bash

# Start unclutter to hide mouse cursor
unclutter -idle 0 -root &

# Start Chromium in kiosk mode
/usr/bin/chromium-browser --kiosk --noerrdialogs --disable-infobars --ignore-certificate-errors --no-sandbox --disable-gpu --disable-dev-shm-usage --incognito https://match-misc.github.io/studitv-kiosk/