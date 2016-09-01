#!/bin/bash

TLS_SETUP_DIR=".tls_setup"
OJ_WEB_BUILD_COPY_DIR="oj_web_build/NTHUOJ_web"
BIT_LENGTH=4096
EXP_DAYS=3650
HOST="NTHUOJ"
CA_KEY=ca-key.pem
CA=ca.pem
SERVER_KEY=server-key.pem
SERVER_CSR=server.csr
SERVER_CERT=server-cert.pem
CLIENT_KEY=key.pem
CLIENT_CSR=client.csr
CLIENT_CERT=cert.pem
USER=$(who -m | awk '{print $1;}')


mkdir -p ${TLS_SETUP_DIR}
cd ${TLS_SETUP_DIR}

# create CA private and public keys
openssl genrsa -out ${CA_KEY} ${BIT_LENGTH}
openssl req -subj "/CN=${HOST}" -new -x509 -days ${EXP_DAYS} -key ${CA_KEY} -sha256 -out ${CA}

# create a server key and certificate signing request (CSR)
openssl genrsa -out ${SERVER_KEY} ${BIT_LENGTH}
openssl req -subj "/CN=${HOST}" -sha256 -new -key ${SERVER_KEY} -out ${SERVER_CSR}

# create server certificate
echo 'subjectAltName = IP:127.0.0.1' > extfile.cnf
openssl x509 -req -days ${EXP_DAYS} -sha256 -in ${SERVER_CSR} -CA ${CA} -CAkey ${CA_KEY} \
  -CAcreateserial -out ${SERVER_CERT} -extfile extfile.cnf

# create a client key and certificate signing request
openssl genrsa -out ${CLIENT_KEY} ${BIT_LENGTH}
openssl req -subj '/CN=client' -new -key ${CLIENT_KEY} -out ${CLIENT_CSR}

# create client certificate
echo 'extendedKeyUsage = clientAuth' > extfile.cnf
openssl x509 -req -days ${EXP_DAYS} -sha256 -in ${CLIENT_CSR} -CA ${CA} -CAkey ${CA_KEY} \
  -CAcreateserial -out ${CLIENT_CERT} -extfile extfile.cnf

# protect keys and certificates by removing write access permission
chmod 0400 ${CA_KEY} ${SERVER_KEY} ${CLIENT_KEY}
chmod 0444 ${CA} ${SERVER_CERT} ${CLIENT_CERT}

# copy client keys and certificates for building image oj_web
mkdir -p ../${OJ_WEB_BUILD_COPY_DIR}/${TLS_SETUP_DIR}
cp ${CA} ${CLIENT_CERT} ${CLIENT_KEY} ../${OJ_WEB_BUILD_COPY_DIR}/${TLS_SETUP_DIR}
chown -R ${USER} ../${OJ_WEB_BUILD_COPY_DIR}/${TLS_SETUP_DIR}

# reserve key and certificates for restarting docker daemon with tls
mkdir -p ~/.docker
cp ${CA} ${CA_KEY} ${SERVER_CERT} ${SERVER_KEY} ${CLIENT_CERT} ${CLIENT_KEY} ~/.docker
chown -R ${USER} ~/.docker/{${CA},${CA_KEY},${SERVER_CERT},${SERVER_KEY},${CLIENT_CERT},${CLIENT_KEY}}

# configure docker daemon default with tls
json="{\"tlsverify\": true, \"tlscacert\": \"${HOME}/.docker/${CA}\", \"tlscert\": \"${HOME}/.docker/${SERVER_CERT}\", \"tlskey\": \"${HOME}/.docker/${SERVER_KEY}\"}"
echo ${json} > /etc/docker/daemon.json

# remove all files in TLS_SETUP_DIR
cd ../
rm -rf ./${TLS_SETUP_DIR}
