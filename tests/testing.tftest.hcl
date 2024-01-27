provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {
  sku_name                        = "Standard"
  soft_delete_retention_days      = 45
  purge_protection_enabled        = false
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = true
  enable_rbac_authorization       = false
}

run "plan" {
  command = plan

  variables {
    name                = run.setup.workspace_id
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
    tenant_id           = run.setup.tenant_id
    access_policies = [{
      object_id           = run.setup.user1_object_id
      secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup"]
      storage_permissions = ["Get", "List", "Update", "Set", "Delete", "Recover", "Backup"]
      }, {
      object_id       = run.setup.user2_object_id
      application_id  = run.setup.app1_object_id
      key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete"]
      }, {
      object_id               = run.setup.app2_object_id
      certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup"]
    }]
  }

  assert {
    condition     = azurerm_key_vault.vault.name == run.setup.workspace_id
    error_message = "The route table name input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.vault.resource_group_name == run.setup.resource_group_name
    error_message = "The route table resource group input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.vault.location == run.setup.resource_group_location
    error_message = "The route table location input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.vault.sku_name == lower(var.sku_name)
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.tenant_id == run.setup.tenant_id
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.soft_delete_retention_days == var.soft_delete_retention_days
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.purge_protection_enabled == var.purge_protection_enabled
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.enabled_for_deployment == var.enabled_for_deployment
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.enabled_for_disk_encryption == var.enabled_for_disk_encryption
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.enabled_for_template_deployment == var.enabled_for_template_deployment
    error_message = ""
  }

  assert {
    condition     = azurerm_key_vault.vault.enable_rbac_authorization == var.enable_rbac_authorization
    error_message = ""
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.vault.access_policy : p.object_id => p })[run.setup.user1_object_id].object_id == run.setup.user1_object_id
    error_message = ""
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.vault.access_policy : p.object_id => p })[run.setup.user2_object_id].object_id == run.setup.user2_object_id
    error_message = ""
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.vault.access_policy : p.object_id => p })[run.setup.user2_object_id].application_id == run.setup.app1_object_id
    error_message = ""
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.vault.access_policy : p.object_id => p })[run.setup.app2_object_id].object_id == run.setup.app2_object_id
    error_message = ""
  }
}

// run "apply" {
//   command = apply

//   variables {
//     name                = run.setup.workspace_id
//     resource_group_name = run.setup.resource_group_name
//     location            = run.setup.resource_group_location
//     tenant_id           = run.setup.tenant_id
//     access_policies = [{
//       object_id           = run.setup.user1_object_id
//       secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup"]
//       storage_permissions = ["Get", "List", "Update", "Set", "Delete", "Recover", "Backup"]
//       }, {
//       object_id       = run.setup.user2_object_id
//       application_id  = run.setup.app1_object_id
//       key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete"]
//       }, {
//       object_id               = run.setup.app2_object_id
//       certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup"]
//     }]
//   }
// }
