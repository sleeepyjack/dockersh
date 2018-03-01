#!/bin/sh

pip3 install --upgrade -r requirements.txt
cp dockersh /usr/local/bin
chmod +x /usr/local/bin/dockersh
cp dockersh.ini /etc
