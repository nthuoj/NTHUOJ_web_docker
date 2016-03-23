#/bin/bash

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

docker run -d -p 80:8000 -v $(pwd)/data:/var/nthuoj -v $(pwd)/media:/NTHUOJ_web/media --name=oj_web --cpu-shares 20 --restart=always oj_web
