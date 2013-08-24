raspberrypi-setup
=================

Some simple scripts to help me remember how I set up my Raspberry Pi.

###initial-setup.sh
Installs avahi to make it easy to SSH into the Raspberry Pi by hostname via the magic of zeroconf networking. After
install, you should be able to SSH using a hostname like `raspberrypi.local`.

To run: `sudo ./initial-setup.sh`
