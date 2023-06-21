#!/bin/sh

rm -Rf /etc/letsencrypt/live/${DOMAIN} && \
rm -Rf /etc/letsencrypt/archive/${DOMAIN} && \
rm -Rf /etc/letsencrypt/renewal/${DOMAIN}.conf