#!/bin/sh

NAME=$(whoami)

if ! command -v git &> /dev/null
then
	sudo apt update && sudo apt-get install git
fi

sudo apt install pigpio pigpiod pip python3
pip install pigpio

if ! command -v rustup &> /dev/null
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	(sudo -iu $NAME -- export PATH) >> /dev/null
fi

if [ -d /opt/sspa ];
then
	sudo rm /opt/sspa -r
fi
sudo git clone https://github.com/Mirkopoj/sspa.git /opt/sspa

rustup update

sudo groupadd sspa
sudo chgrp sspa /opt/sspa/ -R
sudo chmod g+wrx /opt/sspa/ -R
sudo usermod -aG sspa spi gpio $NAME

(sudo -iu $NAME -- cargo build --release --manifest-path /opt/sspa/Cargo.toml ) >> /dev/null
sudo cp /opt/sspa/target/release/sspa /bin/sspa

sudo wget https://raw.githubusercontent.com/Mirkopoj/sspa_installer_script/master/sspa_uninstall.sh -O /bin/sspa_uninstall.sh
sudo chmod +x /bin/sspa_uninstall.sh

sudo sed -i '$ s/$/ isolcpus=3/' /boot/cmdline.txt
echo dtparam=spi=on | sudo tee -a /boot/config.txt

echo 
echo Instalation finished
echo Reboot for boot parameters to take effect
echo 
echo Run sspa_uninstall.sh to uninstall
echo Run sspa --help for help on how to use the program
