#!/bin/sh

apt update && apt-get install git
git clone https://github.com/Mirkopoj/sspa.git /opt/sspa
if ! command -v rustup &> /dev/null
then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

runuser -l  $(logname) -c 'rustup update'
