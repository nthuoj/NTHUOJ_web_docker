# NTHUOJ_web_docker

## Require
  * Docker >= 1.9.0
  * MySQL Database

## Getting started
1. Set up a mysql database, for example
    ```
    $ create database dbname character set utf8;
    $ GRANT ALL ON *.* TO 'user'@'%' IDENTIFIED BY 'password';
    $ FLUSH PRIVILEGES;
    ```
2. Edit `client`(database) and `email` section in `oj_web_build/NTHUOJ_web/nthuoj/config/nthuoj.cfg`
3. Generate certificates and keys for TLS connection to docker daemon

    ```
    $ sudo ./docker_tls_setup.sh
    ```

4. Configure docker daemon with TLS support

  - **_If your system (Ex. Ubuntu 15.04 or higher) uses systemd as a process manager, please follow the steps below_**

    1. Create a systemd drop-in directory for the docker service

        ```
        $ sudo mkdir /etc/systemd/system/docker.service.d
        ```

    2. Create a file called `/etc/systemd/system/docker.service.d/tls.conf` which contains the following contents

        ```
        [Service]
        ExecStart=
        ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
        ```

    3. Flush changes

        ```
        $ sudo systemctl daemon-reload
        ```

  - **_If your system (Ex. Ubuntu 14.04) uses Upstart as a process manager, please follow the steps below_**

    1. Create the `/etc/default/docker` file on your host if you don’t have one
    2. Open the file with your favorite editor

        ```
        $ sudo vi /etc/default/docker
        ```

    3. Add a `DOCKER_OPTS` variable with the following options and then save the file

        ```
        DOCKER_OPTS="-D -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2376"
        ```

5. Restart docker daemon

  - For the system that uses **systemd** as a process manager

    ```
    $ sudo systemctl restart docker
    ```
  
  - For the system that uses **Upstart** as a process manager

    ```
    $ sudo service docker restart
    ```

6. Make sure that you can connect to docker daemon without sudo

    ```
    $ docker ps
    $ docker --tlsverify -H tcp://127.0.0.1:2376 ps
    ```

    If not, please check [this](https://docs.docker.com/engine/installation/linux/ubuntulinux/#create-a-docker-group) and make sure you've followed the step above correctly. 

7. Build all images

    ```
    $ make
    ```

## Running web container
```
$ ./docker_start.sh
```

## Stop web container
```
$ ./docker_stop.sh
```

## Edit NTHUOJ_web file with docker container
```
$ ./docker_dev.sh
```

## (Re)build web image only
```
$ make oj_web
```

## (Re)build mail server image only
```
$ make oj_mail
```

## Remove web image only
```
$ make rm_oj_web
```

## Remove mail server image only
```
$ make rm_oj_mail
```

## Remove all images
```
$ make clean
```
