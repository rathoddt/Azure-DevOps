#!/bin/bash
# ================================================================
# AKS Demo Cluster Setup Script (Public API + Free Tier)
# Author: Dilip Rathod
# Purpose: Create a cost-efficient AKS cluster and attach ACR
# ================================================================

set -e  # Exit immediately if any command fails

# ------------------ CONFIGURATION ------------------
RESOURCE_GROUP="aks-rg"
LOCATION="centralus"
VNET_NAME="aks-vnet"
SUBNET_NAME="aks-subnet"
CLUSTER_NAME="aks-demo1"
NODEPOOL_NAME="nodepool1"
NODE_SIZE="Standard_D2plds_v6"
MIN_COUNT=2
MAX_COUNT=5
K8S_VERSION="1.33.3"
DNS_PREFIX="aks-demo1-dns"
SERVICE_CIDR="10.0.0.0/16"
DNS_IP="10.0.0.10"
DOCKER_BRIDGE="172.17.0.1/16"
VNET_CIDR="10.224.0.0/16"
ZONES="1 3"
ACR_NAME="dilipregistry"

# ------------------ SCRIPT START ------------------
echo "======================================================"
echo " 🚀 Starting AKS Demo Cluster Setup (Public API)"
echo "======================================================"
echo ""

# Step 0: Detect Public IP
echo "➡️  Detecting your public IP address..."
MY_IP=$(curl -s ifconfig.me)
if [[ -z "$MY_IP" ]]; then
  echo "❌ Could not detect public IP. Please check your internet connection."
  exit 1
fi
echo "✅ Your public IP is: $MY_IP"
echo ""

# Step 1: Create Resource Group
echo "➡️  Creating resource group: $RESOURCE_GROUP in $LOCATION ..."
az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  -o table
echo "✅ Resource group created."
echo ""

# Step 2: Create Virtual Network and Subnet
echo "➡️  Creating virtual network: $VNET_NAME with subnet: $SUBNET_NAME ..."
az network vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_NAME" \
  --address-prefix "$VNET_CIDR" \
  --subnet-name "$SUBNET_NAME" \
  --subnet-prefix "$VNET_CIDR" \
  -o table
echo "✅ Virtual network and subnet created."
echo ""

# Step 3: Get Subnet ID
echo "➡️  Retrieving subnet ID ..."
SUBNET_ID=$(az network vnet subnet show \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$SUBNET_NAME" \
  --query id -o tsv)
echo "✅ Subnet ID retrieved: $SUBNET_ID"
echo ""

# Step 4: Create AKS Cluster with Public Endpoint
echo "➡️  Creating AKS cluster: $CLUSTER_NAME ..."
echo "   Kubernetes version: $K8S_VERSION"
echo "   Node size: $NODE_SIZE"
echo "   Autoscaler: $MIN_COUNT - $MAX_COUNT"
echo "   Authorized IP Range: ${MY_IP}/32"
echo "   This may take 10–15 minutes..."
echo ""

az aks create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$CLUSTER_NAME" \
  --location "$LOCATION" \
  --node-vm-size "$NODE_SIZE" \
  --node-count "$MIN_COUNT" \
  --enable-cluster-autoscaler \
  --min-count "$MIN_COUNT" \
  --max-count "$MAX_COUNT" \
  --zones $ZONES \
  --network-plugin azure \
  --vnet-subnet-id "$SUBNET_ID" \
  --service-cidr "$SERVICE_CIDR" \
  --dns-service-ip "$DNS_IP" \
  --docker-bridge-address "$DOCKER_BRIDGE" \
  --dns-name-prefix "$DNS_PREFIX" \
  --tier free \
  --kubernetes-version "$K8S_VERSION" \
  --nodepool-name "$NODEPOOL_NAME" \
  --enable-managed-identity \
  --generate-ssh-keys \
  --api-server-authorized-ip-ranges ${MY_IP}/32 \
  -o table

echo "✅ AKS cluster created successfully!"
echo ""

# Step 4.1: Attach ACR permissions
echo "➡️  Attaching ACR '$ACR_NAME' to AKS cluster ..."
az aks update -n "$CLUSTER_NAME" -g "$RESOURCE_GROUP" --attach-acr "$ACR_NAME"
echo "✅ ACR successfully attached to AKS cluster."
echo ""

# Step 5: Get Cluster FQDN (Public API Endpoint)
echo "➡️  Retrieving AKS public endpoint FQDN..."
CLUSTER_FQDN=$(az aks show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$CLUSTER_NAME" \
  --query "fqdn" -o tsv)
echo "✅ Cluster Public FQDN: $CLUSTER_FQDN"
echo ""

# Step 6: Get Credentials for kubectl
echo "➡️  Getting kubeconfig credentials..."
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" --overwrite-existing
echo "✅ Credentials added to ~/.kube/config"
echo ""

# Step 7: Verify cluster nodes
echo "➡️  Verifying cluster nodes..."
kubectl get nodes -o wide || echo "⚠️  kubectl not found or not configured yet."
echo ""

# Step 8: Validate ACR image pull
echo "➡️  Testing ACR integration by pulling image from '$ACR_NAME' ..."
kubectl run acr-test --image="$ACR_NAME.azurecr.io/aznginx:latest" --restart=Never || echo "⚠️  Validation failed: Check image name or ACR permissions."
echo ""
echo "✅ If pod starts successfully, ACR integration works fine!"
echo ""

# Step 9: Cleanup hint
echo "------------------------------------------------------"
echo "🧹 To delete all resources later, run:"
echo "az group delete --name $RESOURCE_GROUP --yes --no-wait"
echo "------------------------------------------------------"
echo ""

echo "======================================================"
echo " 🎉 AKS Demo Cluster Setup Complete!"
echo " Cluster Name: $CLUSTER_NAME"
echo " Resource Group: $RESOURCE_GROUP"
echo " Region: $LOCATION"
echo " Public FQDN: $CLUSTER_FQDN"
echo " Accessible from IP: ${MY_IP}/32"
echo " ACR Attached: $ACR_NAME"
echo "======================================================"

