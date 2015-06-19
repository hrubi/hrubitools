#!/bin/sh

basedir=$(dirname $(readlink -f $0))
cd "$basedir"

if [ ! -f mnt/setup.exe ]; then
    fuseiso "Warcraft 2.bin" mnt
fi

if [ "$1" = server ]; then
    dosbox -c "ipxnet startserver 2130" \
        -c 'mount c WAR2' -c 'mount d mnt -t cdrom' \
        -c 'c:' \
        -c 'WAR2'
else
    dosbox -c "ipxnet connect $1 2130" \
        -c 'mount c WAR2' -c 'mount d mnt -t cdrom' \
        -c 'c:' \
        -c 'WAR2'
fi
