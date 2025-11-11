terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = "bd3dbcd1-3262-48f5-95f6-0a9c3f3411d3"
  # Configuration options
}