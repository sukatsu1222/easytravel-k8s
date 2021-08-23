# easytravel on Kubernetes

Demo application for Kubernetes. This has been tested on GKE.

## Deployment

Clone this repo, then to deploy run:

```bash
./deploy-easytravel.sh
```

## Access EasyTravel

2 services, Classic and Angular easytravel, will be exposed as `type: LoadBalancer`.