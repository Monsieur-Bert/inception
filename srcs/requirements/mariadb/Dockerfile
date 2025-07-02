## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install MariaDB
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server

## Copy configuration script, add permissions
COPY tools/mariadb_setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb_setup.sh

## Copy perso configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/mariadb_setup.sh .

## Create repository for datas
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

## Use script as entrypoint
CMD ["mariadb_setup.sh"]

