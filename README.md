# docker_ctf_pwn

## Quick Start

1. Pull and Run docker image.

```bash:
$ docker pull tsalvia/ctf_pwn
$ docker run --privileged -it tsalvia/ctf_pwn
```

2. Copy file.

```bash:
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
e9adc252eaac        tsalvia/ctf_pwn     "/bin/bash"         31 seconds ago      Up 6 seconds                            dazzling_austin
$ docker cp <file> e9adc252eaac:/root
```

## Getting Started

### Installing

Build Docker Image

```bash:
$ git clone https://github.com/tsalvia/docker_ctf_pwn.git
$ cd docker_ctf_pwn
$ docker-compose build ctf_pwn
```

### Running the tests

1. Running Docker Image

   ```bash:
   $ docker-compose run ctf_pwn
   root@c200263ac40c:~# 
   ```
   
   or
   
   ```bash:
   $ docker run --privileged -it ctf_pwn
   ```

1. Open another terminal. Copy file to want analysing in Docker Image.

   ```bash:
   $ docker-compose ps -q ctf_pwn
   c200263ac40cc18f12dd9db68b255b751fe1c5711f2d1139b067249231164973
   $ docker cp <file> c200263ac40cc18f12dd9db68b255b751fe1c5711f2d1139b067249231164973:/root
   ```
