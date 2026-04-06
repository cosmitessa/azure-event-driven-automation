output "storage_account_id" {
    description = "ID of the Storage Account"
    value       = azurerm_storage_account.sa.id
}

output "storage_container_id" {
    description = "ID of the Storage Container"
    value       = azurerm_storage_container.sc.id
}

output "storage_account_name" {
    description = "Name of the Storage Account"
    value       = azurerm_storage_account.sa.name
}

output "storage_account_access_key" {
    description = "Access key for the Storage Account"
    value       = azurerm_storage_account.sa.primary_access_key
    sensitive   = true
}

output "storage_queue_name" {
    description = "Name of the Storage Queue"
    value       = azurerm_storage_queue.sq.name
}

output "storage_queue_id" {
    description = "ID of the Storage Queue"
    value       = azurerm_storage_queue.sq.id
}

output "event_grid_subscription_id" {
    description = "ID of the Event Grid Subscription"
    value       = azurerm_eventgrid_system_topic_event_subscription.event_subscription.id
}

output "storage_account_connection_string" {
    description = "Connection string for the Storage Account"
    value       = azurerm_storage_account.sa.primary_connection_string
    sensitive   = true
}