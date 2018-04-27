#!/bin/bash

# Clean out old pidfiles and tmp files
rm -rf /run/*.pid
rm -rf /tmp/*

/usr/sbin/apache2ctl -D FOREGROUND
