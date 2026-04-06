#App service plan for both app service and linux web app
resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  sku_name = "Y1"
  os_type = "Linux"
  
}

#Function app for the image processor
resource "azurerm_linux_function_app" "function_app" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id        = azurerm_service_plan.service_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  tags                       = var.tags

  #default configuration for the function app, can be customized as needed
  site_config {
    application_stack {
      python_version = "3.9"
    }
    application_insights_connection_string = azurerm_application_insights.app_insights.connection_string
    application_insights_key = azurerm_application_insights.app_insights.instrumentation_key
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "QUEUE_NAME" = var.storage_queue_name
    "AzureWebJobsStorage" = var.storage_account_connection_string
    "FUNCTIONS_WORKER_RUNTIME" = "python"
  }

}



#AppInsights for monitoring the app service and linux web app
resource "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type     = "web"
  workspace_id = var.log_analytics_workspace_id
  tags                = var.tags
}
