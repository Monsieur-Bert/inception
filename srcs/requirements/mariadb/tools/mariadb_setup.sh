#!/bin/bash

## Import 
MYSQL_PASSWORD=$(< /run/secrets/mysql_password)
MYSQL_ROOT_PASSWORD=$(< /run/secrets/mysql_root_password)

set -e

## Secure the env variables
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ]; then
    echo "Erreur: Missing Environnment Variables"
    exit 1
fi

## Init only for the first time
if [ ! -d "var/log/mysql/mysql" ]; then

    ## Init database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    ## Temporary launch
    mysqld_safe --user=mysql --datadir=/var/lib/mysql --skip-networking &
    MYSQL_PID=$!

    ## Wait for MariaDB to be ready
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    ## Secured Configuration
    mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    ## Stop temporary process
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
    wait $MYSQL_PID
fi

## exec mariaDB as PID 1
exec mysqld --user=mysql --datadir=/var/lib/mysql