#!/bin/sh

pip3 install --upgrade -r requirements.txt
if [ -z "$1" ]; then
    activate-global-python-argcomplete
else
    activate-global-python-argcomplete --dest=$1
fi
cp dockersh /usr/local/bin
chmod +x /usr/local/bin/dockersh
cp -n dockersh.ini /etc
