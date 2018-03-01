#!/bin/sh

pip3 install requirements.txt
cp dockersh /usr/local/bin
chmod +x /usr/local/bin/dockersh
cp dockersh.ini /etc
