first clone.

create certificates in docker-compose for keycloak ( server.crt ) and ningx (nginx.crt ) or add your certificates.

or use your own certificates.

Run to create self-signed certificates.


```console
openssl req -x509 -nodes -days 650 -newkey rsa:2048 -keyout keycloak-scripts/certs/server.key -out keycloak-scripts/certs/server.crt
```

Run to create self-signed certificates.

```console
openssl req -x509 -nodes -days 650 -newkey rsa:2048 -keyout nginx-scripts/certs/nginx.key -out nginx-scripts/certs/nginx.crt
```
Don't forget to create the .env file in the docker-compose folder.

run
```console
cp .env-sample .env
```

correct the .env file with your values.

run 
```console
docker-compose up -d
```

For kubernetes you cab use the helm to install.

install the helm kexa
```console
helm upgrade --install kexa kexa/ \
    --namespace kexa \
    --create-namespace \
    --set persistence.enabled=true
```

