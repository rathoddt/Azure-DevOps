# Azure Kubernetes Services

```
kubectl run nginx-test --image=nginx

az provider register --namespace Microsoft.ContainerRegistry
az provider show -n Microsoft.ContainerRegistry

kubectl apply -f 01-pod-definition.yaml --validate=false

```

#### Creating MYSQL server
az command
```
az mysql flexible-server create \
  --name mysql-db-001dilip \
  --resource-group aks-rg1 \
  --location westus2 \
  --admin-user dilipadmin \
  --admin-password 'YourStrongPassword123!' \
  --tier Burstable \
  --sku-name Standard_B1ms \
  --storage-size 32 \
  --version 8.0

```
## Refrences
- https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/

- Azure AKS Kubernetes - Masterclass | Azure DevOps, Terraform: https://github.com/stacksimplify/azure-aks-kubernetes-masterclass

- Azure DevOps for Kubernetes Workloads running on Azure AKS Cluster: https://github.com/stacksimplify/azure-devops-github-acr-aks-app1

- Provision Azure AKS Cluster using Terraform and Azure DevOps: https://github.com/stacksimplify/azure-devops-aks-kubernetes-terraform-pipeline

- Docker Fundamentals: https://github.com/stacksimplify/docker-fundamentals

- Presentation with 250 Slides outlining the various architectures and designs we are going to do in this course: https://github.com/stacksimplify/azure-aks-kubernetes-masterclass/tree/master/ppt-presentation
