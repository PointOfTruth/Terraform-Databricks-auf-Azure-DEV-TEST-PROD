# Terraform-Databricks auf Azure – DEV / TEST / PROD

Dieses Terraform-Projekt ermöglicht die Verwaltung von Databricks Workspaces, Benutzern, Gruppen, Clusters und Backend-Konfigurationen für verschiedene Umgebungen (DEV, TEST, PROD) in Azure.<br/> 
Es verwendet modulare Ansätze für eine saubere Trennung und Wiederverwendbarkeit der Ressourcen.

## 🚀 Schnellstart

### 1. Voraussetzungen
Bevor du mit Terraform und diesem Projekt arbeiten kannst, stelle sicher, dass du die folgenden Tools installiert hast:
- Terraform (mindestens Version 1.0)
- Azure CLI
- Databricks CLI

---

### 2. Projektstruktur
Hier ist eine detaillierte Übersicht über die Verzeichnisstruktur:

```bash
.
├── main.tf                      # Zentraler Einstiegspunkt für die Orchestrierung
├── providers.tf                 # Zentrale Provider-Definition (Databricks, Azure)
├── variables.tf                 # Globale Variablen (z.B. databricks_host, token)
├── terraform.tfvars             # (Optional) Globale Standardwerte für Terraform

├── modules/
│   ├── backend/                 # Modul für Azure Remote Backend
│   │   ├── main.tf              # Konfiguration für Azure Storage Account als Backend
│   │   └── variables.tf         # Variablen für das Backend (z.B. Resource Group, Storage Account, etc.)
│   │
│   ├── cluster/                 # Modul zur Erstellung von Databricks-Clustern
│   │   ├── main.tf              # Erstellen von Databricks-Cluster (mit Version, Node Type, Worker-Anzahl)
│   │   └── variables.tf         # Variablen für Cluster-Konfiguration (z.B. Cluster Name, Spark Version)
│   │
│   └── users_and_groups/        # Modul für Benutzer- und Gruppenverwaltung
│       ├── main.tf              # Erstellen von Benutzern, Gruppen und deren Zuordnung in Databricks
│       └── variables.tf         # Variablen für Benutzer und Gruppen (z.B. E-Mail-Adressen, Gruppenzuordnungen)
│
├── environments/                # Verschiedene Umgebungen (dev, test, prod)
│   ├── dev/                     # DEV Umgebungs-Konfiguration
│   │   ├── main.tf              # Verwenden der Module (cluster, backend, users_and_groups) für DEV
│   │   ├── variables.tf         # Umgebungsspezifische Variablen (z.B. Ressourcen, User- und Cluster-Konfiguration)
│   │   └── dev.tfvars           # DEV-spezifische Parameter (z.B. Cluster-Name, User-Liste)
│   │
│   ├── test/                    # TEST Umgebungs-Konfiguration
│   │   ├── main.tf              # Analog zu dev/main.tf – für TEST-Umgebung
│   │   ├── variables.tf         # Umgebungsspezifische Variablen
│   │   └── test.tfvars          # TEST-spezifische Parameter
│   │
│   └── prod/                    # PROD Umgebungs-Konfiguration
│       ├── main.tf              # PROD-spezifische Konfiguration
│       ├── variables.tf         # Umgebungsspezifische Variablen
│       └── prod.tfvars          # PROD-spezifische Parameter
```

---

## 🧰 Terraform-Nutzung

### 1. Initialisierung

Bevor du mit Terraform arbeitest, musst du das Projekt initialisieren. Dies geschieht über den folgenden Befehl:

```bash
terraform init -backend-config="environments/[ENVIRONMENT]/[ENVIRONMENT].tfvars"
```

Beispiel für die DEV-Umgebung:

```bash
terraform init -backend-config="environments/dev/dev.tfvars"
```

- Der `-backend-config`-Parameter sorgt dafür, dass die Remote-Backend-Konfiguration (z. B. Azure Storage für den Terraform-Status) korrekt eingerichtet wird.

### 2. Planen und Anwenden von Terraform

Nachdem die Initialisierung abgeschlossen ist, kannst du mit `terraform plan` die geplante Infrastruktur anzeigen lassen und mit `terraform apply` die Ressourcen anwenden:

```bash
terraform plan -var-file="environments/[ENVIRONMENT]/[ENVIRONMENT].tfvars"
terraform apply -var-file="environments/[ENVIRONMENT]/[ENVIRONMENT].tfvars"
```

Beispiel für DEV:

```bash
terraform plan -var-file="environments/dev/dev.tfvars"
terraform apply -var-file="environments/dev/dev.tfvars"
```

### 3. Verwaltung der Umgebungen

Für jede Umgebung gibt es eine eigene `tfvars`-Datei. Du kannst diese Dateien verwenden, um die Parameter je nach Umgebung zu konfigurieren.
- `environments/dev/dev.tfvars` – für die DEV-Umgebung
- `environments/test/test.tfvars` – für die TEST-Umgebung
- `environments/prod/prod.tfvars` – für die PROD-Umgebung

---

## 🛠️ Automatisiertes Deployment (Bash-Skript)

Du kannst auch das `deploy.sh`-Skript verwenden, um die Bereitstellung für eine spezifische Umgebung zu automatisieren.

### 1. Bash-Skript verwenden

Das Skript fragt nach der Umgebung (DEV, TEST, PROD) und führt dann Terraform mit der passenden `.tfvars`-Datei aus.

Stelle sicher, dass das Skript ausführbar ist:

```bash
chmod +x deploy.sh
```

### 2. Das Skript ausführen

- Für **DEV**:

```bash
./deploy.sh dev
```

- Für **TEST**:

```bash
./deploy.sh test
```

- Für **PROD**:

```bash
./deploy.sh prod
```

Das Skript führt `terraform init`, `terraform plan` und `terraform apply` aus – für eine schnelle Bereitstellung in der jeweiligen Umgebung.

---

## 📂 Projektstruktur im Detail

### 1. `providers.tf`

Die Datei `providers.tf` definiert den Databricks Provider und den **Azure Provider**, die für den Betrieb der Infrastruktur benötigt werden:

```bash
provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

provider "azurerm" {
  features {}
}
```

### 2. Module

Die Module werden in einem eigenen Ordner `modules/` abgelegt.<br/>
Jedes Modul hat eine eigene Funktionalität:
- **Backend**: Verwaltet das Azure Storage Backend, um Terraform-States zu speichern und zu verwalten.
- **Cluster**: Erstellt und verwaltet Databricks-Cluster. Es stellt sicher, dass Ressourcen wie Cluster-Name, Spark-Version und Worker-Konfiguration korrekt gesetzt sind.
- **Users and Groups**: Verwaltet Databricks-Benutzer und Gruppen und sorgt dafür, dass Benutzer zu den richtigen Gruppen zugewiesen werden.

**Beispiel eines `cluster/main.tf` Moduls:**

```bash
resource "databricks_cluster" "this" {
  cluster_name = var.cluster_name
  spark_version = var.spark_version
  node_type_id = var.node_type_id
  num_workers  = var.num_workers
}
```

### 3. Umgebungen

Für jede Umgebung (DEV, TEST, PROD) gibt es:
- Eine `main.tf`, die die Module referenziert.
- Eine `variables.tf`, die spezifische Variablen für die Umgebung enthält (z. B. Cluster-Konfiguration, User und Gruppen).
- Eine `*.tfvars`-Datei mit den umgebungsspezifischen Parametern.

Beispiel für **DEV** (`environments/dev/main.tf`):

```bash
module "backend" {
  source               = "../../modules/backend"
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
  container_name       = var.container_name
  key                  = var.state_key
}

module "cluster" {
  source         = "../../modules/cluster"
  cluster_name   = var.cluster_name
  spark_version  = var.spark_version
  node_type_id   = var.node_type_id
  num_workers    = var.num_workers
}

module "users_and_groups" {
  source       = "../../modules/users_and_groups"
  users        = var.users
  groups       = var.groups
  user_groups  = var.user_groups
}
```

---

## 🎯 Zusätzliche Optionen

- Variablen und Parameter können direkt in den `.tfvars`-Dateien jeder Umgebung gesetzt werden, z.B. `databricks_host`, `databricks_token`, `cluster_name`, etc.
- **Logging und Monitoring**: Weitere Monitoring- und Logging-Optionen können in den Clustern oder Benutzer-Management-Modulen hinzugefügt werden.

---

## 📚 Weitere Ressourcen

Hier sind einige hilfreiche Links zur Vertiefung und Unterstützung bei der Nutzung von Terraform, Azure und Databricks:

- 🛠️ [Terraform – Offizielle Dokumentation](https://www.terraform.io/docs)  
  Die zentrale Anlaufstelle für alle Fragen rund um Terraform.

- ☁️ [Azure Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)  
  Detaillierte Beschreibung aller Azure-spezifischen Terraform-Ressourcen.

- 🔐 [Databricks Terraform Provider](https://registry.terraform.io/providers/databricks/databricks/latest/docs)  
  Beschreibung aller Ressourcen und Datenquellen des Databricks Providers.

- 🧪 [Databricks REST API Dokumentation](https://docs.databricks.com/dev-tools/api/latest/index.html)  
  Wenn du wissen willst, was Terraform im Hintergrund auf der Databricks-API tut.

- 🔧 [Databricks CLI Dokumentation](https://docs.databricks.com/dev-tools/cli/index.html)  
  Für manuelle Verwaltungsaufgaben oder als Ergänzung zu Terraform.

- 💬 [Terraform Community Forum](https://discuss.hashicorp.com/c/terraform-core/24)  
  Stelle Fragen, teile Erfahrungen oder finde Lösungen zu häufigen Problemen.

---