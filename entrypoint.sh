#!/bin/sh

# Use a log file Icecast user can write to
LOGFILE=/var/log/icecast/cron.log
touch "$LOGFILE"

# Start cron with logging
crond -b -l 2 -L "$LOGFILE"

# Tail cron log and start Icecast
tail -f "$LOGFILE" & exec icecast -c /etc/icecast/icecast.xml