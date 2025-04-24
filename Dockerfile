FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y icecast2 media-types
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/icecast2 /var/run/icecast2

COPY icecast.xml /etc/icecast2/icecast.xml
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8000 8001
CMD ["/usr/local/bin/entrypoint.sh"]