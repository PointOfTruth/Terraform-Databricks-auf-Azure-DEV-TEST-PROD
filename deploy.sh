#!/bin/bash

# --- Bash-Skript für Terraform-Deployments ---
# Hiermit kannst du die Umgebungen (dev, test, prod) einfach deployen

# Check, ob ein Umgebungsname übergeben wurde
if [ -z "$1" ]; then
  echo "Bitte gib eine Umgebung an (dev, test, prod)"
  exit 1
fi

# Umgebungsname (DEV, TEST, PROD)
ENVIRONMENT=$1

# Verifiziere, dass die angegebene Umgebung existiert
if [[ "$ENVIRONMENT" != "dev" && "$ENVIRONMENT" != "test" && "$ENVIRONMENT" != "prod" ]]; then
  echo "Ungültige Umgebung: $ENVIRONMENT. Gültige Optionen sind: dev, test, prod."
  exit 1
fi

# --- Terraform Konfiguration initialisieren ---
echo "Initialisiere Terraform für die $ENVIRONMENT Umgebung..."
terraform init -backend-config="environments/$ENVIRONMENT/$ENVIRONMENT.tfvars"

# --- Terraform Plan und Apply ausführen ---
echo "Erstelle Terraform Plan und wende es auf der $ENVIRONMENT Umgebung an..."
terraform plan -var-file="environments/$ENVIRONMENT/$ENVIRONMENT.tfvars"
terraform apply -var-file="environments/$ENVIRONMENT/$ENVIRONMENT.tfvars" -auto-approve

# --- Deployment abgeschlossen ---
echo "Terraform Deployment für $ENVIRONMENT abgeschlossen!"
