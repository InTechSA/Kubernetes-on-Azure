# Poc Azure Kubernetes

This repository contains all resource and code relative to the
Kubernetes on Azure Proof of Concept.
The goal is to create a complete plateform with infrastructure as code,
and then deploy an application using azure API.

## Description

The **platform** directory contains all infrastructure as code relative files.
The **applications** directory contains the two applications used in this PoC.

## How to

### Deploy

1. Deploy the [**platform**](platform/readme.md).
2. Deploy the [**applications**](applications/readme.md)

### Use

1. Go to your Azure web portal
2. Go to the **Event Grid** service page
3. Check the **kubernetes-poc** queue and message pushed to it.
