#!/bin/bash
rsa_key_size=4096
data_path="./data/certbot"

if [ -d "$data_path" ]; then
  read -p "Existing data found domains. Continue and replace existing certificate? (y/N) " decision
  if [ "$decision" != "Y" ] && [ "$decision" != "y" ]; then
    exit
  fi
fi

echo "### Start certbot"
docker compose up --force-recreate -d certbot
echo

echo "### Create dummy certificate"
docker compose exec certbot /bin/sh -c "/scripts/create-dummy-cert.sh"
echo

echo "### Starting haproxy ..."
docker compose up --force-recreate -d haproxy
echo

echo "### Delete dummy certificate"
docker compose exec certbot /bin/sh -c "/scripts/delete-dummy-cert.sh"
echo

echo "### Create certificate"
docker compose exec certbot /bin/sh -c "/scripts/create-cert.sh"
echo

echo "### Reloading haproxy..."
docker compose exec haproxy kill -SIGUSR2 1
