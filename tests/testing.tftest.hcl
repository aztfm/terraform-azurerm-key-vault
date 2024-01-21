provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {
  sku_name = "Standard"
}

run "plan" {
  command = plan

  variables {
    name                = substr(run.setup.workspace_id, 0, 23)
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
    tenant_id           = run.setup.tenant_id
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
}

run "apply" {
  command = apply

  variables {
    name                = substr(run.setup.workspace_id, 0, 23)
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
    tenant_id           = run.setup.tenant_id
  }
}
