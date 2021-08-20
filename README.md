# easytravel on Kubernetes

## Start EasyTravel

```bash
kubectl create namespace easytravel
kubectl apply -f manifest/easytravel-mongodb.yaml
kubectl apply -f manifest/easytravel-backend.yaml
kubectl apply -f manifest/easytravel-frontend.yaml
kubectl apply -f manifest/easytravel-angular-frontend.yaml
kubectl apply -f manifest/easytravel-www.yaml
kubectl apply -f manifest/easytravel-headless-loadgen.yaml
```

## Access EasyTravel

* Access class easytravel: `http://<IP Address of Node>:30080`
* Access angular easytravel: `http://<IP Address of Node>:30081`

