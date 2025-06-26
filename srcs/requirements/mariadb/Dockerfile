## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install MariaDB
RUN apt-get update && apt-get upgrade -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

## Copy configuration script, add permissions
COPY tools/mariadb_setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb_setup.sh

## Copy perso configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

## Create repository for datas
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

## Expose port
EXPOSE 3306

## Use script as entrypoint
ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]