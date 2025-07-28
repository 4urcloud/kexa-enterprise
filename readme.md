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

