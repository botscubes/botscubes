#!/bin/sh

rsa_key_size=4096
email=${EMAIL} # Adding a valid address is strongly recommended
staging=${DEV_MODE} # Set to 1 if you're testing your setup to avoid hitting request limits

#Join $domains to -d args
domain_args=""
domain_args="$domain_args -d ${DOMAIN}"
domain_args="$domain_args -d www.${DOMAIN}"

# Select appropriate email arg
case "$email" in
  "") email_arg="--register-unsafely-without-email" ;;
  *) email_arg="--email $email" ;;
esac

# Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi

echo "Creating certs"
# Create certificate
certbot certonly --standalone \
    $staging_arg \
    $email_arg \
    $domain_args \
    --agree-tos \
    --non-interactive \
    --force-renewal \
    --break-my-certs \
    --http-01-port=${PORT}

# Concatenate certificates
. /scripts/concat-certs.sh