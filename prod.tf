provider "databricks" {
  azure_workspace_resource_id = var.databricks_workspace_resource_id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}

# Variablen für PROD Cluster
variable "prod_num_workers" {
  description = "Anzahl der Arbeitsknoten für den PROD-Cluster"
  default     = 5
}

variable "prod_node_type" {
  description = "Der Typ der Knoten für den PROD-Cluster"
  default     = "Standard_DS5_v2"
}

# PROD Cluster Ressourcen-Definition
resource "databricks_cluster" "prod_cluster" {
  cluster_name            = "prod-cluster"
  spark_version           = "7.3.x-scala2.12"
  node_type_id            = var.prod_node_type
  num_workers             = var.prod_num_workers
  autotermination_minutes = 20

  # Umgebungsvariablen für den PROD Cluster
  spark_env_vars = {
    "EXAMPLE_VAR" = "prod_value"
  }
}

# Ausgabe des PROD Cluster ID
output "prod_cluster_id" {
  value = databricks_cluster.prod_cluster.id
}