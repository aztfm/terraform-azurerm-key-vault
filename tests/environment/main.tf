data "azuread_domains" "tenant" {}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.workspace_id
  location = "Spain Central"
}

resource "random_password" "pass" {
  length  = 24
  special = true
}

resource "azuread_user" "user1" {
  account_enabled     = false
  user_principal_name = sensitive("1${local.workspace_id}@${data.azuread_domains.tenant.domains[0].domain_name}")
  display_name        = "1${local.workspace_id}"
  password            = random_password.pass.result
}

resource "azuread_user" "user2" {
  account_enabled     = false
  user_principal_name = sensitive("2${local.workspace_id}@${data.azuread_domains.tenant.domains[0].domain_name}")
  display_name        = "2${local.workspace_id}"
  password            = random_password.pass.result
}

resource "azuread_application" "app1" {
  display_name = "1${local.workspace_id}"
}

resource "azuread_application" "app2" {
  display_name = "2${local.workspace_id}"
}

resource "azuread_service_principal" "app1" {
  client_id = azuread_application.app1.client_id
}

resource "azuread_service_principal" "app2" {
  client_id = azuread_application.app2.client_id
}
