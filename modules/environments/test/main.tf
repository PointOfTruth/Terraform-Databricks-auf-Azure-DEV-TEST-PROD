provider "azurerm" {
  features {}
}

# Backend Modul – konfiguriert Remote Backend
module "backend" {
  source               = "../../modules/backend"
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
  key                  = var.state_key
}

# Cluster Modul – TEST Umgebung
module "cluster" {
  source         = "../../modules/cluster"
  cluster_name   = var.cluster_name
  spark_version  = var.spark_version
  node_type_id   = var.node_type_id
  num_workers    = var.num_workers
}

# Users and Groups Modul – TEST Umgebung
module "users_and_groups" {
  source       = "../../modules/users_and_groups"
  users        = var.users
  groups       = var.groups
  user_groups  = var.user_groups
}