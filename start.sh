#!/bin/bash
echo "Starting Nginx..."
NGINX=/usr/sbin/nginx
# show Version and compile config
$NGINX -V
# test config
$NGINX -t
$NGINX &
#/usr/sbin/php5-fpm -F
/usr/local/sbin/php-fpm -F
