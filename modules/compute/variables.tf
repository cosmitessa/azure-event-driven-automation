variable "resource_group_name" {
    description = "Name of resource group"
    type        = string
}

variable "location" {
    description = "Azure region for the resources"
    type        = string
}

variable "service_plan_name" {
    description = "Name of the service plan"
    type        = string
}

variable "tags" {
    description = "Tags for the resources"
    type        = map(string)
}

variable "app_service_name" {
    description = "Name of the app service"
    type        = string
}

variable "app_insights_name" {
    description = "Name of the Application Insights resource"
    type        = string
}

variable "log_analytics_workspace_id" {
    description = "ID of the Log Analytics workspace for Application Insights"
    type        = string
}

variable "storage_account_name" {
    description = "Name of the storage account for the function app"
    type        = string
}

variable "storage_account_access_key" {
    description = "Access key for the storage account used by the function app"
    type        = string
    sensitive   = true
}

variable "function_app_name" {
    description = "Name of the function app"
    type        = string
}

variable "storage_queue_name" {
    description = "Name of the storage queue for the function app"
    type        = string
}

variable "storage_account_connection_string" {
    description = "Connection string for the storage account used by the function app"
    type        = string
    sensitive   = true
}