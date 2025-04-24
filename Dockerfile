FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Add multiverse to get icecast2 (in some Ubuntu setups it's not in main)
RUN sed -i 's/^# \(deb .*universe\)$/\1/' /etc/apt/sources.list && \
    sed -i 's/^# \(deb .*multiverse\)$/\1/' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository universe && \
    apt-add-repository multiverse && \
    apt-get update && \
    apt-get install -y icecast2 mime-support && \
    useradd -r -s /usr/sbin/nologin icecast && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/icecast2 /var/run/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2 /var/run/icecast2 /etc/icecast2

COPY icecast.xml /etc/icecast2/icecast.xml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER icecast

EXPOSE 8000 8001
CMD ["/usr/local/bin/entrypoint.sh"]