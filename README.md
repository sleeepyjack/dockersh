# dockersh
A shell which places users into individual docker containers

### Usage
```sh
usage: dockersh [-h] [--version] [-i IMAGE] [-n NAME] [-t] [--shell SHELL]
                [--home HOME]

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i IMAGE, --image IMAGE
                        base image to be used
  -n NAME, --name NAME  container name
  -t, --temporary       execute in temporary container
  --shell SHELL         shell to start inside the container
  --home HOME           user home directory
```
#### Examples
- Change the login shell of a users to `dockersh` with:
```
chsh -s /usr/local/bin/dockersh <username>
```
This change implies that whenever this user tries to logon to the host from outside (using ssh) he will be redirected into his personal `dockersh` container instead to the host itself.
Therefore, he works in an encapsulated environment.


- Start a containerized shell with a specific base image:
```
dockersh -i nvidia/cuda
```
will give you an interactive shell.

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

**To enable scp,rsync,sftp for all users, configure rssh as follows:**
```
sudo echo "
allowscp
allowsftp
allowrsync
" > /etc/rssh.conf
```

### Configuration
The default configuration for each user is managed via `/etc/dockersh.ini`.

#### Example
```ini
[DEFAULT]
image = ubuntu:latest
suffix = _${USER}
shell = /bin/bash
homedir = ${HOME}
greeting = dockersh (github.com/sleeepyjack/dockersh)

[myuser1]
image = alpine:latest
shell = /bin/ash

[myuser2]
image = nvidia/cuda:latest
homedir  = /somewhere/myuser1
```

### Permission Errors - or: Make Container User = Host User
By default, docker runs as root, hence in the container, the home-directory of the user will be not accessable by default and has to be chowned at first.
To prevent this problem due to permissions we encourage you to use the image template of this repository, that maps the internal docker-user to the host-user.

1. Just type 
```
	./make_user_image.sh ubuntu_user ubuntu
```
to create a local image named 'ubuntu_user' that - together with dockersh - creates a user with the same uid and gid of the host user that runs `dockersh`.
2. Change your `/etc/dockersh.ini` to use the `ubuntu_user`-image.

**Note:** By default, it will overwrite the entrypoint of the 'cloned' image.


### Admin commands
First, register in `dockersh.ini` as an administrator.
```
    [ADMIN]
    names = admin_user1
```

**Log into host-system**:
```
    ssh myserver admin
```

**Log in as another user**:
```
    USER=otheruser dockersh
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



