resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  spark_version           = var.spark_version
  node_type_id            = var.node_type_id
  autotermination_minutes = 30
  num_workers             = var.num_workers
}