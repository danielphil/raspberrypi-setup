#!/bin/bash
# Based on instructions from http://elinux.org/RPi_Advanced_Setup
set -e #die if we encounter an error
# check root permissions
if [[ $UID != 0 ]]; then
    echo "Please start the script as root or sudo!"
    exit 1
fi
apt-get update
apt-get upgrade --yes
apt-get --yes install avahi-daemon
insserv avahi-daemon
cp avahi-config /etc/avahi/services/multiple.service
/etc/init.d/avahi-daemon restart
