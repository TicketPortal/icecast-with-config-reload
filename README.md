```bash
docker run -d -p 8000:8000 ghcr.io/ticketportal/icecast:latest
```

Or you can mount your own configuration file in the container:

```bash
docker run -d \
    -p 8000:8000 \
    -v ./icecast.xml:/etc/icecast.xml \
    ghcr.io/ticketportal/icecast:latest
```

```yaml
services:
  icecast-master:
    image: ghcr.io/ticketportal/icecast:latest
    ports:
      - "8000:8000"
    volumes:
      - /opt/docker/icecast/icecast.xml:/etc/icecast.xml
      - /opt/docker/icecast-files/:/etc/icecast2
```
