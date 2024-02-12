#!/usr/bin/env bash

sleep 60
apt -y update > /root/aptu.log 2> /root/aptu.log
apt -y install apache2 > /root/apt.log 2> /root/apt.err.log

touch /root/srv1_cloud-init

reboot
