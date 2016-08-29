# NTHUOJ_web_docker

## Require
  * Docker >= 1.9.0

## Getting started
1. Edit `client`(database) and `email` section in `oj_web_build/NTHUOJ_web/nthuoj/config/nthuoj.cfg`
2. Configure docker with tls support

  ```
  sudo ./docker_tls_setup.sh
  ```

3. restart docker daemon

  ```
  sudo service docker restart
  ```

4. make sure that you can connect to docker daemon without sudo

  ```
  docker ps
  ```

   if not, please check [this](https://docs.docker.com/engine/installation/linux/ubuntulinux/#create-a-docker-group)

5. build all images

  ```
  make
  ```

## Running web container
```
./docker_start.sh
```

## Stop web container
```
./docker_stop.sh
```

## Edit NTHUOJ_web file with docker container
```
./docker_dev.sh
```

## (Re)build web image only
```
make oj_web
```

## (Re)build mail server image only
```
make oj_mail
```

## Remove web image only
```
make rm_oj_web
```

## Remove mail server image only
```
make rm_oj_mail
```

## Remove all images
```
make clean
```
