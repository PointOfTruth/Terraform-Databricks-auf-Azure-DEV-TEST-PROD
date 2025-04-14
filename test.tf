provider "databricks" {
  azure_workspace_resource_id = var.databricks_workspace_resource_id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}

# Variablen für TEST Cluster
variable "test_num_workers" {
  description = "Anzahl der Arbeitsknoten für den TEST-Cluster"
  default     = 4
}

variable "test_node_type" {
  description = "Der Typ der Knoten für den TEST-Cluster"
  default     = "Standard_DS3_v2"
}

# TEST Cluster Ressourcen-Definition
resource "databricks_cluster" "test_cluster" {
  cluster_name            = "test-cluster"
  spark_version           = "7.3.x-scala2.12"
  node_type_id            = var.test_node_type
  num_workers             = var.test_num_workers
  autotermination_minutes = 20

  # Umgebungsvariablen für den TEST Cluster
  spark_env_vars = {
    "EXAMPLE_VAR" = "test_value"
  }
}

# Ausgabe des TEST Cluster ID
output "test_cluster_id" {
  value = databricks_cluster.test_cluster.id
}