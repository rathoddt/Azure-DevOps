## Compute

```
ssh-keygen -t rsa -b 4096
az vm user update   --resource-group DOCKER-RG   --name docker-vm   --username azureuser   --ssh-key-value "$(cat ~/.ssh/id_rsa.pub)"
ssh azureuser@74.225.159.133
```
