#!/bin/bash

if [ -z "${HOST_USER_NAME}" -o -z "${HOST_USER_ID}" -o -z "${HOST_USER_GID}" ]; then
	echo "HOST_USER_NAME, HOST_USER_ID & HOST_USER_GID needs to be set!"; exit 100
fi

groupadd --gid "${HOST_USER_GID}" "${HOST_USER_NAME}"
useradd \
      --uid ${HOST_USER_ID} \
      --gid ${HOST_USER_GID} \
      --create-home \
      --shell /bin/bash \
      ${HOST_USER_NAME}
usermod -aG sudo ${HOST_USER_NAME}

echo ${HOST_USER_NAME}:${HOST_USER_NAME} | chpasswd

exec su - "${HOST_USER_NAME}"
