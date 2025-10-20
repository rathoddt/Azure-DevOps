#!/bin/bash
set -e

# ============================
# CONFIGURATION
# ============================
RESOURCE_GROUP="docker-rg"
VM_NAME="docker-vm"
LOCATION="centralindia"
ADMIN_USER="azureuser"
IMAGE="Ubuntu2204"
VM_SIZE="Standard_D2as_v5"
PUBLIC_IP_SKU="Standard"
NSG_NAME="${VM_NAME}NSG"

# ============================
# STEP 1: CREATE RESOURCE GROUP
# ============================
echo "➡️  Creating resource group: $RESOURCE_GROUP in $LOCATION ..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  -o table
echo "✅ Resource group created."
echo ""

# ============================
# STEP 2: CREATE VM (no NSG rule yet)
# ============================
echo "➡️  Creating VM: $VM_NAME ..."
az vm create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --image "$IMAGE" \
  --size "$VM_SIZE" \
  --admin-username "$ADMIN_USER" \
  --authentication-type ssh \
  --generate-ssh-keys \
  --public-ip-sku "$PUBLIC_IP_SKU" \
  --location "$LOCATION" \
  --nsg-rule NONE \
  --output table
echo "✅ VM created successfully."
echo ""

# ============================
# STEP 3: ADD SSH RULE (from your current IP)
# ============================
echo "➡️  Detecting your public IP ..."
MY_IP=$(curl -s ifconfig.me)
echo "Your public IP is: $MY_IP"

echo "➡️  Adding SSH rule to allow access only from your IP ..."
az network nsg rule create \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$NSG_NAME" \
  --name AllowSSH \
  --priority 1000 \
  --destination-port-ranges 22 \
  --access Allow \
  --protocol Tcp \
  --direction Inbound \
  --source-address-prefixes "$MY_IP" \
  --description "Allow SSH from $MY_IP" \
  -o table
echo "✅ SSH rule added."
echo ""

# ============================
# STEP 4: VERIFY NSG RULE
# ============================
echo "➡️  Verifying NSG rules ..."
az network nsg rule list \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$NSG_NAME" \
  -o table
echo "✅ NSG verification complete."
echo ""

# ============================
# STEP 5: DISPLAY CONNECTION INFO
# ============================
VM_IP=$(az vm show -d -g "$RESOURCE_GROUP" -n "$VM_NAME" --query publicIps -o tsv)
echo "✅ VM is ready!"
echo "--------------------------------------------"
echo "SSH command to connect:"
echo "az ssh vm --resource-group $RESOURCE_GROUP --name $VM_NAME"
echo ""
echo "or standard SSH:"
echo "ssh $ADMIN_USER@$VM_IP"
echo "--------------------------------------------"

