# docker_ctf_pwn

## Getting Started

### Installing

Build Docker Image

```bash:
$ docker-compose build ctf_pwn
```

### Running the tests

1. Running Docker Image

   ```bash:
   $ docker-compose run ctf_pwn
   root@c200263ac40c:~# 
   ```

1. Open another terminal. Copy file to want analysing in Docker Image.

   ```bash:
   $ docker-compose ps -q ctf_pwn
   c200263ac40cc18f12dd9db68b255b751fe1c5711f2d1139b067249231164973
   $ docker cp <file> c200263ac40cc18f12dd9db68b255b751fe1c5711f2d1139b067249231164973:/root
   ```
