#!/bin/bash

bash docker_stop.sh oj_web
docker run -it -p 80:8000 -v $(pwd)/data:/var/nthuoj -v $(pwd)/NTHUOJ_web:/NTHUOJ_web -v $(pwd)/media:/NTHUOJ_web/media --name=oj_web oj_web bash
