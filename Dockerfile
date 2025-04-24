FROM ubuntu:24.04

LABEL maintainer="ladislav.soukup@ticketportal.cz"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y icecast2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy custom configuration if needed
# COPY icecast.xml /etc/icecast2/icecast.xml

# Expose Icecast ports
EXPOSE 8000 8001

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]