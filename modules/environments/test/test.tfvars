# --- Azure Backend ---
resource_group_name  = "rg-databricks-test"
storage_account_name = "tfstatetest"
container_name       = "tfstate"
state_key            = "test/terraform.tfstate"

# --- Cluster-Konfiguration ---
cluster_name   = "test-cluster"
spark_version  = "13.3.x-scala2.12"
node_type_id   = "Standard_DS4_v2"
num_workers    = 4

# --- Benutzer und Gruppen ---
users = [
  "test.user1@example.com",
  "test.user2@example.com"
]

groups = [
  "Test Team",
  "QA"
]

user_groups = {
  "test.user1@example.com" = ["Test Team"]
  "test.user2@example.com" = ["Test Team", "QA"]
}