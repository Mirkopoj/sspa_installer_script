#!/bin/sh

if ! command -v git &> /dev/null
then
	sudo apt update && sudo apt-get install git
fi

if ! command -v rustup &> /dev/null
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	(sudo -iu $(logname) -- export PATH) >> /dev/null
fi

if [[ -d /opt/sspa ]];
then
	sudo rm /opt/sspa -r
fi
sudo git clone https://github.com/Mirkopoj/sspa.git /opt/sspa

rustup update

sudo groupadd sspa
sudo chgrp sspa /opt/sspa/ -R
sudo chmod g+wrx /opt/sspa/ -R
sudo usermod -aG sspa $(logname)

(sudo -iu $(logname) -- cargo build --release --manifest-path /opt/sspa/Cargo.toml ) >> /dev/null
sudo cp /opt/sspa/target/release/sspa /bin/sspa

sudo wget https://raw.githubusercontent.com/Mirkopoj/sspa_installer_script/master/sspa_uninstall.sh -O /bin/sspa_uninstall.sh
sudo chmod +x /bin/sspa_uninstall.sh

echo 
echo Instalation finished
echo Run sspa_uninstall.sh to uninstall
echo Run sspa --help for help on how to use the program
