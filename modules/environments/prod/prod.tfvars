# --- Azure Backend ---
resource_group_name  = "rg-databricks-prod"
storage_account_name = "tfstateprod"
container_name       = "tfstate"
state_key            = "prod/terraform.tfstate"

# --- Cluster-Konfiguration ---
cluster_name   = "prod-cluster"
spark_version  = "13.3.x-scala2.12"
node_type_id   = "Standard_DS5_v2"
num_workers    = 8

# --- Benutzer und Gruppen ---
users = [
  "prod.user1@example.com",
  "prod.user2@example.com",
  "prod.admin@example.com"
]

groups = [
  "Prod Team",
  "Data Science",
  "Admins"
]

user_groups = {
  "prod.user1@example.com"  = ["Prod Team"]
  "prod.user2@example.com"  = ["Prod Team", "Data Science"]
  "prod.admin@example.com"  = ["Admins"]
}