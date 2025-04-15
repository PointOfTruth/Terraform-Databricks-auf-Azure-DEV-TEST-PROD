variable "databricks_host" {
  description = "URL of the Databricks workspace"
  type        = string
}

variable "databricks_token" {
  description = "Access token for the Databricks workspace"
  type        = string
}

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

variable "state_key" {
  description = "Key for the state file"
  type        = string
}

variable "spark_version" {
  description = "Spark version for all clusters"
  type        = string
  default     = "13.3.x-scala2.12"
}

variable "cluster_name_dev" {
  description = "Cluster name for the DEV environment"
  type        = string
  default     = "dev-cluster"
}

variable "cluster_name_test" {
  description = "Cluster name for the TEST environment"
  type        = string
  default     = "test-cluster"
}

variable "cluster_name_prod" {
  description = "Cluster name for the PROD environment"
  type        = string
  default     = "prod-cluster"
}

variable "node_type_id_dev" {
  description = "Node type for the DEV cluster"
  type        = string
  default     = "Standard_DS3_v2"
}

variable "node_type_id_test" {
  description = "Node type for the TEST cluster"
  type        = string
  default     = "Standard_DS4_v2"
}

variable "node_type_id_prod" {
  description = "Node type for the PROD cluster"
  type        = string
  default     = "Standard_DS5_v2"
}