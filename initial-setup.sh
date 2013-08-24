#!/bin/bash
# Based on instructions from http://elinux.org/RPi_Advanced_Setup
set -e #die if we encounter an error
# check root permissions
if [[ $UID != 0 ]]; then
    echo "Please start the script as root or sudo!"
    exit 1
fi

# update the packages that we already have
apt-get update
apt-get upgrade --yes

# install avahi for easier SSH access
apt-get --yes install avahi-daemon
insserv avahi-daemon
cp avahi-config /etc/avahi/services/multiple.service
/etc/init.d/avahi-daemon restart

# install nodejs into /usr/local/node-xxx
mkdir /tmp/node
pushd /tmp/node
NODENAME=node-v0.10.17-linux-arm-pi
wget --output-document=/tmp/node/$NODENAME.tar.gz http://nodejs.org/dist/v0.10.17/$NODENAME.tar.gz
tar xvzf /tmp/node/$NODENAME.tar.gz
mv -v /tmp/node/$NODENAME/ /usr/local/$NODENAME
popd
rm -rfv /tmp/node

#add nodejs to path
#there must be a nicer way of doing this...
echo "export PATH=\$PATH:/usr/local/$NODENAME/bin" >> /home/pi/.bash_profile
