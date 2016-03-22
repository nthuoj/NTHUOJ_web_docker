all:
	docker build -t oj_web .
	sh docker_start.sh
	docker cp oj_web:/NTHUOJ_web .
	sh docker_stop.sh
clean:
	sh docker_stop.sh
	docker rmi -f oj_web
	rm -rf NTHUOJ_web
