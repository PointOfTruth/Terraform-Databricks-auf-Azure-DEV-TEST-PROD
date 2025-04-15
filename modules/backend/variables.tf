variable "resource_group_name" {
  description = "Resource group name for the Azure backend"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name for the Azure backend"
  type        = string
}

variable "container_name" {
  description = "Container name for the Azure backend"
  type        = string
}

variable "key" {
  description = "Key for the state file"
  type        = string
}