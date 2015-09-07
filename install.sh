#!/bin/bash

TIM=`date '+%F_%T'`
BAK=backup_$TIM
SRC=`pwd`

# TODO possible improvement using rsync
#rsync -av --exclude=".*" src dest

echo
if [ $EUID != 0 ] ; then
    echo "For this you will need root access."
    echo "That means sudo must work for your"
    echo "user account."
    echo
    read -s -n 1 -p "Proceede anyway? (Y|n) "
    if [ "$REPLY" == "n" ] || [ "$REPLY" == "N" ] ; then
        echo
        echo "Installation aborted!"
        echo
        exit
    fi
    echo
    echo
    sudo "$0" "$@"
    exit $?
fi
echo "Installing GTK themes..."
cd /usr/share/themes
if [ -e Abluent ] ; then
    echo "  renamimg original Abluent directory to Abluent.$BAK"
    mv Abluent Abluent.$BAK
fi
echo "  copying new files ..."
cp -r $SRC ./Abluent
echo "  deleting unneeded files ..."
cd ./Abluent && rm -rf .git* install.sh
echo "done."
echo
