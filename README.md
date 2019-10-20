# openssl-san-certificate-generator

Generate a self-signed PEM format wildcard certificate for domain, and output it to `/build/export/server.pem`. ¯\_(ツ)_/¯`

```
mkdir ./export
docker build -t openssl-san-certificate-generator:local .
docker run -it -e DOMAIN=local.dev -v $(realpath ./export):/build/export openssl-san-certificate-generator:local
```

### `DOMAIN`
The domain to generate the certificate for.

