# Azure-DevOps

## Azure Shell
```
ssh-keygen -t rsa -b 4096

az vm user update \
  --resource-group DOCKER-RG \
  --name docker-vm \
  --username azureuser \
  --ssh-key-value "$(cat ~/.ssh/id_rsa.pub)"

ssh azureuser@<IP Address>
# Copying file from azure shell to VM
scp udemy-webapp.zip azureuser@74.225.159.133:/home/azureuser/

```

## AKS

```
az group list -o table
#Deleting cluster
az group delete --name "aks-rg2" --yes --no-wait
```
