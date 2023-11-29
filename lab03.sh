#!/bin/bash

# Variables
region1='eastus'

read -p "Enter resource group1 name: " rg1
read -p "Enter virtual network1 name: " vnetName1
read -p "Enter virtual firewall network1 name: " fwvnet

# Create resource group
az group create --name $rg1 --location $region1

# Create subnet
az network vnet subnet create --resource-group $rg1 --vnet-name $vnetName1 --name subnet01 --address-prefixes 10.0.1.0/24
az network vnet subnet create --resource-group $rg1 --vnet-name $fwvnet --name AzureFirewallSubnet --address-prefixes 10.0.2.0/26

# Create virtual network
az network vnet create --resource-group $rg1 --name $vnetName1 --address-prefixes 10.0.1.0/24 --subnet-name subnet01
az network vnet create --resource-group $rg1 --name $fwvnet --address-prefixes 10.0.2.0/24 --subnet-name AzureFirewallSubnet

# Save credentials to a file (replace <your-username> and <your-password> with your actual values)
export AZURE_USERNAME=someone
export AZURE_PASSWORD=someone%2023 


# Create VM
az vm create --name vm-01 --resource-group $rg1 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet subnet01 --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD
