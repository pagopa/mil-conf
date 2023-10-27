terraform {
  required_version = ">= 1.5.6"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.43.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.40.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

provider "github" {
  owner = var.github.org
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
