# docker_ctf_pwn

A docker environment for pwn in ctf.  
https://github.com/tsalvia/docker_ctf_pwn

## Quick Start

```bash
$ docker pull tsalvia/ctf_pwn
$ docker run \
    --privileged \
    -it \
    -v /local/folder/:/mnt \
    -v /local/libc_db/:/opt/libc-database/db \
    tsalvia/ctf_pwn
root@e9adc252eaac:~/workdir#
```

## Getting Started

### Build or Get Docker Image

- Build docker image

    ```bash
    $ docker-compose build
    ```
or

- Get docker image

    ```bash
    $ docker pull tsalvia/ctf_pwn
    ```

### Running the tests

1. Edit ``.env`` file

    ```bash
    $ vi .env
    COMPOSE_PROJECT_NAME=ctf_name
    SHARE_DIR_PATH=/local/folder
    LIBC_DB_PATH=/local/libc/db/folder
    ```

1. Run container

    ```bash
    $ docker-compose run ctf
    root@c200263ac40c:~/workdir# 
    ```

1. (option) Update libc-database

    The following commands must be executed in the container.

    ```bash
    $ /opt/libc-database/get
    Getting package location for ubuntu-xenial-i386
    Getting ubuntu-xenial-i386-libc6
      -> Location: http://security.ubuntu.com/ubuntu/pool/main/g/glibc/libc6_2.23-0ubuntu10_i386.deb
      -> ID: libc6_2.23-0ubuntu10_i386
      -> Downloading package
      -> Extracting package
      -> Writing libc to db/libc6_2.23-0ubuntu10_i386.so
      -> Writing symbols to db/libc6_2.23-0ubuntu10_i386.symbols
      -> Writing version info
    ```
