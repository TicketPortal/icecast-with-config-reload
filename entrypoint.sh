#!/bin/sh

# Start cron with logging
touch /var/log/cron.log
crond -b -l 2 -L /var/log/cron.log

# Tail logs for visibility & Start icecast
tail -f /var/log/cron.log & exec icecast -c /etc/icecast.xml