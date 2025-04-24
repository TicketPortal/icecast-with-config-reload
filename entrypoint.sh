#!/bin/bash

# Start Icecast in background
icecast2 -c /etc/icecast2/icecast.xml &
ICECAST_PID=$!

# Every 10 minutes, reload config
while true; do
    sleep 600  # 600 seconds = 10 minutes
    echo "Reloading Icecast config..."
    kill -HUP $ICECAST_PID
done