#!/bin/bash

image=$1
if [ "${image}" == "" ]; then
    image="oj_web"
fi

if [ "$(docker images -q ${image})" != "" ]; then
	docker rmi -f ${image};
fi
