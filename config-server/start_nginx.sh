#!/bin/sh

rm -rf /var/www/html/
git clone https://github.com/Viking-VoIP/full-voip-on-k8s-config-server-config.git /var/www/html
#nginx -g 'daemon off;'
service nginx start