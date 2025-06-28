#!/bin/bash

## Create SSL repository
mkdir -p /etc/nginx/ssl
mkdir -p /etc/nginx/nginx

## Generate SSL Certificate only if it's not existing
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=France/L=Paris/O=42School/OU=student/CN=$DOMAIN_NAME" 2>/dev/null
fi

## Env substitution ##? bizare un peu
envsubst '${DOMAIN_NAME}' < /etc/nginx/sites-available/default.conf > /etc/nginx/sites-available/default

## Test nginx configuration
nginx -t

exec nginx -g "daemon off;"
