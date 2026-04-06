variable "resource_group_name" {
    description = "The name of the resource group"
    type = string
}

variable "location" {
    description = "The location of the resources"
    type = string
}

variable "tags" {
    description = "Tags to apply to resources"
    type = map(string)
  
}

variable "law_name" {
    description = "The name of the Log Analytics Workspace"
    type = string
}

