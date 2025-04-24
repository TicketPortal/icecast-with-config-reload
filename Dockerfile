FROM alpine:3.16

# Install necessary packages and create directories
RUN apk add --no-cache icecast busybox-suid tzdata mailcap wget && \
    mkdir -p /etc/icecast /var/log/icecast /var/run/icecast /etc/periodic/15min && \
    addgroup -S icecast && adduser -S -D -H -g "" -G icecast icecast && \
    chown -R icecast:icecast /etc/icecast /var/log/icecast /var/run/icecast

# Copy entrypoint script and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set working directory
WORKDIR /etc/icecast

# Expose ports
EXPOSE 8000 8443

# Healthcheck to ensure Icecast is running
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget --spider -q http://localhost:8000/ || exit 1

# Switch to icecast user
USER icecast

# Set the default command
CMD ["/usr/local/bin/entrypoint.sh"]