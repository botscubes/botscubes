#!/bin/sh

# Certificates exist
if [ -d /etc/letsencrypt/live/${DOMAIN} ]; then
  certbot renew --http-01-port=${PORT}

  # Concatenate certificates
  . /scripts/concat-certs.sh
fi