all: oj_web oj_mail

oj_web:
	sh docker_rebuild.sh oj_web
	if [ ! -d "NTHUOJ_web" ]; then \
		docker run -d --name=oj_web oj_web; \
		docker cp oj_web:/NTHUOJ_web .; \
		sh docker_stop.sh oj_web; \
	fi

oj_mail:
	sh docker_rebuild.sh oj_mail

rm_oj_web:
	sh docker_stop.sh oj_web
	sh docker_rm_image.sh oj_web
	@read -p "Do you want to remove NTHUOJ_web?. [y/N]: " CONTINUE; \
	[ $$CONTINUE = "y" -o $$CONTINUE = "Y" ] && rm -rf NTHUOJ_web && exit 0;\
	[ $$CONTINUE = "n" -o $$CONTINUE = "N" ] && exit 0;

rm_oj_mail:
	sh docker_stop.sh oj_mail
	sh docker_rm_image.sh oj_mail

clean: rm_oj_mail rm_oj_web
