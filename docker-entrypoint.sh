#!/bin/sh

set -e

ICECAST_PID_FILE=/var/run/icecast.pid

# Start cron
crond -L /var/log/cron.log

# Setup crontab (overwrite every start)
echo "*/10 * * * * kill -HUP \$(cat $ICECAST_PID_FILE)" | crontab -

# Start Icecast in background
icecast "$@" &
ICECAST_PID=$!
echo $ICECAST_PID > $ICECAST_PID_FILE

# Wait for Icecast to exit
wait $ICECAST_PID