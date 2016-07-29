#/bin/bash
if [ "$(docker images -q oj_web)" != "" ]; then
	docker rmi -f oj_web;
fi
