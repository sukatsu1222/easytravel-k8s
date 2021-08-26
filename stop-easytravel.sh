#!/usr/bin/env bash

MANIFESTS_DIR=$(cd $(dirname $0) && pwd)/manifests

if type microk8s > /dev/null 2>&1; then
    COMMAND="microk8s kubectl"
elif type kubectl > /dev/null 2>&1; then
    COMMAND="kubectl"
else
    echo "Not found kubectl or microk8s command!"
    exit 1
fi

${COMMAND} delete -f ${MANIFESTS_DIR}/loadgen/
${COMMAND} delete -f ${MANIFESTS_DIR}/frontend/
${COMMAND} delete -f ${MANIFESTS_DIR}/backend/
${COMMAND} delete -f ${MANIFESTS_DIR}/easytravel-namespace.yaml
