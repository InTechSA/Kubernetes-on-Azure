# Poc Azure Kubernetes

This repository contains all resource and code relative to the
Kubernetes on Azure Proof of Concept.
The goal is to create a complete platform with infrastructure as code,
and then deploy an application using standard tools.

## Description

The **platform** directory contains all infrastructure as code relative files.
The **applications** directory contains the application used in this PoC.

## How to

### Deploy

1. Deploy the [**platform**](platform/readme.md).
2. Deploy the [**applications**](applications/readme.md)

### Use

1. Go to your Azure web portal
2. Check the load-balanced service exposed on the cluster
3. Check logs into Azure Monitor
