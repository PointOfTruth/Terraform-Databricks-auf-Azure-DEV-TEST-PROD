# --- Azure Backend ---
resource_group_name  = "rg-databricks-dev"
storage_account_name = "tfstatedev"
container_name       = "tfstate"
state_key            = "dev/terraform.tfstate"

# --- Cluster-Konfiguration ---
cluster_name   = "dev-cluster"
spark_version  = "13.3.x-scala2.12"
node_type_id   = "Standard_DS3_v2"
num_workers    = 2

# --- Benutzer und Gruppen ---
users = [
  "dev.user1@example.com",
  "dev.user2@example.com"
]

groups = [
  "Dev Team",
  "Engineering"
]

user_groups = {
  "dev.user1@example.com" = ["Dev Team"]
  "dev.user2@example.com" = ["Dev Team", "Engineering"]
}