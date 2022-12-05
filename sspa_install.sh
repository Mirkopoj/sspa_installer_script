#!/bin/sh

if ! command -v git &> /dev/null
then
	apt update && apt-get install git
fi
if [-d "/opt/sspa"];
then
	git clone https://github.com/Mirkopoj/sspa.git /opt/sspa
fi

if ! command -v rustup &> /dev/null
then
	runuser -l  $(logname) -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
fi

runuser -l  $(logname) -c 'rustup update'
wget https://raw.githubusercontent.com/Mirkopoj/sspa_installer_script/master/sspa_uninstall.sh -o /bin/sspa_uninstall.sh
chmod +x /bin/sspa_uninstall.sh
