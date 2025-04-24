FROM alpine:3.16

# Install build dependencies and runtime dependencies
RUN apk add --no-cache build-base libxslt-dev libvorbis-dev libogg-dev curl-dev openssl-dev \
    busybox-suid tzdata mailcap wget && \
    mkdir -p /etc/icecast /var/log/icecast /var/run/icecast /etc/periodic/15min && \
    addgroup -S icecast && adduser -S -D -H -g "" -G icecast icecast && \
    chown -R icecast:icecast /etc/icecast /var/log/icecast /var/run/icecast

# Build and install Icecast from source
RUN wget https://downloads.xiph.org/releases/icecast/icecast-2.4.4.tar.gz && \
    tar -xzf icecast-2.4.4.tar.gz && \
    cd icecast-2.4.4 && \
    ./configure --prefix=/usr --sysconfdir=/etc/icecast && \
    make && make install && \
    cd .. && rm -rf icecast-2.4.4 icecast-2.4.4.tar.gz

# Copy entrypoint script and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set working directory
WORKDIR /etc/icecast

# Expose ports
EXPOSE 8000 8443

# Create a cron job to reload Icecast configuration every 5 minutes
RUN echo "*/5 * * * * kill -HUP \$(pidof icecast)" > /etc/crontabs/root && \
    chmod 600 /etc/crontabs/root

# Switch to icecast user
USER icecast

# Set the default command
CMD ["/usr/local/bin/entrypoint.sh"]