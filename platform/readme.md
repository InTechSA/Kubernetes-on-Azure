# Platform

This folder contains all **terraform** related files

## How to deploy

1. Ensure that you have setup your azure account
    * Follow the azure CLI [installation guide](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) for that
2. `terraform init`
3. `terraform deploy`
4. Install [Helm](https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm)
    * This PoC does **not** setup include SSL/TLS configuration