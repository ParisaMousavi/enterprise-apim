terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.2"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "parisatfstateaziac2weu"
    container_name       = "enterprise-apim"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}