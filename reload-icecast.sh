#!/bin/bash

ICECAST_PID=$(pgrep icecast2)

if [ -n "$ICECAST_PID" ]; then
  echo "Reloading Icecast config (PID: $ICECAST_PID)"
  kill -HUP "$ICECAST_PID"
else
  echo "Icecast process not found"
fi