#!/bin/bash

if [ -z "$1" -o -z "$2" ]; then
	echo "./make_user_image.sh [name] [source-image]"; exit 100
fi

sed -i "1s/.*/FROM $2/" image_template/Dockerfile
cd image_template
docker build -t $1 .
