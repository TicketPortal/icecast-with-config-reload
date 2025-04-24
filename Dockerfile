FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y icecast2 media-types && \
    id -u icecast &>/dev/null || useradd -r -s /usr/sbin/nologin icecast && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/icecast2 /var/run/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2 /var/run/icecast2 /etc/icecast2 || true

COPY icecast.xml /etc/icecast2/icecast.xml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER icecast

EXPOSE 8000 8001
CMD ["/usr/local/bin/entrypoint.sh"]