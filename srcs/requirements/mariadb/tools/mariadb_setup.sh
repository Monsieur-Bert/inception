#!/bin/bash

set -e

## Secure the env variables
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ]; then
    echo "Error: Missing Environnement Variables"
    exit 1
fi

if [ ! -d "/run/mysqld" ]; then
	echo "[DB config] Granting MariaDB daemon run permissions..."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

chown -R mysql:mysql /var/lib/mysql

## Init only for the first time
if [ ! -d "var/lib/mysql/mysql" ]; then

    ## Init database
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --basedir=/usr --rpm 

    ## Secured Configuration
    mysqld --user=mysql --bootsrap << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

fi

exec mysqld --user=mysql --console --skip-ssl
