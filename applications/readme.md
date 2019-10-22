# Applications

This folder contains the source code the 2 applications used in this PoC.
It also contains a special **chart** folder containing helm chart to deploy the applications.

## How to deploy

1. Connect your kubectl to the Azure [kubernetes](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster).
2. Install and configure [Helm](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm) on your cluster.

Then for each application

1. Build and Push image to [container registry](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-acr).
2. edits "values.poc.yml"
    * Don't forget to set image repository according to the previous step.
3. deploy with `helm install -f <APPLICATION_FOLDER>/values.poc.yml ./chart`
