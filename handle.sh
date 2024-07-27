#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo -e "\e[1;31mThis script must be run as root.\e[0m"
    exit 1
fi

BRIDGECTLDIR="/usr/etc/torctl/"

inst() {
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
        /bin/bash torctl_tweaker.sh edit
        echo -e "\e[1;33mCheck if 'torctl' and 'obfs4proxy' have been installed, then run 'torctl start'. Otherwise install them first.\e[0m"
    fi
}

uninst() {
    /bin/bash torctl_tweaker.sh restore
    if [ -d $BRIDGECTLDIR ]; then
        rm -r $BRIDGECTLDIR
    else
        echo -e "\e[1;33mbtidgectl\e[0m \e[1;31mseems to have been already uninstalled\e[0m"
        exit 1
    fi
}

on() {
    if [ -e $BRIDGECTLDIR/bridgectl ]; then
        echo -e "\e[1;33mbridgectl is enabled\e[0m"
        exit 0
        # TODO if no file
    fi

    if [ -e $BRIDGECTLDIR/.bridgectl ]; then
        mv $BRIDGECTLDIR/.bridgectl $BRIDGECTLDIR/bridgectl
    fi
}

off() {
    if [ -e $BRIDGECTLDIR/bridgectl ]; then
        mv $BRIDGECTLDIR/bridgectl $BRIDGECTLDIR/.bridgectl
    fi

    if [ -e $BRIDGECTLDIR/.bridgectl ]; then
        echo -e "\e[1;33mbridgectl is already disabled. cannot disable bridgectl\e[0m"
    else
        echo -e "\e[1;33mfile $BRIDGECTLDIR/bridgectl doesn't exist. cannot disable bridgectl\e[0m"
        exit 1
    fi
}

add() {
    if [ -e $BRIDGECTLDIR/bridges.txt ]; then
        nano $BRIDGECTLDIR/bridges.txt
    else
        echo -e "\e[1;33mfile $BRIDGECTLDIR/bridges.txt doesn't exist.\e[0m"
        exit 1
    fi
}

tip() {
    echo -e "****"
    echo -e "   install"
    echo -e "   uninstall"
    echo -e "   enable"
    echo -e "   disable"
    echo -e "   add    - opens file, where you can add/remove bridges\n"
}

case "$1" in
install)
    inst
    ;;
uninstall)
    uninst
    ;;
enable)
    on
    ;;
disable)
    off
    ;;
add)
    add
    ;;
"")
    echo "not enough arguments"
    tip
    ;;
*)
    echo "unexpected argument $1"
    tip
    ;;
esac