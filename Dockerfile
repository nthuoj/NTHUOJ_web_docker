FROM debian:jessie

COPY apt/sources.list /etc/apt
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git python-mysqldb mysql-client libmysqlclient-dev python-pip python-dev libjpeg-dev dos2unix npm nodejs nodejs-legacy nginx uwsgi vim && \
apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN npm install -g bower

RUN git clone https://github.com/nthuoj/NTHUOJ_web.git && cd NTHUOJ_web && git checkout dev

COPY NTHUOJ_Docker_build /NTHUOJ_web/

#https://github.com/bower/bower/issues/1752
RUN echo '{ "allow_root": true }' > /root/.bowerrc

RUN pip install -r /NTHUOJ_web/requirements.txt
RUN cd NTHUOJ_web && python install.py && python manage.py collectstatic --noinput
RUN ln -s /NTHUOJ_web/NTHUOJ_web_nginx.conf /etc/nginx/sites-enabled/

EXPOSE 8000

WORKDIR /NTHUOJ_web
VOLUME ["/var/nthuoj/","/NTHUOJ_web/media"]

CMD ["sh", "start.sh"]

