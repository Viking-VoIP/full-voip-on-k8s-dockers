#!/bin/sh

rm -rf /var/www/html/
git clone https://github.com/davidcsi/voip-full-k8s-config-server.git /var/www/html
#nginx -g 'daemon off;'
service nginx start