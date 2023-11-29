#!/bin/bash

# Variables
region1='eastus'
region2='westus2'

read -p "Enter resource group1 name: " rg1
read -p "Enter resource group2 name: " rg2
read -p "Enter virtual network1 name: " vnetName1
read -p "Enter virtual network2 name: " vnetName2
# Create resource group
az group create --name $rg1 --location $region1
az group create --name $rg2 --location $region2

# Create subnet
az network vnet subnet create --resource-group $rg1 --vnet-name $vnetName1 --name subnet01 --address-prefixes 10.0.1.0/26
az network vnet subnet create --resource-group $rg2 --vnet-name $vnetName2 --name subnet02 --address-prefixes 10.0.2.0/26

# Create virtual network
az network vnet create --resource-group $rg1 --name $vnetName1 --address-prefixes 10.0.1.0/24 --subnet-name subnet01
az network vnet create --resource-group $rg2 --name $vnetName2 --address-prefixes 10.0.2.0/24 --subnet-name subnet02

# Save credentials to a file (replace <your-username> and <your-password> with your actual values)
export AZURE_USERNAME=someone
export AZURE_PASSWORD=someone%2023 
#echo "export AZURE_USERNAME="someone"" > credentials.sh
#echo "export AZURE_PASSWORD="someone%2016"" >> credentials.sh
# Source the credential file to make the variables available in the current shell session
#Source credentials.sh

# Create VM
az vm create --name vm-01 --resource-group $rg1 --location $region1 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName1 --subnet subnet01 --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD
az vm create --name vm-02 --resource-group $rg2 --location $region2 --size Standard_B1s --image Ubuntu2204 --vnet-name $vnetName2 --subnet subnet02 --admin-username $AZURE_USERNAME --admin-password $AZURE_PASSWORD
