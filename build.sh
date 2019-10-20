#!/usr/bin/env bash

#
# Create server.conf file
#
cat << EOF > server.conf
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn

[dn]
C=US
ST=local
L=local
O=local
OU=local_RootCA
emailAddress=contact@$DOMAIN
CN = $DOMAIN

EOF


#
# Create v3.ext file
#
cat << EOF > v3.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN
DNS.2 = *.$DOMAIN

EOF


#
# Build certificates for the CA
#
openssl genrsa -out server_rootCA.key 2048
openssl req -x509 -new -nodes -key server_rootCA.key -sha256 -days 3650 -out server_rootCA.pem -subj "/C=US/ST=Local/L=Local/O=Local/CN=localhost"


#
# Build certificates for the server
#
openssl req -new -sha256 -nodes -out server.csr -newkey rsa:2048 -keyout server.key -config <( cat server.conf )
openssl x509 -req -in server.csr -CA server_rootCA.pem -CAkey server_rootCA.key -CAcreateserial -out server.crt -days 3650 -sha256 -extfile v3.ext


#
# Build combined PEM file for server
#
cat server.crt server.key > server.pem


#
# Output the certificate details
#
cat server.pem
openssl x509 -text -noout -in server.pem


#
# Copy the final certificate to export
#
mkdir -p /export
cp -rf server.pem /export/server.pem

