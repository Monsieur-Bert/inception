## Based on the antepenultiam stable debian
FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl gettext

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Suppress nginx default configuration
RUN rm -f /etc/nginx/sites-enabled/default

## Copy nginx configuration
COPY /conf/default.conf /etc/nginx/sites-available/default.conf

## Copy script and add permissions
COPY tools/nginx_setup.sh /nginx_setup.sh
RUN chmod +x /nginx_setup.sh

## Set script as entrypoint
ENTRYPOINT ["/nginx_setup.sh"]