terraform {
  backend "azurerm" {
    resource_group_name  = "rg-projects-dev-sa"
    storage_account_name = "saprojectsdevsa"
    container_name       = "tfstate"
    key                  = "project01.terraform.tfstate"
  }
}