#/bin/sh
all:
	sh docker_rebuild.sh
	if [ ! -d "NTHUOJ_web" ]; then \
		docker run -d --name=oj_web oj_web; \
		docker cp oj_web:/NTHUOJ_web .; \
		sh docker_stop.sh; \
	fi

clean:
	sh docker_stop.sh
	sh docker_rm_image.sh
	@read -p "Do you want to remove NTHUOJ_web?. [y/N]: " CONTINUE; \
	[ $$CONTINUE = "y" -o $$CONTINUE = "Y" ] && rm -rf NTHUOJ_web && exit 0;\
	[ $$CONTINUE = "n" -o $$CONTINUE = "N" ] && exit 0;
