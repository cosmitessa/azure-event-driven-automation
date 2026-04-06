terraform {
  required_version = ">= 1.8.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "8e928c68-b97c-4973-8ac4-63b0554050bc"

  features {
  }
}
