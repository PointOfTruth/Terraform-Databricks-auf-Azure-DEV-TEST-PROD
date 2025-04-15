variable "users" {
  description = "Liste der Benutzer, die in Databricks angelegt werden sollen."
  type = list(object({
    email = string
    name  = optional(string)
  }))
}

variable "groups" {
  description = "Liste der Gruppen, die in Databricks erstellt werden sollen."
  type        = list(string)
}

variable "user_groups" {
  description = "Zuordnung von Benutzern zu Gruppen (E-Mail -> Gruppenliste)."
  type        = map(list(string))
}

variable "user_keys" {
  description = "Optionale Liste von SSH-/API-Schlüsseln pro Benutzer (E-Mail -> Liste öffentlicher Schlüssel)."
  type        = map(list(string))
  default     = {}
}