#!/bin/bash

if [ "$(docker ps -aqf "name=oj_web")" != "" ]; then
	docker stop oj_web
fi

if [ "$(docker ps -aqf "name=oj_web")" != "" ]; then
	docker rm -f oj_web
fi
docker run -it -p 80:8000 -v $(pwd)/data:/var/nthuoj -v $(pwd)/NTHUOJ_web:/NTHUOJ_web -v $(pwd)/media:/NTHUOJ_web/media --name=oj_web oj_web bash
