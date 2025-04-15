# --- Backend Variablen ---
variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group name for remote backend"
}

variable "storage_account_name" {
  type        = string
  description = "Azure Storage Account name for remote backend"
}

variable "container_name" {
  type        = string
  description = "Azure Blob container name for remote backend"
}

variable "state_key" {
  type        = string
  description = "Key (path) to the state file in the backend container"
}

# --- Databricks Provider ---
variable "databricks_host" {
  type        = string
  description =