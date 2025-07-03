## Based on the antepenultiam stable debian
FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    gettext \
    iputils-ping \

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Copy nginx configuration
COPY /conf/default.conf /etc/nginx/sites-available/default.conf

## Copy script and add permissions
COPY tools/nginx_setup.sh /nginx_setup.sh
RUN chmod +x /nginx_setup.sh

# ## Create repository for nginx logs
# RUN mkdir -p /var/log/nginx /etc/nginx/ssl

## Suppress nginx default configuration
RUN rm -f /etc/nginx/sites-enabled/default

## Set script as entrypoint
ENTRYPOINT ["/nginx_setup.sh"]