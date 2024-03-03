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
      object_id          = run.setup.self_object_id
      key_permissions    = ["Get", "List", "Update", "Create", "Delete", "Purge"]
      secret_permissions = ["Get", "List", "Set", "Delete", "Purge"]
      }, {
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
      keys = [{
      name     = "KeyTest1"
      key_type = "EC"
      curve    = "P-384"
      }, {
      name     = "KeyTest2"
      key_type = "RSA"
      key_size = 2048
    }]
    secrets = [{
      name         = "Secret1"
      value        = "password"
      content_type = "description"
    }]
  }

  assert {
    condition     = azurerm_key_vault.kv.name == run.setup.workspace_id
    error_message = "The key vault name input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.resource_group_name == run.setup.resource_group_name
    error_message = "The key vault resource group input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.location == run.setup.resource_group_location
    error_message = "The key vault location input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.sku_name == lower(var.sku_name)
    error_message = "The key vault sku input variable is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.tenant_id == run.setup.tenant_id
    error_message = "The tenant id of key vault is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.soft_delete_retention_days == var.soft_delete_retention_days
    error_message = "The soft delete retention days of key vault is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.purge_protection_enabled == var.purge_protection_enabled
    error_message = "The purge protection of key vault is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.enabled_for_deployment == var.enabled_for_deployment
    error_message = "The enabled for deployment of key vault is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.enabled_for_disk_encryption == var.enabled_for_disk_encryption
    error_message = "The enabled for disk encryption of key vault is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.enabled_for_template_deployment == var.enabled_for_template_deployment
    error_message = "The enabled for template deployment of key vault is being modified."
  }

  assert {
    condition     = azurerm_key_vault.kv.enable_rbac_authorization == var.enable_rbac_authorization
    error_message = "The enable rbac authorization of key vault is being modified."
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.user1_object_id].object_id == run.setup.user1_object_id
    error_message = "The object id of the access policy of user 1 is being modified."
  }

  assert {
    condition     = tolist(({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.user1_object_id].secret_permissions) == tolist(["Get", "List", "Set", "Delete", "Recover", "Backup"])
    error_message = "The secret permissions of the access policy of user 1 is being modified."
  }

  assert {
    condition     = tolist(({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.user1_object_id].storage_permissions) == tolist(["Get", "List", "Update", "Set", "Delete", "Recover", "Backup"])
    error_message = "The storage permissions of the access policy of user 1 is being modified."
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.user2_object_id].object_id == run.setup.user2_object_id
    error_message = "The object id of the access policy of user 2 is being modified."
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.user2_object_id].application_id == run.setup.app1_object_id
    error_message = "The application id of the access policy of user 2 is being modified."
  }

  assert {
    condition     = tolist(({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.user2_object_id].key_permissions) == tolist(["Get", "List", "Update", "Create", "Import", "Delete"])
    error_message = "The key permissions of the access policy of user 1 is being modified."
  }

  assert {
    condition     = ({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.app2_object_id].object_id == run.setup.app2_object_id
    error_message = "The object id of the access policy of app 2 is being modified."
  }

  assert {
    condition     = tolist(({ for p in azurerm_key_vault.kv.access_policy : p.object_id => p })[run.setup.app2_object_id].certificate_permissions) == tolist(["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup"])
    error_message = "The certificate permissions of the access policy of user 1 is being modified."
  }

  assert {
    condition     = ({ for k in azurerm_key_vault_key.keys.keys : k.name => k })["KeyTest1"].name == "KeyTest1"
    error_message = "The name of the access policy of key 1 is being modified."
  }

  assert {
    condition     = ({ for k in azurerm_key_vault_key.keys.keys : k.name => k })["KeyTest1"].key_type == "EC"
    error_message = "The key type of the access policy of key 1 is being modified."
  }

  assert {
    condition     = ({ for k in azurerm_key_vault_key.keys.keys : k.name => k })["KeyTest1"].curve == "P-384"
    error_message = "The curve of the access policy of key 1 is being modified."
  }

  assert {
    condition     = ({ for k in azurerm_key_vault_key.keys.keys : k.name => k })["KeyTest2"].name == "KeyTest2"
    error_message = "The name of the access policy of key 2 is being modified."
  }

  assert {
    condition     = ({ for k in azurerm_key_vault_key.keys.keys : k.name => k })["KeyTest2"].key_type == "RSA"
    error_message = "The key type of the access policy of key 2 is being modified."
  }

  assert {
    condition     = ({ for k in azurerm_key_vault_key.keys.keys : k.name => k })["KeyTest2"].key_size == 2048
    error_message = "The key size of the access policy of key 1 is being modified."
  }

  assert {
    condition     = ({ for s in azurerm_key_vault_secret.secrets : s.name => s })["Secret1"].name == "Secret1"
    error_message = "The name of the access policy of secret 1 is being modified."
  }

  assert {
    condition     = ({ for s in azurerm_key_vault_secret.secrets : s.name => s })["Secret1"].value == "password"
    error_message = "The value of the access policy of secret 1 is being modified."
  }

  assert {
    condition     = ({ for s in azurerm_key_vault_secret.secrets : s.name => s })["Secret1"].content_type == "description"
    error_message = "The content type of the access policy of secret 1 is being modified."
  }
}

run "apply" {
  command = apply

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
}
