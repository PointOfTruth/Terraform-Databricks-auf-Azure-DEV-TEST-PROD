output "dev_cluster_id" {
  value = databricks_cluster.dev_cluster.id
}

output "test_cluster_id" {
  value = databricks_cluster.test_cluster.id
}

output "prod_cluster_id" {
  value = databricks_cluster.prod_cluster.id
}