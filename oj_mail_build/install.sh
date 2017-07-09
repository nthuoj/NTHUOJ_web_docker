#!/bin/bash

host="acm.cs.nthu.edu.tw"

# install postfix
apt-get update
echo "postfix postfix/mailname string ${host}" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
apt-get install -y mailutils

# configure postfix with TLS
postconf -e "smtp_tls_security_level = may"
postconf -e "smtp_tls_loglevel = 1"
