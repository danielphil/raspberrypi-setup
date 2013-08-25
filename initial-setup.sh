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
echo "export PATH=\$PATH:/usr/local/$NODENAME/bin" >> /home/pi/.bashrc

# install nodejs into /usr/local/node-xxx
mkdir /tmp/phantomjs
pushd /tmp/phantomjs
wget https://github.com/aeberhardo/phantomjs-linux-armv6l/archive/master.zip
unzip master.zip
cd phantomjs-linux-armv6l-master
bunzip2 *.bz2 && tar xf *.tar
mv -v phantomjs-1.9.0-linux-armv6l /usr/local/phantomjs-1.9.0-linux-armv6l
popd
rm -rfv /tmp/phantomjs

#add phantomjs to path
echo "export PATH=\$PATH:/usr/local/phantomjs-1.9.0-linux-armv6l/bin" >> /home/pi/.bashrc

# install casperjs from git
git clone git://github.com/n1k0/casperjs.git /usr/local/casperjs
pushd /usr/local/casperjs
git checkout tags/1.1-beta1
popd

# add casperjs to path
echo "export PATH=\$PATH:/usr/local/casperjs/bin" >> /home/pi/.bashrc

# install mercurial
apt-get install mercurial --yes
