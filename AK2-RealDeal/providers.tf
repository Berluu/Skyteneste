#AK2  - providers.tf

# Providers
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.66.0"
    }
  }
}

# Subscription ID
provider "azurerm" {
    features {}
    subscription_id = var.sub_id
}


