#!/bin/bash

rm -rf /etc/freeswitch
git clone https://github.com/davidcsi/voip-full-k8s-sip-b2bua.git /etc/freeswitch
PUB_IP=$(wget -q -O - http://169.254.169.254/latest/meta-data/public-ipv4)
sed -i.original 's/{{ PUBLIC_IP }}/'$PUB_IP'/g' /etc/freeswitch/sip_profiles/external.xml
/usr/bin/freeswitch -u freeswitch -g freeswitch -c