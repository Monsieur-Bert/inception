#!/bin/bash

set -e

## Wait for Mariadb to be ready
while ! nc -z mariadb 3306; do
	sleep 1
done

## Download wp only if is not existing
if [ ! -f wp-config.php ] && [ ! -d wp-admin ]; then
	wp core download --allow-root

	## Wordpress Configuration
	wp config create \
	--dbname="$MYSQL_DATABASE" \
	--dbuser="$MYSQL_USER"\
	--dbpass="$MYSQL_PASSWORD" \
	--dbhost="mariadb::3306" \
	--allow-root

	## Wait db to be ready
	sleep 5

	## Wordpress Installation
	wp core install \
	--url="https:://$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--allow-root

	## Create an second user
	wp user create \
	"$WP_USER" \
	"$WP_USER_EMAIL" \
	--user_pass="$WP_USER_PASSWORD" \
	--role=editor \
	--allow-root
fi

chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html

exec php-fpm7.4 --nodaemonize