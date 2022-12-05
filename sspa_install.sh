#!/bin/sh

if ! command -v git &> /dev/null
then
	sudo apt update && sudo apt-get install git
fi

if ! command -v rustup &> /dev/null
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	export PATH
	echo Rerun sspa_install.sh
	exit
fi

if [[ -d /opt/sspa ]];
then
	sudo rm /opt/sspa -r
fi
sudo git clone https://github.com/Mirkopoj/sspa.git /opt/sspa

rustup update
sudo wget https://raw.githubusercontent.com/Mirkopoj/sspa_installer_script/master/sspa_uninstall.sh -o /bin/sspa_uninstall.sh
sudo chmod +x /bin/sspa_uninstall.sh
echo Run sspa_uninstall.sh to uninstall
