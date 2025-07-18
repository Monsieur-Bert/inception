## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install MariaDB
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Create repository for datas && add to group
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

## Create repository for socket && add to group
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

## Copy mariadb configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

## Copy setup script, add permissions
COPY tools/mariadb_setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb_setup.sh

## Use script as entrypoint
ENTRYPOINT ["mariadb_setup.sh"]