#!/bin/sh

if [ "$1" = server ]; then
    dosbox -c "ipxnet startserver 2130" -c 'mount c .' -c 'c:' -c 'IPXSETUP -NODES 3'
else
    dosbox -c "ipxnet connect $1 2130" -c 'mount c .' -c 'c:' -c IPXSETUP
fi
