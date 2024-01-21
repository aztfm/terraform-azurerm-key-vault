<!-- markdownlint-disable MD013 -->
# Azure Key Vault - Terraform Module

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![TF Registry](https://img.shields.io/badge/terraform-registry-blueviolet.svg)](https://registry.terraform.io/modules/aztfm/key-vault/azurerm/)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aztfm/terraform-azurerm-key-vault)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/aztfm/terraform-azurerm-key-vault?quickstart=1)

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 1.x.x       | >= 0.13.x         | >= 2.34.0       |

<!-- BEGIN_TF_DOCS -->
## Parameters

The following parameters are supported:

| Name | Description | Type | Default | Required |
| ---- | ----------- | :--: | :-----: | :------: |
|name|Specifies the name of the Key Vault. Changing this forces a new resource to be created.|`string`|n/a|yes|
|resource\_group\_name|The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created.|`string`|n/a|yes|
|location|The location/region where the Key Vault is created.|`string`|n/a|yes|
|tags|A mapping of tags to assign to the resource.|`map(string)`|`{}`|no|
|sku\_name|The Name of the SKU used for this Key Vault. Possible values are standard and premium.|`string`|n/a|yes|
|tenant\_id|The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault.|`string`|n/a|yes|
|soft\_delete\_retention\_days|The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 days.|`number`|`90`|no|
|purge\_protection\_enabled|Is Purge Protection enabled for this Key Vault?|`bool`|`false`|no|
|enabled\_for\_deployment|Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault.|`bool`|`false`|no|
|enabled\_for\_disk\_encryption|Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys.|`bool`|`false`|no|
|enabled\_for\_template\_deployment|Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault.|`bool`|`false`|no|
|enable\_rbac\_authorization|Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions.|`bool`|`false`|no|
|access\_policies|List of objects that represent the configuration of each access policies.|`list(map(string))`|`[]`|no|
|keys|List of objects that represent the configuration of each key.|`list(map(string))`|`[]`|no|
|secrets|List of objects that represent the configuration of each secrect.|`list(map(string))`|`[]`|no|
|contacts|List of objects that represent each contact.|`list(map(string))`|`[]`|no|

The `access_policies` supports the following:

| Name | Description | Type | Default | Required |
| ---- | ------------| :--: | :-----: | :------: |
|object\_id|The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies.|`string`|n/a|yes|
|application\_id|The object ID of an Application in Azure Active Directory.|`string`|`null`|no|
|key\_permissions|List of certificate permissions, must be one or more from the following: `Get`, `List`, `Update`, `Create`, `Import`, `Delete`, `Recover`, `Backup`, `Restore`, `Decrypt`, `Encrypt`, `UnwrapKey`, `WrapKey`, `Verify`, `Sign` and `Purge`.|`string`|`null`|no|
|secret\_permissions|List of key permissions, must be one or more from the following: `Get`, `List`, `Set`, `Delete`, `Recover`, `Backup`, `Restore` and `Purge`.|`string`|`null`|no|
|certificate\_permissions|List of certificate permissions, must be one or more from the following: `Get`, `List`, `Update`, `Create`, `Import`, `Delete`, `Recover`, `Backup`, `Restore`, `GetIssuers`, `SetIssuers`, `ListIssuers`, `DeleteIssuers`, `ManageContacts`, `ManageIssuers` and `Purge`.|`string`|`null`|no|
|storage\_permissions|List of storage permissions, must be one or more from the following: `Get`, `List`, `Update`, `Set`, `Delete`, `Recover`, `Backup`, `Restore`, `GetSAS`, `ListSAS`, `SetSAS`, `DeleteSAS`, `RegenerateKey` and `Purge`.|`string`|`null`|no|

The `keys` supports the following:

| Name | Description | Type | Default | Required |
| ---- | ------------| :--: | :-----: | :------: |
|name|Specifies the name of the Key Vault Key.|`string`|n/a|yes|
|key\_type|Specifies the Key Type to use for this Key Vault Key. Possible values are `EC` (Elliptic Curve), `EC-HSM`, `Oct` (Octet), `RSA` and `RSA-HSM`.|`string`|n/a|yes|
|key\_size|Specifies the Size of the RSA key to create in bytes. For example, 1024 or 2048. Note: This field is required if `key_type` is `RSA` or `RSA-HSM`.|`string`|`null`|no|
|curve|Specifies the curve to use when creating an `EC` key. Possible values are: `P-256`, `P-384`, `P-521` and `SECP256K1`.|`string`|`null`|no|
|key\_opts|A list of JSON web key operations. Possible values include: `decrypt`, `encrypt`, `sign`, `unwrapKey`, `verify` and `wrapKey`.|`string`|`null`|yes|
|not\_before\_date|Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').|`string`|`null`|no|
|expiration\_date|Expiration UTC datetime (Y-m-d'T'H:M:S'Z').|`string`|`null`|no|

The `secrets` supports the following:

| Name | Description | Type | Default | Required |
| ---- | ------------| :--: | :-----: | :------: |
|name|Specifies the name of the Key Vault Secret.|`string`|n/a|yes|
|value|Specifies the value of the Key Vault Secret.|`string`|`null`|yes|
|content\_type|Specifies the content type for the Key Vault Secret.|`string`|`null`|no|
|not\_before\_date|Key not usable before the provided UTC datetime (Y-m-d'T'H:M:S'Z').|`string`|`null`|no|
|expiration\_date|Expiration UTC datetime (Y-m-d'T'H:M:S'Z').|`string`|`null`|yes|

The `contacts` supports the following:

| Name | Description | Type | Default | Required |
| ---- | ------------| :--: | :-----: | :------: |
|email|E-mail address of the contact.|`string`|n/a|yes|
|name|Name of the contact.|`string`|`null`|no|
|phone|Phone number of the contact.|`string`|`null`|no|

## Outputs

The following outputs are exported:

| Name | Description | Sensitive |
| ---- | ------------| :-------: |
|id|The virtual network configuration ID.|no|
|name|The name of the virtual network.|no|
|resource_group_name|The name of the resource group in which to create the virtual network.|no|
|location|The location/region where the virtual network is created.|no|
|tags|The tags assigned to the resource.|no|
|access_policies|Blocks containing configuration of each access policy.|no|
|keys|Blocks containing configuration of each key.|no|
|secrets|Blocks containing configuration of each secret.|no|
|contacts|Blocks containing each contact.|no|
<!-- END_TF_DOCS -->
