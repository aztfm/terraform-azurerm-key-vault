data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.workspace_id
  location = "West Europe"
}
