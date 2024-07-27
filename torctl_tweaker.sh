#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    echo -e "\e[1;31mThis script must be run as root.\e[0m"
    exit 1
fi

declare -A CONST=(
            ["bak"]="/usr/etc/torctl/"
            ["dst"]="/usr/bin/torctl"
        )

declare -A SRC=(
            ["hook"]="# bridge hook\n[[ -f "/usr/etc/torctl/bridgectl" ]] && BRIDGECTL="/usr/etc/torctl/bridgectl" && source \$BRIDGECTL\n"
            ["torrc"]="\$USE_BRIDGES"
            ["start"]="# configure bridges to insert in the torrc file\n    [[ -f \$BRIDGECTL ]] && conf_bridges || :\n"
        )

#?
echo ${CONST["dst"]}

if [ ! -e ${CONST["dst"]} ]; then
    echo -e "\e[1;33mfile ${CONST["dst"]} doesn't exist. Install torctl.\e[0m"
    exit 1
fi

if [ ! -e ${CONST["bak"]} ]; then
    echo -e "\e[1;33mfile Run handler.sh before running this script.\e[0m"
    exit 1
fi

edit() {
    chmod +w ${CONST["dst"]}
    sed -i.bak "/# backup dir/ i ${SRC["hook"]}" ${CONST["dst"]}
    sed -i "/EnforceDistinctSubnets/ a ${SRC["torrc"]}" ${CONST["dst"]}
    sed -i "/# generate new torrc/ i\    ${SRC["start"]}" ${CONST["dst"]}
    mv ${CONST["dst"]}.bak ${CONST["bak"]}
}

restore() {
    sed -i '/# configure bridges/d' ${CONST["dst"]}
    sed -i '/# bridge hook/d;/BRIDGECTL/,+1d;/USE_BRIDGES/d;/conf_bridges/,+1d' ${CONST["dst"]}
}

if [ $# -lt 1 ]; then
    echo "not enough arguments"
else
    case "$1" in
    edit)
        edit
        ;;
    restore)
        restore
        ;;
    esac
fi



    
    