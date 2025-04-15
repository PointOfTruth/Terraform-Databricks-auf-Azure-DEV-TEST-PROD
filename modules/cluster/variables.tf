variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "spark_version" {
  type        = string
  description = "Databricks Spark Version"
}

variable "node_type_id" {
  type        = string
  description = "Node Type ID"
}

variable "num_workers" {
  type        = number
  description = "Number of workers"
}