#!/bin/bash
# ================================================================
# AKS Cleanup Script
# Purpose: Delete AKS cluster and all related resources
# ================================================================

set -e

RESOURCE_GROUP="aks-rg"

echo "======================================================"
echo " 🧹 Starting Cleanup: Deleting Resource Group $RESOURCE_GROUP"
echo "======================================================"

az group delete --name "$RESOURCE_GROUP" --yes --no-wait

echo "✅ Deletion initiated. Resources will be cleaned up in the background."
echo "======================================================"

