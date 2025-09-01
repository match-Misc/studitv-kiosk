#!/bin/bash

# GitHub Pages URL for the kiosk
KIOSK_URL="https://match-misc.github.io/studitv-kiosk/"

# Start unclutter to hide mouse cursor
unclutter -idle 0.1 -root &

# Launch Chromium in kiosk mode pointing to GitHub Pages
chromium-browser \
  --kiosk \
  --noerrdialogs \
  --disable-infobars \
  --disable-session-crashed-bubble \
  --disable-component-extensions-with-background-pages \
  --disable-background-timer-throttling \
  --disable-backgrounding-occluded-windows \
  --disable-renderer-backgrounding \
  --user-agent="Mozilla/5.0 (X11; Linux armv7l) AppleWebKit/537.36 (KHTML, like Gecko) Raspbian Chromium/78.0.3904.108 Chrome/78.0.3904.108 Safari/537.36" \
  --app="$KIOSK_URL"