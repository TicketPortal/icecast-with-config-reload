#!/bin/sh

# Start the cron daemon in the background
crond -b -l 2

# Start Icecast
exec icecast -c /etc/icecast.xml