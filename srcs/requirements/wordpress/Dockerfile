## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install Wp
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml\
    php7.4-zip \
    curl \
	mariadb-client \
	netcat

## Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

## Create PHP_FPM repository
RUN mkdir -p /run/php && chown www-data:www-data /run/php

## COPY PHP Configuration
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

## Define Workdirecty
WORKDIR /var/www/html

RUN chown -R root:root /var/www/html

## Copy setup script
COPY ./tools/wordpress_setup.sh .
RUN chmod +x wordpress_setup.sh

## Expose port
EXPOSE 9000

## Use script as entrypoint
ENTRYPOINT ["/var/www/html/wordpress_setup.sh"]