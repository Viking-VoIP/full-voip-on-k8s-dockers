#!/bin/bash

rm -rf /etc/freeswitch
git clone https://github.com/Viking-VoIP/full-voip-on-k8s-sip-b2bua-config.git /etc/freeswitch
bash /etc/freeswitch/startup.sh