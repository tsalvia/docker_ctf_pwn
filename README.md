# docker_ctf_pwn

A docker environment for pwn in ctf.  
https://github.com/tsalvia/docker_ctf_pwn

## Quick Start

```bash:
$ docker pull tsalvia/ctf_pwn
$ docker run --privileged -it -v /local/folder/:/mnt tsalvia/ctf_pwn
root@e9adc252eaac:~/workdir#
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

```bash:
$ docker-compose run ctf_pwn
root@c200263ac40c:~/workdir# 
```
