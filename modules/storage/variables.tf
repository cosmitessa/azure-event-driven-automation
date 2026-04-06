variable "storage_account_name" {
    description = "Name of the Storage Account"
    type        = string
}
variable "resource_group_name" {
    description = "Name of the Resource Group"
    type        = string
}
variable "location" {
    description = "Azure Region"
    type        = string
}
variable "tags" {
    description = "Tags to be applied to all resources"
    type        = map(string)
}

variable "storage_container_name" {
    description = "Name of the Storage Container"
    type        = string
}

variable "monitoring_name" {
    description = "Name of the monitoring resource"
    type = string
}

variable "log_analytics_workspace_id" {
    description = "ID of the Log Analytics workspace"
    type = string
}

variable "event_grid_topic_name" {
    description = "Name of the Event Grid System Topic"
    type = string
}

variable "storage_queue_name" {
    description = "Name of the Storage Queue"
    type        = string
}


variable "event_grid_subscription_name" {
    description = "Name of the Event Grid Subscription"
    type        = string
}

