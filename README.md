# What is this?
Working usage of Kong Gateway under k8s

# Installation
1. Install Kong into any cluster
```shell script
helm repo add kong https://charts.konghq.com
helm repo update
helm install kong/kong --generate-name --set ingressController.installCRDs=false
```
2. Execute cmd/monolith/deploy.sh and cmd/hello-service/deploy.sh from within script directory (on deploy.sh level)
