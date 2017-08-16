#!/bin/bash

# Clean out old pidfiles and tmp files
rm -rf /run/apache2/*
rm -rf /tmp/*

mkdir /var/log/apache2/bandwidthd
mkdir /var/www/html/bandwidth

/setup-bandwidthd.pl > /etc/bandwidthd/bandwidthd.conf
service bandwidthd start
/usr/sbin/apache2ctl -D FOREGROUND
