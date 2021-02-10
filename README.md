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

 The `access_policies` supports the following:

| Name                     | Description                                                                                                                                                                                                                                                                |   Type   | Default | Required |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: | :-----: | :------: |
| object\_id               | The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.                                                                                             | `string` |   n/a   |   yes    |
| application\_id          | The object ID of an Application in Azure Active Directory.                                                                                                                                                                                                                 | `string` | `null`  |    no    |
| key\_permissions         | List of certificate permissions, must be one or more from the following: `backup`, `create`, `delete`, `deleteissuers`, `get`, `getissuers`, `import`, `list`, `listissuers`, `managecontacts`, `manageissuers`, `purge`, `recover`, `restore`, `setissuers` and `update`. | `string` | `null`  |    no    |
| secret\_permissions      | List of key permissions, must be one or more from the following: `backup`, `create`, `decrypt`, `delete`, `encrypt`, `get`, `import`, `list`, `purge`, `recover`, `restore`, `sign`, `unwrapKey`, `update`, `verify` and `wrapKey`.                                        | `string` | `null`  |    no    |
| certificate\_permissions | List of secret permissions, must be one or more from the following: `backup`, `delete`, `get`, `list`, `purge`, `recover`, `restore` and `set`.                                                                                                                            | `string` | `null`  |    no    |
| storage\_permissions     | List of storage permissions, must be one or more from the following: `backup`, `delete`, `deletesas`, `get`, `getsas`, `list`, `listsas`, `purge`, `recover`, `regeneratekey`, `restore`, `set`, `setsas` and `update`.                                                    | `string` | `null`  |    no    |

The `keys` supports the following:

| Name              | Description                                                                                                                                        |   Type   | Default | Required |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | :------: | :-----: | :------: |
| name              | Specifies the name of the Key Vault Key.                                                                                                           | `string` |   n/a   |   yes    |
| key\_type         | Specifies the Key Type to use for this Key Vault Key. Possible values are `EC` (Elliptic Curve), `EC-HSM`, `Oct` (Octet), `RSA` and `RSA-HSM`.     | `string` |   n/a   |   yes    |
| key\_size         | Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if `key_type` is `RSA` or `RSA-HSM`. | `string` | `null`  |    no    |
| curve             | Specifies the curve to use when creating an `EC` key. Possible values are `P-256`, `P-384`, `P-521`, and `SECP256K1`.                              | `string` | `null`  |    no    |
| key\_opts         | A list of JSON web key operations. Possible values include: `decrypt`, `encrypt`, `sign`, `unwrapKey`, `verify` and `wrapKey`.                     | `string` | `null`  |    no    |
| not\_before\_date | Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').                                                                                | `string` | `null`  |    no    |
| expiration\_date  | Expiration UTC datetime (Y-m-d'T'H:M:S'Z').                                                                                                        | `string` | `null`  |    no    |

The `secrets` supports the following:

| Name              | Description |   Type   | Default | Required |
| ----------------- | ----------- | :------: | :-----: | :------: |
| name              |             | `string` |   n/a   |   yes    |
| value             |             | `string` | `null`  |    no    |
| content\_type     |             | `string` | `null`  |    no    |
| not\_before\_date |             | `string` | `null`  |    no    |
| expiration\_date  |             | `string` | `null`  |    no    |

The `contacts` supports the following:

| Name  | Description                    |   Type   | Default | Required |
| ----- | ------------------------------ | :------: | :-----: | :------: |
| email | E-mail address of the contact. | `string` |   n/a   |   yes    |
| name  | Name of the contact.           | `string` | `null`  |    no    |
| phone | Phone number of the contact.   | `string` | `null`  |    no    |

## Outputs

The following outputs are exported:

| Name                  | Description                                                        |
| --------------------- | ------------------------------------------------------------------ |
| id                    | The route table configuration ID.                                  |
| name                  | The name of the route table.                                       |
| resource\_group\_name | The name of the resource group in which to create the route table. |
| location              | The location/region where the route table is created.              |
| access\_policies      | Blocks containing configuration of each access policy.             |
| keys                  | Blocks containing configuration of each key.                       |
| secrets               | Blocks containing configuration of each secret.                    |
| contacts              | Blocks containing each contact.                                    |
| tags                  | The tags assigned to the resource.                                 |
