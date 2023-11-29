#!/bin/bash

# Variables
region1='eastus'

read -p "Enter resource group1 (rg01) name: " rg01

read -p "Enter virtual network1 name (spoke01): " vnetName1
read -p "Enter virtual network1 name (spoke02): " vnetName2
read -p "Enter virtual network name (hub): " vnetName3

# Create resource group
az group create --name $rg01 --location $region1

# Create virtual network
az network vnet create --resource-group $rg01 --name $vnetName1 --address-prefixes 10.0.0.0/16 --subnet-name spoke01-subnet
az network vnet create --resource-group $rg01 --name $vnetName2 --address-prefixes 192.168.0.0/16 --subnet-name spoke02-subnet
az network vnet create --resource-group $rg01 --name $vnetName3 --address-prefixes 172.16.0.0/16 --subnet-name GatewaySubnet

# Create subnet
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName1 --name spoke01-subnet --address-prefixes 10.0.1.0/24
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName2 --name spoke02-subnet --address-prefixes 192.168.1.0/24
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName3 --name GatewaySubnet --address-prefixes 172.16.1.0/24

# Save credentials to a file (replace <your-username> and <your-password> with your actual values)
export AZURE_USERNAME=someone
export AZURE_PASSWORD=someone%2023 


# Create VM
az vm create --name spoke01-vm --resource-group $rg01 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet spoke01-subnet --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD --public-ip-address ""
az vm create --name spoke02-vm --resource-group $rg01 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName2 --subnet spoke02-subnet --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD --public-ip-address ""

script=$(echo "apt-get update && apt-get install -y apache2" | base64 -w0)

az vm extension set \
  --resource-group $rg01 \
  --vm-name spoke02-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"script": "'$script'"}' 