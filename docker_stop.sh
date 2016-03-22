#/bin/bash

if [ "$(docker ps -aqf "name=oj_web")" != "" ]; then
	docker stop oj_web
fi

if [ "$(docker ps -aqf "name=oj_web")" != "" ]; then
	docker rm -f oj_web
fi
