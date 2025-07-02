#!/bin/bash

set -e

echo "=== Start WP Setup ==="

cd /var/www/html

## Download wp only if is not existing
if [ ! -f wp-config.php ] && [ ! -d wp-admin ]; then
	echo "=== DL wp==="
	wp core download --allow-root

	echo "=== WP configuration ==="
	## Wordpress Configuration
	wp config create \
	--dbname="$MYSQL_DATABASE" \
	--dbuser="$MYSQL_USER" \
	--dbpass="$MYSQL_PASSWORD" \
	--dbhost="mariadb:3306" \
	--allow-root
	echo "=== ✅ WP configurated ==="

	echo "=== Waiting DB to be ready ==="
	## Wait db to be ready
	sleep 10

	echo "=== Instal WP ==="
	## Wordpress Installation
	wp core install \
	--url="https://$DOMAIN_NAME" \
	--title="$WP_TITLE" \
	--admin_user="$WP_ADMIN_USER" \
	--admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--allow-root
	echo "=== ✅ Wordpress instaled ✅ ==="

	echo "=== Create second user ==="
	## Create an second user
	wp user create \
	"$WP_USER" \
	"$WP_USER_EMAIL" \
	--user_pass="$WP_USER_PASSWORD" \
	--role=editor \
	--allow-root
fi

echo "=== Correct permissions ==="
chown -R www-data:www-data /var/www/html
chmod 755 /var/www/html

echo "=== TRY LAUNCH PHP ==="
php-fpm7.4 -t

echo "=== LAUNCH PHP-FPM ==="
exec php-fpm7.4 --nodaemonize --fpm-config /etc/php/7.4/fpm/php-fpm.conf
