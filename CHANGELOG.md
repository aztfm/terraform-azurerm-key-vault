## 3.0.0 (Unreleased)

FEATURES:

* **New Parameter:** `public_network_access_enabled`

## 2.0.0 (March 03, 2024)

BREAKING CHANGES:

* dependencies: updating to `v1.3.0` minimum of `terraform`
* dependencies: updating to `v3.69.0` minimum of `hashicorp/azurerm` provider.
* The internal name by which the `azurerm_key_vault` resource is defined was defined as `vault`. This has been changed by `kv` to maintain the internal consistency of the module, so the resources deployed in the previous version of the module are not compatible with this new version.
* The internal name by which the `azurerm_key_vault_key` resource is defined was defined as `vault`. This has been changed by `keys` to maintain the internal consistency of the module, so the resources deployed in the previous version of the module are not compatible with this new version.
* The internal name by which the `azurerm_key_vault_secret` resource is defined was defined as `vault`. This has been changed by `secrets` to maintain the internal consistency of the module, so the resources deployed in the previous version of the module are not compatible with this new version.

ENHANCEMENTS:

* Internal changes that do not modify the operation of the module.
* Internal changes that change the way data is received by child parameters, but do not change the behavior of the module.

BUG FIXES:

* Output `keys`: The wrong parameter output.
* Output `secrets`: The wrong parameter output.

## 1.1.0 (February 11, 2021)

FEATURES:

* **New Parameter:** `keys`
* **New Parameter:** `keys.name`
* **New Parameter:** `keys.key_type`
* **New Parameter:** `keys.key_size`
* **New Parameter:** `keys.curve`
* **New Parameter:** `keys.key_opts`
* **New Parameter:** `keys.not_before_date`
* **New Parameter:** `keys.expiration_date`
* **New Parameter:** `secrets`
* **New Parameter:** `secrets.name`
* **New Parameter:** `secrets.value`
* **New Parameter:** `secrets.content_type`
* **New Parameter:** `secrets.not_before_date`
* **New Parameter:** `secrets.expiration_date`

## 1.0.0 (January 25, 2021)

FEATURES:

* **New Parameter:** `name`
* **New Parameter:** `resource_group_name`
* **New Parameter:** `location`
* **New Parameter:** `sku_name`
* **New Parameter:** `tenant_id`
* **New Parameter:** `soft_delete_retention_days`
* **New Parameter:** `purge_protection_enabled`
* **New Parameter:** `enabled_for_deployment`
* **New Parameter:** `enabled_for_disk_encryption`
* **New Parameter:** `enabled_for_template_deployment`
* **New Parameter:** `enable_rbac_authorization`
* **New Parameter:** `access_policies`
* **New Parameter:** `access_policies.object_id`
* **New Parameter:** `access_policies.application_id`
* **New Parameter:** `access_policies.key_permissions`
* **New Parameter:** `access_policies.secret_permissions`
* **New Parameter:** `access_policies.certificate_permissions`
* **New Parameter:** `access_policies.storage_permissions`
* **New Parameter:** `contacts`
* **New Parameter:** `contacts.email`
* **New Parameter:** `contacts.name`
* **New Parameter:** `contacts.phone`
* **New Parameter:** `tags`
