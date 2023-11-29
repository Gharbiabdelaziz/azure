#!/bin/bash

# Variables
region1='eastus'

read -p "Enter resource group1 name: " rg01
read -p "Enter virtual network1 name: " vnetName1

# Create resource group
az group create --name $rg01 --location $region1

# Create virtual network
az network vnet create --resource-group $rg01 --name $vnetName1 --address-prefixes 10.0.0.0/16 --subnet-name subnet01

# Create subnet
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName1 --name green --address-prefixes 10.0.1.0/24
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName1 --name blue --address-prefixes 10.0.2.0/24
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName1 --name jumbox --address-prefixes 10.0.3.0/24
az network vnet subnet create --resource-group $rg01 --vnet-name $vnetName1 --name ApplicationGatewaySubnet --address-prefixes 10.0.4.0/24

# Save credentials to a file (replace <your-username> and <your-password> with your actual values)
export AZURE_USERNAME=someone
export AZURE_PASSWORD=someone%2023 


# Create VM
az vm create --name green --resource-group $rg01 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet green --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD --public-ip-address ""
az vm create --name blue --resource-group $rg01 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet blue --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD   --public-ip-address ""
az vm create --name jumbox --resource-group $rg01 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet jumbox --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD
