#!/bin/bash
rm -rf /etc/kamailio
git clone  --progress --verbose https://github.com/Viking-VoIP/full-voip-on-k8s-sip-proxy-config.git /etc/kamailio
echo "Cloned succesfully..."
echo "Initializing now..."
cd /etc/kamailio/ && bash initialize.sh
