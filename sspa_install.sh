#!/bin/sh

if ! command -v git &> /dev/null
then
	apt update && apt-get install git
fi
git clone https://github.com/Mirkopoj/sspa.git /opt/sspa

if ! command -v rustup &> /dev/null
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	export PATH="$HOME/.cargo/bin:$PATH"
fi

runuser -l  $(logname) -c 'rustup update'
wget https://raw.githubusercontent.com/Mirkopoj/sspa_installer_script/master/sspa_uninstall.sh -o /bin/sspa_uninstall.sh
chmod +x /bin/sspa_uninstall.sh
