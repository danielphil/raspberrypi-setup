#!/bin/bash

# Install everything we need to run a CUPS raw print server
# for an HP LaserJet 1020

# foo2zjs is needed for IPP but it's just far too slow on the
# RPi 1B. So instead, set up a really basic print server using
# a regular LaserJet 1020 driver on the Mac to print

set -e #die if we encounter an error
# check root permissions
if [[ $UID != 0 ]]; then
    echo "Please start the script as root or sudo!"
    exit 1
fi

# update the packages that we already have
apt-get update
apt-get upgrade --yes

apt-get install cups
usermod -a -G lpadmin $USER
cupsctl --remote-any

# thanks to https://www.devroom.io/2006/11/13/cups-426-upgrade-required/
# plus don't keep jobs sitting around
{
    echo 'DefaultEncryption Never'
    echo 'PreserveJobFiles No'
    echo 'PreserveJobHistory No'
} >> /etc/cups/cupsd.conf

systemctl restart cups

# install the utility for automatically installing firmware
pushd .
git clone https://github.com/koenkooi/foo2zjs.git
cd foo2zjs
sudo make install-hotplug
popd

# you should be able to browse to http://localhost:631 at this point
# add a printer and select Raw
# printer connection looks like usb://HP/LaserJet%201020?serial=XXXXXXX
# Printer type 'Raw' and use 'Raw Queue'

# Once added, install the regular HP 1022 drivers for your Mac, add the printer
# and print as normal (hopefully!)