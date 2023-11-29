```txt
install azure cli cmd from: 
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
```
```sh
source /etc/bash_completion.d/azure-cli 
source ~/.bashrc
```
```sh
az login --use-device-code
```
```txt
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code L5P36ZRDB to authenticate.
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "82c8-82b7-d14645dabefd",
    "id": "4c5f2bee-ac5e-4938-288e4e",
    "isDefault": true,
    "managedByTenants": [],
    "name": "learning",
    "state": "Enabled",
    "tenantId": "82c8bafd14645dabefd",
    "user": {
      "name": "gharbi.aziz2014@gmail.com",
      "type": "user"
    }
  }
]
```
```sh
az account list
```
```txt
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "82c8bafb-d09a-4154-82b7-d14645dabefd",
    "id": "4c5f2bee-ac5e-4938-9935-d38db1288e4e",
    "isDefault": true,
    "managedByTenants": [],
    "name": "learning",
    "state": "Enabled",
    "tenantId": "82c8bafb-d09a-4154-82b7-d14645dabefd",
    "user": {
      "name": "gharbi.aziz2014@gmail.com",
      "type": "user"
    }
  }
]
```