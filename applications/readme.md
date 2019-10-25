# Applications

This folder contains the source code the 2 applications used in this PoC.
It also contains a special **chart** folder containing helm chart to deploy the applications.

## How to deploy

1. Connect your kubectl to the Azure [kubernetes](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster).
2. Install and configure [Helm](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm) on your cluster.

Then,

1. Build and Push `backend` image to [container registry](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-acr).
2. edits "values.poc.yml" in `backend`
    * Don't forget to set image repository according to the previous step.
3. deploy with `helm install -f backend/values.poc.yml ./chart`


## Command example

```shell script
az acr login --name $(terraform output --state=../platform/terraform.tfstate container_registry_name)
REGISTRY_URL=$(terraform output --state=../platform/terraform.tfstate container_registry_url)
cd backend
docker build -t $REGISTRY_URL/backend:v1 .
docker push $REGISTRY_URL/backend:v1
# Edit values.poc.yml to set tag=v1
helm install -f values.poc.yaml ../public-app --name="backend-poc"
```