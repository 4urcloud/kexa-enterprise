first clone.

create certificates in docker-compose for keycloak ( server.crt ) and ningx (nginx.crt ) or add your certificates.



go in the good directory for keycloak:
in keycloak-scripts/certs directory
run
```console
openssl req -x509 -nodes -days 650 -newkey rsa:2048 -keyout server.key -out server.crt
```

go in the good directory for nginx:
in nginx-scripts/certs directory
run
```console
openssl req -x509 -nodes -days 650 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
```

run 
```console
docker-compose up
```

use the helm to install.
first create the token to download images.
```console
kubectl create secret -n kexa docker-registry kexa-pull-secret --docker-server="https://registry-1.docker.io/v2/" --docker-username="kexa" --docker-password="dcxkxxxlxxxlxxxnS"
```

install the helm kexa
```console
helm upgrade --install kexa kexa/ \
    --namespace kexa \
    --create-namespace \
    --set persistence.enabled=true
```

