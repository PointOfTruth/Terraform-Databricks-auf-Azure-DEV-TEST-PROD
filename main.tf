provider "azurerm" {
  features {}
}

provider "databricks" {
  azure_workspace_resource_id = var.databricks_workspace_resource_id
  azure_client_id             = var.client_id
  azure_client_secret         = var.client_secret
  azure_tenant_id             = var.tenant_id
}

# DEV Umgebungs-Cluster konfigurieren
module "dev_cluster" {
  source = "./dev.tf"
}

# TEST Umgebungs-Cluster konfigurieren
module "test_cluster" {
  source = "./test.tf"
}

# PROD Umgebungs-Cluster konfigurieren
module "prod_cluster" {
  source = "./prod.tf"
}