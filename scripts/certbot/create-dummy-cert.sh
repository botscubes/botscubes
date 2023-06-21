#!/bin/sh

rsa_key_size=4096
path="/etc/letsencrypt/live/${DOMAIN}"
mkdir -p $path

openssl req -x509 -nodes -newkey rsa:$rsa_key_size -days 1\
  -keyout $path/privkey.pem \
  -out $path/fullchain.pem \
  -subj '/CN=localhost'

. /scripts/concat-certs.sh