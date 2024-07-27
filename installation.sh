#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo -e "\e[1;31mThis script must be run as root.\e[0m"
    exit 1
fi

BRIDGECTLDIR="/usr/etc/torctl/"

if [ ! -d $BRIDGECTLDIR ]; then
    mkdir -p $BRIDGECTLDIR
    chmod 775 $BRIDGECTLDIR
else
    echo -e "\e[1;33m$BRIDGECTLDIR\e[0m \e[1;31malready exists. Check it!\e[0m"
    exit 1
fi

if [ -z "$(ls -A $BRIDGECTLDIR)" ]; then
    cp ./{bridgectl,bridges.txt} $BRIDGECTLDIR
    chmod 755 -R $BRIDGECTLDIR
    chmod +x $BRIDGECTLDIR/bridgectl
    chmod +w $BRIDGECTLDIR/bridges.txt
    echo -e "\e[1;33mCheck if 'torctl' and 'obfs4proxy' have been installed, then run 'torctl start'. Otherwise install them first.\e[0m"
fi
