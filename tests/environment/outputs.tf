output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "workspace_id" {
  value = local.workspace_id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  value = azurerm_resource_group.rg.location
}

output "user1_object_id" {
  value = azuread_user.user1.object_id
}

output "self_object_id" {
  value = data.azurerm_client_config.current.object_id
}

output "user2_object_id" {
  value = azuread_user.user2.object_id
}

output "app1_object_id" {
  value = azuread_service_principal.app1.object_id
}

output "app2_object_id" {
  value = azuread_service_principal.app2.object_id
}
