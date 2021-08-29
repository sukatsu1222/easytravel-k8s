#!/usr/bin/env bash

CREATE_PRIVATE=${CREATE_PRIVATE:-true}
if [ ${CREATE_PRIVATE} = "true" ]; then
  PRIVATE_IP=${PRIVATE_IP:-$(hostname -i)}
  PRIVATE_DOMAIN="$(echo $PRIVATE_IP | sed 's#\.#-#g').nip.io"
fi

CREATE_PUBLIC=${CREATE_PUBLIC:-true}
if [ ${CREATE_PUBLIC} = "true" ]; then
  PUBLIC_IP=$(curl -s ifconfig.me)
  PUBLIC_DOMAIN="$(echo $PUBLIC_IP | sed 's#\.#-#g').nip.io"
fi

createPrivateAndPublicIngress() {
  COMMAND="$1"
  PRIVATE_DOMAIN="$2"
  PUBLIC_DOMAIN="$3"
  ${COMMAND} apply -f - <<-EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: easytravel-www
  namespace: easytravel
spec:
  rules:
  - host: classic.${PRIVATE_DOMAIN}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: easytravel-www
            port:
              number: 80
  - host: classic.${PUBLIC_DOMAIN}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: easytravel-www
            port:
              number: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: easytravel-angular-frontend
  namespace: easytravel
spec:
  rules:
  - host: angular.${PRIVATE_DOMAIN}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: easytravel-angular-frontend
            port:
              number: 80
  - host: angular.${PUBLIC_DOMAIN}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: easytravel-angular-frontend
            port:
              number: 80
EOF
}

createIngress() {
  COMMAND="$1"
  DOMAIN="$2"
  ${COMMAND} apply -f - <<-EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: easytravel-www
  namespace: easytravel
spec:
  rules:
  - host: classic.${DOMAIN}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: easytravel-www
            port:
              number: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: easytravel-angular-frontend
  namespace: easytravel
spec:
  rules:
  - host: angular.${DOMAIN}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: easytravel-angular-frontend
            port:
              number: 80
EOF
}

if type microk8s > /dev/null 2>&1; then
    COMMAND="microk8s kubectl"
elif type kubectl > /dev/null 2>&1; then
    COMMAND="kubectl"
else
    echo "Not found kubectl or microk8s command!"
    exit 1
fi

if [ ${CREATE_PRIVATE} = "true" ] && [ ${CREATE_PUBLIC} = "true" ]; then
  createPrivateAndPublicIngress "${COMMAND}" "${PRIVATE_DOMAIN}" "${PUBLIC_DOMAIN}"
elif [ ${CREATE_PRIVATE} = "true" ]; then
  createIngress "${COMMAND}" "${PRIVATE_DOMAIN}"
elif [ ${CREATE_PUBLIC} = "true" ]; then
  createIngress "${COMMAND}" "${PUBLIC_DOMAIN}"
fi

if [ ${CREATE_PRIVATE} = "true" ]; then
  echo "easytravel classic (Private Address): http://classic.${PRIVATE_DOMAIN}"
  echo "easytravel angular (Private Address): http://angular.${PRIVATE_DOMAIN}"
fi

if [ ${CREATE_PUBLIC} = "true" ]; then
  echo "easytravel classic (Public Address): http://classic.${PUBLIC_DOMAIN}"
  echo "easytravel angular (Public Address): http://angular.${PUBLIC_DOMAIN}"
fi
