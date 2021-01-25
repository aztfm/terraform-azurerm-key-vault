# Azure Key Vault - Terraform Module
![Testing module](https://github.com/aztfm/terraform-azurerm-key-vault/workflows/Testing%20module/badge.svg?branch=main)
[![TF Registry](https://img.shields.io/badge/terraform-registry-blueviolet.svg)](https://registry.terraform.io/modules/aztfm/key-vault/azurerm/)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aztfm/terraform-azurerm-key-vault)

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 1.x.x       | >= 0.13.x         | >= 2.34.0       |

## Parameters

The following parameters are supported:

| Name                              | Description                                                                                                                         |        Type         | Default | Required |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | :-----------------: | :-----: | :------: |
| name                              | The name of the Application Gateway.                                                                                                |      `string`       |   n/a   |   yes    |
| resource\_group\_name             | The name of the resource group in which to create the Application Gateway.                                                          |      `string`       |   n/a   |   yes    |
| location                          | The location/region where the Application Gateway is created.                                                                       |      `string`       |   n/a   |   yes    |
| sku\_name                         | The Name of the SKU used for this Key Vault. Possible values are standard and premium.                                              |      `string`       |   n/a   |   yes    |
| tenant\_id                        | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.                              |      `string`       |   n/a   |   yes    |
| soft\_delete\_retention\_days     | The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 days.                    |      `number`       |  `90`   |    no    |
| purge\_protection\_enabled        | Is Purge Protection enabled for this Key Vault?                                                                                     |       `bool`        | `false` |    no    |
| enabled\_for\_deployment          | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. |       `bool`        | `false` |    no    |
| enabled\_for\_disk_encryption     | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.              |       `bool`        | `false` |    no    |
| enabled\_for\_template_deployment | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.                         |       `bool`        | `false` |    no    |
| enable\_rbac\_authorization       | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions.            |       `bool`        | `false` |    no    |
| access\_policies                  | List of objects that represent the configuration of each access policies.                                                           | `list(map(string))` |  `[]`   |    no    |
| contacts                          | List of objects that represent each contact.                                                                                        | `list(map(string))` |  `[]`   |    no    |
| tags                              | A mapping of tags to assign to the resource.                                                                                        |    `map(string)`    |  `{}`   |    no    |

##
The `access_policies` supports the following:

| Name                     | Description                                                                                                                                                                                                                                                                |   Type   | Default | Required |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: | :-----: | :------: |
| object\_id               | The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.                                                                                             | `string` |   n/a   |   yes    |
| application\_id          | The object ID of an Application in Azure Active Directory.                                                                                                                                                                                                                 | `string` | `null`  |    no    |
| key\_permissions         | List of certificate permissions, must be one or more from the following: `backup`, `create`, `delete`, `deleteissuers`, `get`, `getissuers`, `import`, `list`, `listissuers`, `managecontacts`, `manageissuers`, `purge`, `recover`, `restore`, `setissuers` and `update`. | `string` | `null`  |    no    |
| secret\_permissions      | List of key permissions, must be one or more from the following: `backup`, `create`, `decrypt`, `delete`, `encrypt`, `get`, `import`, `list`, `purge`, `recover`, `restore`, `sign`, `unwrapKey`, `update`, `verify` and `wrapKey`.                                        | `string` | `null`  |    no    |
| certificate\_permissions | List of secret permissions, must be one or more from the following: `backup`, `delete`, `get`, `list`, `purge`, `recover`, `restore` and `set`.                                                                                                                            | `string` | `null`  |    no    |
| storage\_permissions     | List of storage permissions, must be one or more from the following: `backup`, `delete`, `deletesas`, `get`, `getsas`, `list`, `listsas`, `purge`, `recover`, `regeneratekey`, `restore`, `set`, `setsas` and `update`.                                                    | `string` | `null`  |    no    |

##
The `contacts` supports the following:

| Name  | Description                    |   Type   | Default | Required |
| ----- | ------------------------------ | :------: | :-----: | :------: |
| email | E-mail address of the contact. | `string` |   n/a   |   yes    |
| name  | Name of the contact.           | `string` | `null`  |    no    |
| phone | Phone number of the contact.   | `string` | `null`  |    no    |