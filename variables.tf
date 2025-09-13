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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
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

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether public network access is allowed for this Key Vault."
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
  type = list(object({
    object_id               = string
    application_id          = optional(string)
    key_permissions         = optional(list(string), [])
    secret_permissions      = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
    storage_permissions     = optional(list(string), [])
  }))
  default     = []
  description = "List of objects that represent the configuration of each access policies."
}

variable "keys" {
  type = list(object({
    name            = string
    key_type        = string
    key_size        = optional(number)
    curve           = optional(string)
    key_opts        = optional(list(string), [])
    not_before_date = optional(string)
    expiration_date = optional(string)
  }))
  default     = []
  description = "List of objects that represent the configuration of each key."
}

variable "secrets" {
  type = list(object({
    name            = string
    value           = string
    content_type    = optional(string)
    not_before_date = optional(string)
    expiration_date = optional(string)
  }))
  default     = []
  description = "List of objects that represent the configuration of each secret."
}

variable "contacts" {
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  default     = []
  description = "List of objects that represent each contact."
}
