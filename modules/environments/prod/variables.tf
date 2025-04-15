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
  description = "Databricks workspace URL"
}

variable "databricks_token" {
  type        = string
  description = "Databricks personal access token"
}

# --- Cluster Modul Variablen ---
variable "cluster_name" {
  type = string
}

variable "spark_version" {
  type = string
}

variable "node_type_id" {
  type = string
}

variable "num_workers" {
  type = number
}

# --- Users and Groups Modul Variablen ---
variable "users" {
  description = "List of user email addresses"
  type        = list(string)
}

variable "groups" {
  description = "List of groups to be created in Databricks"
  type        = list(string)
}

variable "user_groups" {
  description = "Mapping of users to groups"
  type        = map(list(string))
}