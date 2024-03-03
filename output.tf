output "id" {
  value       = azurerm_key_vault.kv.id
  description = "The virtual network configuration ID."
}

output "name" {
  value       = azurerm_key_vault.kv.name
  description = "The name of the virtual network."
}

output "resource_group_name" {
  value       = azurerm_key_vault.kv.resource_group_name
  description = "The name of the resource group in which to create the virtual network."
}

output "location" {
  value       = azurerm_key_vault.kv.location
  description = "The location/region where the virtual network is created."
}

output "tags" {
  value       = azurerm_key_vault.kv.tags
  description = "The tags assigned to the resource."
}

output "contacts" {
  value       = azurerm_key_vault.kv.contact
  description = "Blocks containing each contact."
}

output "access_policies" {
  value       = azurerm_key_vault.kv.access_policy
  description = "Blocks containing configuration of each access policy."
}

output "keys" {
  value       = { for key in azurerm_key_vault_key.keys : key.name => key }
  description = "Blocks containing configuration of each key."
  # module.MODULE_NAME.keys["KEY_NAME"].id
}

output "secrets" {
  value       = { for secret in azurerm_key_vault_secret.secrets : secret.name => secret }
  description = "Blocks containing configuration of each secret."
  # module.MODULE_NAME.keys["SECRET_NAME"].id
}
