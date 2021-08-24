#!/bin/sh

consul agent -join=consul.service.consul -rejoin -datacenter=voip-full -enable-script-checks -config-file=/etc/consul.d/consul.hcl -config-dir=/etc/consul.d/ -advertise=$(wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4)