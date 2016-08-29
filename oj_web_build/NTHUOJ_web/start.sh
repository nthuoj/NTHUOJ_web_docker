#/bin/bash
service nginx restart
uwsgi --ini NTHUOJ_web_uwsgi.ini
