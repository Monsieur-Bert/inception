#!bin/bash

## Read Secrets
FTP_USER_PASSWORD=$(< /run/secrets/ftp_user_password)

set -e

# Create FTP user if it doesn't exist
if ! id "$FTP_USER" &>/dev/null; then
	echo "Creating FTP user: $FTP_USER"
	useradd -m -s /bin/bash "$FTP_USER"
	echo "$FTP_USER:$FTP_USER_PASSWORD" | chpasswd
fi

## Create user_list file
echo "$FTP_USER" > /etc/vsftpd/user_list

## Set permissions for wordpress volume
chown -R "$FTP_USER:$FTP_USER" /var/www/html
chmod -R 755 /var/www/html

## Create log file and set rights
touch /var/log/vsftpd.log
chmod 664 /var/log/vsftpd.log

# Update pasv_address with container IP if needed
if [ -n "$PASV_ADDRESS" ]; then
    sed -i "s/pasv_address=127.0.0.1/pasv_address=$PASV_ADDRESS/" /etc/vsftpd/vsftpd.conf
fi

## Launch FTP Server in foreground
exec vsftpd /etc/vsftpd/vsftpd.conf