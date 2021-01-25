resource "azurerm_key_vault" "vault" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku_name                        = lower(var.sku_name)
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization

  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id               = var.tenant_id
      object_id               = access_policy.value.object_id
      application_id          = lookup(access_policy.value, "application_id", null)
      key_permissions         = lookup(access_policy.value, "key_permissions", "") == "" ? null : split(",", access_policy.value.key_permissions)
      secret_permissions      = lookup(access_policy.value, "secret_permissions", "") == "" ? null : split(",", access_policy.value.secret_permissions)
      certificate_permissions = lookup(access_policy.value, "certificate_permissions", "") == "" ? null : split(",", access_policy.value.certificate_permissions)
      storage_permissions     = lookup(access_policy.value, "storage_permissions", "") == "" ? null : split(",", access_policy.value.storage_permissions)
    }
  }

  dynamic "contact" {
    for_each = var.contacts
    content {
      email = contact.value.email
      name  = lookup(contact.value, "name", null)
      phone = lookup(contact.value, "phone", null)
    }
  }

  tags = var.tags
}
