#!/bin/bash

DOCKERFILE_PREFIX="Dockerfile"
image=$1
if [ "${image}" = "" ]; then
    image="oj_web"
fi

bash docker_stop.sh ${image}
bash docker_rm_image.sh ${image}
docker build -t ${image} -f "${DOCKERFILE_PREFIX}_${image}" .
