#!/bin/bash

/opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user $KC_BOOTSTRAP_ADMIN_USERNAME --password $KC_BOOTSTRAP_ADMIN_USERNAME

/opt/keycloak/bin/kcadm.sh update realms/master --set sslRequired=NONE
