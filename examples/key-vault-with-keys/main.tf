provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-azurerm-key-vault"
  location = "West Europe"
}

module "key-vault" {
  source              = "aztfm/key-vault/azurerm"
  version             = ">=1.1.0"
  name                = "key-vault"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  access_policies = [
    {
      object_id       = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXX"
      key_permissions = "create,get,purge,recover"
    }
  ]
  keys = [{ name = "key-1", key_type = "RSA", key_size = "2048", key_opts = "decrypt,encrypt,sign,unwrapKey,verify,wrapKey" }]
}
