## Based on the antepenultiam stable debian
FROM debian:bullseye

## Update dependencies
RUN apt-get update -y && \
    apt-get install -y php php-mysqli wget curl
## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Create Working Directory
WORKDIR /var/www/html

## Download Adminer
RUN wget -O adminer.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php

## Launch Adminer
CMD ["php", "-S", "0.0.0.0:8080", "adminer.php"]

