FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Icecast and media-types (replaces mime-support)
RUN apt-get update && \
    apt-get install -y icecast2 media-types && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# These directories might not exist before the package runs the daemon, so we create them manually
# This must come *after* installation so user `icecast` is available
RUN mkdir -p /var/log/icecast2 /var/run/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2 /var/run/icecast2 /etc/icecast2

# Add your config and entrypoint
COPY icecast.xml /etc/icecast2/icecast.xml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER icecast

EXPOSE 8000 8001 8443
CMD ["/usr/local/bin/entrypoint.sh"]