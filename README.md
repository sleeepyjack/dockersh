# dockersh
A login shell based on Docker containers.


### Usage
```sh
usage: dockersh [-h] [--version] [-i IMAGE] [-n NAME] [--shell SHELL]
                [--home HOME] [-t]

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i IMAGE, --image IMAGE
                        Docker base image to be used
  -n NAME, --name NAME  container name prefixed by 'dockersh_${USER}_'
  --shell SHELL         shell to start inside the container
  --home HOME           user home directory
  -t, --temporary       execute in temporary container
```
#### Examples
- Change the login shell of a users to `dockersh` with:
```
chsh -s /usr/local/bin/dockersh <username>
```
This change implies that whenever this user tries to logon to the host from outside (using ssh) he will be redirected into his personal `dockersh` container instead to the host itself.
Hence, he works in an encapsulated environment.


- Start a containerized shell with a specific base image:
```
dockersh -i nvidia/cuda
```
Will give you an interactive shell.

### Installation
#### Requirements
- Linux
- [Docker](https://docs.docker.com/install/)
- [Python 3.x](https://www.python.org/downloads/)
- [pip](https://pip.pypa.io/en/stable/installing/)

Make sure all `dockersh` users have the [permissions to interact with the Docker daemon](https://docs.docker.com/install/linux/linux-postinstall/).

You can install `dockersh` using the provided install script:
```
sudo <path to dockersh>/install.sh
```
Test your installation:
```
docker pull ubuntu
dockersh -t
```
This should give you an interactive shell in a temporary container.

### Configuration
The default configuration for each user is managed via `/etc/dockersh.ini`.

#### Example
```ini
[DEFAULT]
image = ubuntu
shell = /bin/bash

[myuser1]
image = alpine
shell = /bin/ash

[myuser2]
image = nvidia/cuda
home  = /somewhere/myuser1
```

### Backup
The home directory of the user is mounted inside of the container and can be used to store data persistently.
However, since the container state is __non-persistent__, make sure you commit your running containers from time to time.

`dockersh` provides an backup script which commits the current state of every `dockersh` container to the local registry.
You can simply add the following line to your `crontab`:
```
0   0   *   *   *   python3 <path to dockersh>/commit_all.py
```
This calls the backup script once every day at 12 AM.

### Disclaimer
This software __does not__ guarantee perfect encapsulation and security, since Docker itself may have some security issues.
