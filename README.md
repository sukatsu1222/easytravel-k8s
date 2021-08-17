# easytravel on Kubernetes

## Start EasyTravel

```bash
kubectl create namespace easytravel
kubectl apply -f manifest/easytravel-mongodb.yaml
kubectl apply -f manifest/easytravel-backend.yaml
kubectl apply -f manifest/easytravel-frontend.yaml
kubectl apply -f manifest/easytravel-www.yaml
```

## Access EasyTravel

Access `http://<IP Address of Node>:30080`
