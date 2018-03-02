#!/bin/sh

pip3 install --upgrade -r requirements.txt
activate-global-python-argcomplete
cp dockersh /usr/local/bin
chmod +x /usr/local/bin/dockersh
cp dockersh.ini /etc
echo "done!"
