## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install Pyhton3 (http server)
RUN apt-get update -y && \
    apt-get install -y python3

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Copy static files
COPY ./html /var/www/html

## Set the server directory
WORKDIR /var/www/html

## Launch Apache in foreground
CMD ["python3", "-m", "http.server", "81"]
