raspberrypi-setup
=================

Some simple scripts to help me remember how I set up my Raspberry Pi.
This assumes that you've gone with the default username of 'pi'.

###initial-setup.sh
* Performs apt-get update and upgrade.
* Installs avahi to make it easy to SSH into the Raspberry Pi by hostname via the magic of zeroconf networking. After
install, you should be able to SSH using a hostname like `raspberrypi.local`.
* Installs node.js

To run: `sudo ./initial-setup.sh`
