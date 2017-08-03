#!/bin/bash

# Clean out old pidfiles and tmp files
rm -rf /run/apache2/*
rm -rf /tmp/*

/usr/sbin/apache2ctl -D FOREGROUND


