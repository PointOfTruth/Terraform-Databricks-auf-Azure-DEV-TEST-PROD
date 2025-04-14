# 🚀 Terraform-Databricks auf Azure – DEV / TEST / PROD

Mit diesem Projekt kannst du eine Azure-basierte Databricks-Umgebung erstellen und verwalten. Es umfasst mehrere Umgebungen (DEV, TEST, PROD) sowie eine benutzerdefinierte Benutzer- und Gruppenverwaltung. Du kannst die Databricks-Cluster für jede Umgebung konfigurieren und Benutzer in die entsprechenden Gruppen integrieren.

---

## 📁 Projektstruktur

```bash
terraform-databricks/
│
├── main.tf                  # Einstiegspunkt, Provider und Module aufrufen
├── providers.tf             # Azure und Databricks Provider Konfiguration
├── backend.tf               # Remote Backend Konfiguration für Terraform State
├── outputs.tf               # Definiert Ausgaben wie Cluster-IDs
├── README.md                # Diese Anleitung
│
├── dev.tf                   # DEV-Umgebungsvariablen und Cluster Konfiguration
├── test.tf                  # TEST-Umgebungsvariablen und Cluster Konfiguration
├── prod.tf                  # PROD-Umgebungsvariablen und Cluster Konfiguration
├── users_and_locals.tf      # Benutzer und Gruppen Konfiguration
└── terraform.tfvars         # Variablenwerte für das Projekt
```

---

## 🧰 Voraussetzungen

- Terraform Version >= 1.3
- Eine **Azure Subscription** mit den nötigen Berechtigungen
- Ein **Databricks-Arbeitsbereich** auf Azure
- Ein **Azure Service Principal** für die Authentifizierung (Client ID, Secret, Tenant ID)

---

## 🔐 Azure- und Databricks-Zugang konfigurieren
Die Variablen wie `databricks_workspace_resource_id`, `client_id`, `client_secret`, `tenant_id` und `subscription_id` müssen im `terraform.tfvars`-File oder über Umgebungsvariablen konfiguriert werden.

```bash
databricks_workspace_resource_id = "/subscriptions/<sub_id>/resourceGroups/<rg>/providers/Microsoft.Databricks/workspaces/<workspace>"
client_id                        = "<azure-client-id>"
client_secret                    = "<azure-client-secret>"
tenant_id                        = "<azure-tenant-id>"
```

---

## 📁 Backend-Konfiguration

Das Projekt verwendet Azure Storage als Remote-Backend, um den Terraform-Status zu speichern.<br/>
Dadurch wird eine zentrale Verwaltung des Terraform-Status und eine bessere Zusammenarbeit im Team ermöglicht.<br/>
Die Konfiguration dafür erfolgt in der `backend.tf`-Datei:

```bash
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "databricks.tfstate"
  }
}
```

---

## 🛠 Cluster- und Benutzerverwaltung
Für jede Umgebung (DEV, TEST, PROD) werden separate Cluster konfiguriert und mit entsprechenden Umgebungsvariablen versehen.<br/>
Die Benutzerverwaltung erfolgt über die `users_and_locals.tf`, wo Benutzer E-Mail-Adressen hinzugefügt und Gruppen zugewiesen werden.

---

## 🚀 Nutzung des Projekts
### 1. Initialisierung<br/>
Vor dem ersten Deployment musst du Terraform initialisieren:
```bash
terraform init
```
### 2. Deployment
Um das Projekt zu starten und die Umgebungen zu erstellen, verwende den folgenden Befehl:

```bash
terraform apply -var-file="terraform.tfvars"
```

Du kannst optional auch eine spezifische Umgebung (DEV, TEST oder PROD) angeben, indem du die entsprechende `.tf`-Datei an den Befehl anhängst.

### 3. Umgebungen anwenden<br/>
Um die spezifischen Umgebungen (DEV, TEST, PROD) zu deployen, kannst du die folgenden Befehle ausführen:

**DEV**
```bash
terraform apply -var-file="terraform.tfvars" -target=module.dev_cluster
```

**TEST**
```bash
terraform apply -var-file="terraform.tfvars" -target=module.test_cluster
```

**PROD**
```bash
terraform apply -var-file="terraform.tfvars" -target=module.prod_cluster
```

### 4. Ausgabe<br/>
Nachdem das Deployment abgeschlossen ist, erhältst du die Cluster-IDs als Ausgaben:
```bash
output "dev_cluster_id"
output "test_cluster_id"
output "prod_cluster_id"
```

---

## 🛡️ Benutzerverwaltung

Die Benutzerverwaltung für jede Umgebung (DEV, TEST, PROD) wird über `users_and_locals.tf` verwaltet. Benutzer werden spezifischen Gruppen zugewiesen:
- **DEV**-Benutzer werden der `DEV_group` zugewiesen.
- **TEST**-Benutzer werden der `TEST_group` zugewiesen.
- **PROD**-Benutzer werden der `PROD_group` zugewiesen.

Die Benutzer E-Mail-Adressen kannst du hier bearbeiten:

```bash
locals {
  # DEV Benutzer
  dev_users = [
    "dev1@example.com",
    "dev2@example.com"
  ]
  
  # TEST Benutzer
  test_users = [
    "test1@example.com",
    "test2@example.com"
  ]
  
  # PROD Benutzer
  prod_users = [
    "prod1@example.com",
    "prod2@example.com"
  ]
}
```

---

## 🧑‍💻 Ausgaben

Am Ende des Terraform-Prozesses wird die ID des erstellten Clusters für jede Umgebung angezeigt.<br/>
Diese IDs kannst du für die weitere Verwaltung von Databricks-Ressourcen verwenden.

```bash
terraform output dev_cluster_id
```

---

## 🌐 Weitere Links

Hier sind einige nützliche Links, die dir bei der Arbeit mit Terraform und Azure Databricks helfen können:

- [Terraform Dokumentation](https://www.terraform.io/docs)
- [Azure Databricks Dokumentation](https://docs.microsoft.com/en-us/azure/databricks/)
- [Azure Terraform Provider Dokumentation](https://www.terraform.io/docs/providers/azurerm)
- [Databricks Terraform Provider Dokumentation](https://www.terraform.io/docs/providers/databricks)

---

## 🔄 Zurücksetzen des Terraform-Status

Falls du den Terraform-Status zurücksetzen musst, verwende den folgenden Befehl:

```bash
terraform destroy -var-file="terraform.tfvars"
```