# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  client_id                   = var.AZ_CLIENT_ID
  client_certificate_path     = var.AZ_CERT_PATH
  client_certificate_password = var.AZ_CERT_PASSWORD
  tenant_id                   = var.AZ_TENNENT_ID
  subscription_id             = var.AZ_SUBSCRIPTION
}
