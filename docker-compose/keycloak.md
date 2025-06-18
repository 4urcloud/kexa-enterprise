# Keycloak - Disable SSL

Connect to keycloak container

```bash
docker exec -it kexa-enterprise-keycloak-1 /bin/bash
```

Disable SSL with the script

```bash
/tmp/keycloak-script.sh
```

You can now access keycloak at <http://localhost:8080>.
