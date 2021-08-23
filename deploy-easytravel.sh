#!/usr/bin/env bash

MANIFESTS_DIR=$(cd $(dirname $0) && pwd)/manifests

kubectl apply -f ${MANIFESTS_DIR}/easytravel-namespace.yaml
kubectl apply -f ${MANIFESTS_DIR}/backend/
kubectl apply -f ${MANIFESTS_DIR}/frontend/
kubectl apply -f ${MANIFESTS_DIR}/loadgen/