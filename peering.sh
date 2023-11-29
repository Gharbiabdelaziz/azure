#!/bin/bash

# Variables
region1='eastus'
region2='westus2'

read -p "Enter resource group1 (rg01) name: " rg01
read -p "Enter resource group2 (rg01) name: " rg02

read -p "Enter virtual network1 name (eus-vnet): " vnetName1
read -p "Enter virtual network1 name (wus-vnet): " vnetName2

# Create resource group
az group create --name $rg01 --location $region1
az group create --name $rg02 --location $region2

# Create virtual network
az network vnet create --resource-group $rg01 --name $vnetName1 --address-prefixes 10.0.0.0/16 --subnet-name eus-subnet
az network vnet create --resource-group $rg02 --name $vnetName2 --address-prefixes 192.168.0.0/16 --subnet-name wus-subnet

# Create subnet
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName1 --name eus-subnet --address-prefixes 10.0.1.0/24
az network vnet subnet create --resource-group $rg02 --vnet-name $vnetName2 --name wus-subnet --address-prefixes 192.168.1.0/24

# Save credentials to a file (replace <your-username> and <your-password> with your actual values)
export AZURE_USERNAME=someone
export AZURE_PASSWORD=someone%2023 


# Create VM
az vm create --name eus-vm --resource-group $rg01 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet eus-subnet --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD --public-ip-address ""
az vm create --name wus-vm --resource-group $rg02 --location $region2 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName2 --subnet wus-subnet --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD
az vm extension set \
  --resource-group $rg02 \
  --vm-name wus-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"script": "apt-get update && apt-get install -y apache2"}'