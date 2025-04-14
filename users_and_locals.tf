locals {
  # Benutzer für die DEV-Umgebung
  dev_users = [
    "dev1@example.com",
    "dev2@example.com"
  ]

  # Benutzer für die TEST-Umgebung
  test_users = [
    "test1@example.com",
    "test2@example.com"
  ]

  # Benutzer für die PROD-Umgebung
  prod_users = [
    "prod1@example.com",
    "prod2@example.com"
  ]
}

resource "databricks_group" "dev_group" {
  name = "DEV_group"
}

resource "databricks_group" "test_group" {
  name = "TEST_group"
}

resource "databricks_group" "prod_group" {
  name = "PROD_group"
}

# Benutzer den jeweiligen Gruppen zuweisen
resource "databricks_group_member" "dev_group_members" {
  for_each = toset(local.dev_users)

  group_id = databricks_group.dev_group.id
  user_name = each.value
}

resource "databricks_group_member" "test_group_members" {
  for_each = toset(local.test_users)

  group_id = databricks_group.test_group.id
  user_name = each.value
}

resource "databricks_group_member" "prod_group_members" {
  for_each = toset(local.prod_users)

  group_id = databricks_group.prod_group.id
  user_name = each.value
}