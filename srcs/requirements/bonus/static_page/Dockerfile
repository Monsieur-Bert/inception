## Based on the antepenultiam stable debian
FROM debian:bullseye

## Install Apache
RUN apt-get update -y && \
    apt-get install -y apache2

## Remove unused cache from installation
RUN rm -rf /var/lib/apt/lists/*

## Modify listen port (81 insted of 80)
RUN sed -i  's/80/81/g' /etc/apache2/ports.conf

## Copy configuration files into default Apache service
COPY ./html /var/www/html

## Add Server Name to the end of the apach2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

## Launch Apache in foreground
CMD ["apachectl", "-D", "FOREGROUND"]
