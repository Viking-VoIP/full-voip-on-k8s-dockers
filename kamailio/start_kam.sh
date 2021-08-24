#!/bin/bash
rm -rf /etc/kamailio
git clone https://github.com/davidcsi/voip-full-k8s-sip-proxy.git /etc/kamailio
cd /etc/kamailio/ && bash initialize.sh
