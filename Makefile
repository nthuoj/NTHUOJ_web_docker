#remove = "N"

all:
	docker build -t oj_web .
	if [ ! -d "NTHUOJ_web" ]; then \
		docker run -d --name=oj_web oj_web; \
		docker cp oj_web:/NTHUOJ_web .; \
		sh docker_stop.sh; \
	fi

#	@read -p "Do you want to remove NTHUOJ_web?(y/N): " remove;

clean:
	./docker_stop.sh
	@if [ "$(docker images -q oj_web)" != "" ]; then \
		docker rmi -f oj_web; \
	fi
	@while [ -z "$$CONTINUE" ]; do \
		read -r -p "Do you want to remove NTHUOJ_web?. [y/N]: " CONTINUE; \
	done ; \
	[ $$CONTINUE = "y" ] || [ $$CONTINUE = "Y" ] || (echo "Exiting."; exit 1;)
	rm -rf NTHUOJ_web	

