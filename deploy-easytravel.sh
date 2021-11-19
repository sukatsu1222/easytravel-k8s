#!/usr/bin/env bash

DEPLOY_LOADGEN=${DEPLOY_LOADGEN:-true}

MANIFESTS_DIR=$(cd $(dirname $0) && pwd)/manifests

if type microk8s > /dev/null 2>&1; then
    COMMAND="microk8s kubectl"
elif type kubectl > /dev/null 2>&1; then
    COMMAND="kubectl"
else
    echo "Not found kubectl or microk8s command!"
    exit 1
fi

${COMMAND} apply -f ${MANIFESTS_DIR}/easytravel-namespace.yaml
${COMMAND} apply -f ${MANIFESTS_DIR}/backend/
${COMMAND} apply -f ${MANIFESTS_DIR}/frontend/

if [[ "$DEPLOY_LOADGEN" == "true" ]]; then
    ${COMMAND} apply -f ${MANIFESTS_DIR}/loadgen/
fi
