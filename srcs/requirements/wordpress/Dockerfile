## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install Wp
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-xml\
    curl \
    iputils-ping

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

## Define Workdirecty
WORKDIR /var/www/html

## Create PHP_FPM repository && add to group
RUN mkdir -p /run/php && \
    chown www-data:www-data /run/php

## COPY PHP Configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

## Copy setup script, add persmissions and add group
COPY ./tools/wordpress_setup.sh /setup/wordpress_setup.sh
RUN chmod +x /setup/wordpress_setup.sh && \
    chown -R root:root /var/www/html

## Use script as entrypoint
ENTRYPOINT ["/setup/wordpress_setup.sh"]