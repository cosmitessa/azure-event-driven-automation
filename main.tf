data "azurerm_resource_group" "rg" {
  name = "rg-projects-dev-sa"
}

data "azurerm_client_config" "current" {}

module "compute" {
  source                            = "./modules/compute"
  resource_group_name               = data.azurerm_resource_group.rg.name
  location                          = data.azurerm_resource_group.rg.location
  app_service_name                  = var.app_service_name
  function_app_name                 = var.function_app_name
  storage_account_access_key        = module.storage.storage_account_access_key
  storage_account_name              = module.storage.storage_account_name
  storage_queue_name                = module.storage.storage_queue_name
  log_analytics_workspace_id        = module.monitoring.log_analytics_workspace_id
  app_insights_name                 = var.app_insights_name
  service_plan_name                 = var.service_plan_name
  storage_account_connection_string = module.storage.storage_account_connection_string
  tags                              = data.azurerm_resource_group.rg.tags
}

module "storage" {
  source                       = "./modules/storage"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  monitoring_name              = module.monitoring.log_analytics_workspace_name
  event_grid_subscription_name = var.event_grid_subscription_name
  event_grid_topic_name        = var.event_grid_topic_name
  storage_account_name         = var.storage_account_name
  storage_container_name       = var.storage_container_name
  storage_queue_name           = var.storage_queue_name
  log_analytics_workspace_id   = module.monitoring.log_analytics_workspace_id
  tags                         = data.azurerm_resource_group.rg.tags
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  law_name            = var.law_name
  tags                = data.azurerm_resource_group.rg.tags
}

#role assignments
resource "azurerm_role_assignment" "queue_receiver" {
  scope                = module.storage.storage_queue_id
  role_definition_name = "Storage Queue Data Message Processor"
  principal_id         = module.compute.function_app_identity_principal_id
}


resource "azurerm_role_assignment" "blob_reader" {
  scope                = module.storage.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = module.compute.function_app_identity_principal_id
}