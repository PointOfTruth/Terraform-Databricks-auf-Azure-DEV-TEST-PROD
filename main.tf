# Provider-Konfiguration
provider "azurerm" {
  features {}
}

provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

# Backend Modul für Remote State (über die Module-Ordnerstruktur)
module "backend" {
  source               = "./backend"
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
  key                  = var.state_key
}

# Cluster-Modul für DEV, TEST, PROD (je nach Umgebung)
module "cluster_dev" {
  source        = "./modules/cluster"
  cluster_name  = var.cluster_name_dev
  spark_version = var.spark_version
  node_type_id  = var.node_type_id_dev
}

module "cluster_test" {
  source        = "./modules/cluster"
  cluster_name  = var.cluster_name_test
  spark_version = var.spark_version
  node_type_id  = var.node_type_id_test
}

module "cluster_prod" {
  source        = "./modules/cluster"
  cluster_name  = var.cluster_name_prod
  spark_version = var.spark_version
  node_type_id  = var.node_type_id_prod
}

# Users and Groups-Modul für DEV, TEST, PROD (je nach Umgebung)
module "users_and_groups_dev" {
  source = "./modules/users_and_groups"
}

module "users_and_groups_test" {
  source = "./modules/users_and_groups"
}

module "users_and_groups_prod" {
  source = "./modules/users_and_groups"
}