#!/bin/bash

LOG_FILE="/home/match/studitv-kiosk/kiosk.log"

echo "$(date): Kiosk launch script started" >> $LOG_FILE
echo "$(date): Current user: $(whoami)" >> $LOG_FILE
echo "$(date): Current working directory: $(pwd)" >> $LOG_FILE
echo "$(date): DISPLAY: $DISPLAY" >> $LOG_FILE

# Check if working directory exists
if [ ! -d "/home/match/studitv-kiosk" ]; then
  echo "$(date): ERROR - Working directory /home/match/studitv-kiosk does not exist" >> $LOG_FILE
else
  echo "$(date): Working directory exists" >> $LOG_FILE
fi

# GitHub Pages URL for the kiosk
KIOSK_URL="https://match-misc.github.io/studitv-kiosk/"

# Check URL accessibility
if curl -s --head "$KIOSK_URL" | head -n 1 | grep -q "200"; then
  echo "$(date): URL $KIOSK_URL is accessible" >> $LOG_FILE
else
  echo "$(date): ERROR - URL $KIOSK_URL is not accessible" >> $LOG_FILE
fi

# Start unclutter to hide mouse cursor
echo "$(date): Starting unclutter" >> $LOG_FILE
unclutter -idle 0.1 -root &
UNCLUTTER_PID=$!
sleep 1
if ps -p $UNCLUTTER_PID > /dev/null; then
  echo "$(date): Unclutter started successfully (PID: $UNCLUTTER_PID)" >> $LOG_FILE
else
  echo "$(date): ERROR - Unclutter failed to start" >> $LOG_FILE
fi

# Launch Chromium in kiosk mode pointing to GitHub Pages
echo "$(date): Launching Chromium with URL: $KIOSK_URL" >> $LOG_FILE
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
  --app="$KIOSK_URL" 2>> $LOG_FILE
CHROMIUM_EXIT_CODE=$?

echo "$(date): Chromium launch command executed with exit code: $CHROMIUM_EXIT_CODE" >> $LOG_FILE
if [ $CHROMIUM_EXIT_CODE -ne 0 ]; then
  echo "$(date): ERROR - Chromium failed to launch" >> $LOG_FILE
fi