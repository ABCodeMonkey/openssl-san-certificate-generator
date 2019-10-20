# openssl-san-certificate-generator

Generate a self-signed PEM format wildcard certificate for domain, with correct Subject Alternative Name fields, and output it to `/export/server.pem`. ¯\\\_(ツ)\_/¯

## How to Use

### Run using Dockerhub

```
mkdir ./export
docker run -it -e DOMAIN=local.dev -v $(realpath ./export):/export evinowen/openssl-san-certificate-generator:latest
```

### Build and Run Locally

```
mkdir ./export
docker build -t openssl-san-certificate-generator:local .
docker run -it -e DOMAIN=local.dev -v $(realpath ./export):/export openssl-san-certificate-generator:local
```

## Environment Variables

### `DOMAIN`
The domain to generate the certificate for.


