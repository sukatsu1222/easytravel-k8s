# easytravel on Kubernetes

Demo application for Kubernetes. This has been tested on GKE and MicroK8s.

## Deployment

Clone this repo, then to deploy run:

```bash
./deploy-easytravel.sh
```

## Access EasyTravel

2 services, Classic and Angular easytravel, will be exposed as `type: LoadBalancer`.

If you are running MicroK8s run:

Please note for MicroK8S the NGINX addon is required: `microk8s enable ingress`

```bash
./deploy-ingress.sh
```