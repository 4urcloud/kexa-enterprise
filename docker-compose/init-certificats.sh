#!/bin/bash
set -x

if ! [ -x "$(command -v openssl)" ]; then
    echo 'Error: openssl is not installed.' >&2
    exit 1
fi

# Load env file
source .env

domains=($DOMAINS)
rsa_key_size=2048
days=650
cert_path="./scripts/nginx-scripts/certs"

# Create directories
mkdir -p "$cert_path"

echo "### Creating self-signed certificate for ${domains[0]} ..."

# Generate self-signed certificate
openssl req -x509 -nodes -days $days -newkey rsa:$rsa_key_size \
    -keyout "$cert_path/nginx.key" \
    -out "$cert_path/nginx.crt" \
    -subj "/CN=${domains[0]}"

echo "### Certificate created successfully!"
echo "Certificate location: $cert_path/nginx.crt"
echo "Private key location: $cert_path/nginx.key"
echo
echo "### Starting Docker Compose..."
docker-compose up -d

echo "### Done!"
