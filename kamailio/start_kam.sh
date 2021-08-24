#!/bin/bash
rm -rf /etc/kamailio
git clone https://github.com/Viking-VoIP/full-voip-on-k8s-sip-proxy-config.git /etc/kamailio
cd /etc/kamailio/ && bash initialize.sh
