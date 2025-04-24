#!/bin/sh

# Create a cron job to reload Icecast configuration every 5 minutes
echo "*/5 * * * * kill -HUP \$(pidof icecast)" > /etc/crontabs/root

# Start the cron daemon in the background
crond -b -l 2

# Start Icecast
exec icecast -c /etc/icecast.xml