#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: deploy.sh USER HOST"
    exit 1
fi

USER=$1
HOST=$2
FILE=fb_ili9340.ko

REAL_USER=$(ssh resinvpn -o Hostname=$HOST 'jq -r .username /mnt/conf/config.json')
if [ "$REAL_USER" != "$USER" ]; then
    echo "Error: $HOST doesn't seem to match user $USER"
    exit 1
fi

echo "Deploying $FILE to $HOST..."
scp  -o Hostname=$HOST ./$FILE resinvpn:/lib/modules/3.18.5/kernel/drivers/video/fbdev/fbtft
