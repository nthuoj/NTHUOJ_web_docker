#!/bin/bash

if [ "$(docker ps -aqf "name=oj_web")" != "" ]; then
	docker stop oj_web
fi

if [ "$(docker ps -aqf "name=oj_web")" != "" ]; then
	docker rm -f oj_web
fi

if [ "$(docker images -q oj_web)" != "" ]; then
	docker rmi -f oj_web
fi

docker build -t oj_web .
