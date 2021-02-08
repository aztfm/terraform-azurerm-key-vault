variable "name" {
  type        = string
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
}
variable "location" {
  type        = string
  description = "The location/region where the Key Vault is created."
}
variable "sku_name" {
  type        = string
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium."
}
variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}
variable "soft_delete_retention_days" {
  type        = number
  default     = 90
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 days."
}
variable "purge_protection_enabled" {
  type        = bool
  default     = false
  description = "Is Purge Protection enabled for this Key Vault?"
}
variable "enabled_for_deployment" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
}
variable "enabled_for_disk_encryption" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
}
variable "enabled_for_template_deployment" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
}
variable "enable_rbac_authorization" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
}
variable "access_policies" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each access policies."
  # access_policies = [{ object_id = "", application_id = "", key_permissions = "", secret_permissions = "", certificate_permissions = "", storage_permissions = "" }]
}
variable "keys" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each key."
  # keys = [{ name = "", key_type = "", key_size = "", curse = "", key_opts = "", not_before_date = "", expiration_date = "" }]
}
variable "secrets" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent the configuration of each secrect."
  # secrets = [{ name = "", value = "", content_type = "", not_before_date = "", expiration_date = ""}]
}
variable "contacts" {
  type        = list(map(string))
  default     = []
  description = "List of objects that represent each contact."
  # contacts = [{ email = "", name = "", phone = "" }]
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}
