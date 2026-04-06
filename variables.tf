# Monitoring variables
variable "law_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

# Storage variables
variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "storage_container_name" {
  description = "Name of the Storage Container"
  type        = string
}

variable "event_grid_subscription_name" {
  description = "Name of the Event Grid Subscription"
  type        = string
}

variable "event_grid_topic_name" {
  description = "Name of the Event Grid Topic"
  type        = string
}

variable "storage_queue_name" {
  description = "Name of the Storage Queue"
  type        = string
}

#Compute variables
variable "app_service_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
}

variable "app_insights_name" {
  description = "Name of the Application Insights instance"
  type        = string
}

variable "service_plan_name" {
  description = "Name of the Service Plan"
  type        = string
}
