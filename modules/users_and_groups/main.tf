resource "databricks_group" "example_group" {
  display_name = "example-group"
}

resource "databricks_user" "example_user" {
  user_name = "user@example.com"
}

resource "databricks_group_member" "membership" {
  group_id  = databricks_group.example_group.id
  member_id = databricks_user.example_user.id
}