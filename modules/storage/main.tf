#Storage Account
resource "azurerm_storage_account" "sa" {
    name                     = var.storage_account_name
    resource_group_name      = var.resource_group_name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = var.tags
}

#Storage Container
resource "azurerm_storage_container" "sc" {
    name                  = var.storage_container_name
    #storage_account_id = azurerm_storage_account.sa.id
    storage_account_name = azurerm_storage_account.sa.name
    container_access_type = "private"

}

#Storage Queue
resource "azurerm_storage_queue" "sq" {
    name                  = var.storage_queue_name
    #storage_account_id = azurerm_storage_account.sa.id
    storage_account_name = azurerm_storage_account.sa.name
}


#Event Grid 
resource "azurerm_eventgrid_system_topic" "storage_topic" {
    name                = var.event_grid_topic_name
    resource_group_name = var.resource_group_name
    location            = var.location
    #source_resource_id = azurerm_storage_account.sa.id
    source_arm_resource_id = azurerm_storage_account.sa.id
    topic_type = "Microsoft.Storage.StorageAccounts" #This is the topic type for Storage Account events
    tags = var.tags
}

#Event Grid Subscription to trigger the function app
resource "azurerm_eventgrid_system_topic_event_subscription" "event_subscription" {
  name                = var.event_grid_subscription_name
  system_topic        = azurerm_eventgrid_system_topic.storage_topic.name
  resource_group_name = var.resource_group_name


#Storage queue for function app
storage_queue_endpoint {
    storage_account_id = azurerm_storage_account.sa.id
    queue_name         = var.storage_queue_name
  }

#Only trigger on blob creation events
included_event_types = [
    "Microsoft.Storage.BlobCreated"
  ]

#Retry policy for event delivery
retry_policy {
        max_delivery_attempts = 5
        event_time_to_live    = 1440 # Time in minutes (24 hours)
    }


}

#Monitoring for Storage Account
resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
    name = var.monitoring_name
    target_resource_id = azurerm_storage_account.sa.id
    log_analytics_workspace_id = var.log_analytics_workspace_id

    enabled_log {
            category = "StorageWrite"
            }

}