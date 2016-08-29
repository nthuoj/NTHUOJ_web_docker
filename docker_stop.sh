#!/bin/bash

image=$1
if [ "${image}" == "" ]; then
    image="oj_web"
fi

docker ps -aqf "ancestor=${image}" | \
while read -r container_id
do
    docker stop ${container_id}
    docker rm -f ${container_id}
done
