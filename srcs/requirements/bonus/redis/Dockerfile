## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install Redis Cache
RUN apt-get update -y && \
    apt-get install -y redis-server

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Copy Redis configuration
COPY conf/redis.conf /etc/redis/redis.conf

## Create repository for Redis Datas
RUN mkdir -p /var/lib/redis && \
    chown redis:redis /var/lib/redis

## Use script as entrypoint
CMD ["redis-server", "/etc/redis/redis.conf", "--daemonize", "no"]

