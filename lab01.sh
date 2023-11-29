#!/bin/bash

# Variables
region='eastus'

read -p "Enter resource group name: " rg
read -p "Enter virtual network name: " vnetName
read -p "Enter a unique name for storage account: " storage
storageAccountName="${storage}fxstore"

# Create resource group
az group create --name $rg --location $region

# Create subnet
az network vnet subnet create --resource-group $rg --vnet-name $vnetName --name subnet01 --address-prefixes 192.168.0.0/24

# Create virtual network
az network vnet create --resource-group $rg --name $vnetName --address-prefixes 192.168.0.0/16 --subnet-name subnet01

# Save credentials to a file (replace <your-username> and <your-password> with your actual values)
export AZURE_USERNAME=someone
export AZURE_PASSWORD=someone%2016 
#echo "export AZURE_USERNAME="someone"" > credentials.sh
#echo "export AZURE_PASSWORD="someone%2016"" >> credentials.sh
# Source the credential file to make the variables available in the current shell session
#Source credentials.sh

# Create VM
az vm create --name vm-01 --resource-group $rg --location $region --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName --subnet subnet01 --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD

# Create storage account
az storage account create --resource-group $rg --name $storageAccountName --location $region --sku Standard_LRS --kind StorageV2

# Clean up: Remove the credential file after using it
# credentials.sh
