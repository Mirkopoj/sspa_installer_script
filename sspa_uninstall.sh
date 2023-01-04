#!/bin/sh

sudo rm /bin/sspa
sudo rm /opt/sspa -r
sudo groupdel sspa
sudo rm /bin/sspa_uninstall.sh
sudo sed -i 's/isolcpus=3//' /boot/cmdline.txt
sudo sed -i 's/dtparam=spi=on//' /boot/config.txt
sudo gpasswd $(logname) spi gpio
