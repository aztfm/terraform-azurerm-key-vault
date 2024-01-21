provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

variables {}

run "plan" {
  command = plan

  variables {
    name                = run.setup.workspace_id
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
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
    name                = run.setup.workspace_id
    resource_group_name = run.setup.resource_group_name
    location            = run.setup.resource_group_location
  }
}
