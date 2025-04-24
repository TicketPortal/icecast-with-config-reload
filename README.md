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
    deploy:
      mode: replicated
      replicas: 1
      placement:
        constraints: [node.role == worker]
    restart: always
    ports:
      - "8000:8000"
    volumes:
      - /opt/docker/icecast-master/icecast.xml:/etc/icecast.xml
      - /opt/docker/icecast-master/:/etc/icecast2
```
