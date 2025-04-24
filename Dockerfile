FROM alpine:latest

LABEL maintainer="Lada Soukup <your-email@example.com>"

# Install Icecast, cron, and necessary utils
RUN apk add --no-cache icecast busybox-suid tzdata mailcap

# Create necessary dirs
RUN mkdir -p /var/log/icecast /var/run/icecast /etc/periodic/15min

# Script to reload Icecast config using HUP
RUN echo '#!/bin/sh\n\
pid=$(pidof icecast)\n\
[ -n "$pid" ] && kill -HUP "$pid" || echo "Icecast not running"' \
  > /etc/periodic/15min/reload-icecast && chmod +x /etc/periodic/15min/reload-icecast

# Create non-root user
RUN addgroup -S icecast && adduser -S -G icecast icecast

# Make sure config, logs, and runtime dirs are owned by that user
RUN chown -R icecast:icecast /etc/icecast /var/log/icecast /var/run/icecast

# Switch to non-root user
USER icecast

# Expose ports
EXPOSE 8000 8443

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --spider -q http://localhost:8000/ || exit 1

# Entrypoint script to start both cron and Icecast
CMD sh -c "crond -f & icecast -c /etc/icecast.xml"