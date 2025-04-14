provider "databricks" {
  azure_workspace_resource_id = var.databricks_workspace_resource_id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}

# Variablen für DEV Cluster
variable "dev_num_workers" {
  description = "Anzahl der Arbeitsknoten für den DEV-Cluster"
  default     = 3
}

variable "dev_node_type" {
  description = "Der Typ der Knoten für den DEV-Cluster"
  default     = "Standard_DS4_v2"
}

# DEV Cluster Ressourcen-Definition
resource "databricks_cluster" "dev_cluster" {
  cluster_name            = "dev-cluster"
  spark_version           = "7.3.x-scala2.12"
  node_type_id            = var.dev_node_type
  num_workers             = var.dev_num_workers
  autotermination_minutes = 20

  # Umgebungsvariablen für den DEV Cluster
  spark_env_vars = {
    "EXAMPLE_VAR" = "dev_value"
  }
}

# Ausgabe des DEV Cluster ID
output "dev_cluster_id" {
  value = databricks_cluster.dev_cluster.id
}