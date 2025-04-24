```bash
docker run -d -p 8000:8000 spectado/icecast:latest
```

Or you can mount your own configuration file in the container:

```bash
docker run -d \
    -p 8000:8000 \
    -v ./icecast.xml:/etc/icecast.xml \
    spectado/icecast:latest
```
