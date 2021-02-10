output "id" {
  value       = azurerm_key_vault.vault.id
  description = "The virtual network configuration ID."
}
output "name" {
  value       = azurerm_key_vault.vault.name
  description = "The name of the virtual network."
}
output "resource_group_name" {
  value       = azurerm_key_vault.vault.resource_group_name
  description = "The name of the resource group in which to create the virtual network."
}
output "location" {
  value       = azurerm_key_vault.vault.location
  description = "The location/region where the virtual network is created."
}
output "access_policies" {
  value       = azurerm_key_vault.vault.access_policy
  description = "Blocks containing configuration of each access policy."
}
output "keys" {
  value       = azurerm_key_vault.vault.access_policy
  description = "Blocks containing configuration of each key."
}
output "secrets" {
  value       = azurerm_key_vault.vault.access_policy
  description = "Blocks containing configuration of each secret."
}
output "contacts" {
  value       = azurerm_key_vault.vault.contact
  description = "Blocks containing each contact."
}
output "tags" {
  value       = azurerm_key_vault.vault.tags
  description = "The tags assigned to the resource."
}
