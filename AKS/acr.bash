# Variables
ACR_NAME="dilipregistry"    # must be globally unique
RESOURCE_GROUP="docker-rg"
LOCATION="centralindia"

# Create the registry
az acr create \
  --resource-group $RESOURCE_GROUP \
  --name $ACR_NAME \
  --sku Basic \
  --location $LOCATION \
  --admin-enabled true \
  -o table

