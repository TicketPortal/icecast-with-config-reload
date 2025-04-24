FROM libretime/icecast

# Install curl and cron
RUN apt-get update && \
    apt-get install -y curl cron && \
    apt-get clean

# Add our crontab file
COPY reload-cron /etc/cron.d/reload-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/reload-cron

# Apply cron job
RUN crontab /etc/cron.d/reload-cron

# Create script to reload Icecast config
COPY reload-icecast.sh /usr/local/bin/reload-icecast.sh
RUN chmod +x /usr/local/bin/reload-icecast.sh

# Start both cron and icecast
CMD cron && /entrypoint.sh