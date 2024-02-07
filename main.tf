 provider "azurerm" {
    features {
      
    }

 }
resource "azurerm_resource_group" "function-rg1" {
  name     = "fun-app-rg1"
  location = "eastus"
}

resource "azurerm_storage_account" "functionstorage" {
  name                     = "myfunctiondemo"
  resource_group_name      = azurerm_resource_group.function-rg1.name
  location                 = azurerm_resource_group.function-rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "myfunctionsplandemo" {
  name                = "myfunctionsTestplan-demo"
  location            = azurerm_resource_group.function-rg1.location
  resource_group_name = azurerm_resource_group.function-rg1.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "myfunctionappdemo0988" {
  name                       = "myfunctionappdemo0988"
  location                   = azurerm_resource_group.function-rg1.location
  resource_group_name        = azurerm_resource_group.function-rg1.name
  app_service_plan_id        = azurerm_app_service_plan.myfunctionsplandemo.id
  storage_account_name       = azurerm_storage_account.functionstorage.name
  storage_account_access_key = azurerm_storage_account.functionstorage.primary_access_key
site_config {
    dotnet_framework_version = "v6.0"
}
}