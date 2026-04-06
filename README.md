# Project Walkthrough

This project includes an automated, serverless infrastructure blueprint for Azure. It demonstrates a highly decoupled, event-driven architecture that triggers compute processes based on real-time data ingestion.

I built this to demonstrate how to handle asynchronous workloads in Azure. Most people just trigger a function from a blob, but that doesn't scale well. I introduced Event Grid and a Storage Queue to provide a buffer for load leveling. I also focused heavily on Security and Observability, using Managed Identities for RBAC and Application Insights to trace the full lifecycle of a transaction.

I used `terraform-docs` to ensure the infrastructure is self-documenting. Every variable has a clear description and type, making it easy for other engineers to consume these modules as a library.

### Architecture Overview

The system follows a producer-consumer pattern to ensure high availability and load leveling:

1. Ingestion: A file is uploaded to an Azure Storage Blob Container.
2. Observation: An Event Grid System Topic monitors the Storage Account for `BlobCreated` events.
3. Buffering: Event Grid pushes the event metadata into an Azure Storage Queue. This acts as a buffer to protect downstream services from traffic spikes.
4. Processing: A Linux Function App (Python) is triggered by the queue message to process the image.
5. Observability: All logs and metrics are aggregated into Log Analytics and Application Insights.

### ## WHY USE A QUEUE INSTEAD OF TRIGGERING THE FUNCTION DIRECTLY?

Using a Queue also allows for Dead Lettering. If the Function App fails to process an image, the message remains in the queue (or moves to a sub-queue) for retries, rather than the event being lost forever in a direct trigger failure.

- Direct Trigger: If 10,000 people upload photos at once, 10,000 Functions start immediately. This can crash your database or hit your API limits.
- Queue Trigger (Load Leveling) : The 10,000 events sit safely in the Queue. The Function picks them up at its own pace (e.g., 50 at a time).  This ensures the architecture remains resilient during traffic spikes and prevents downstream service exhaustion.

## Engineering Challenges & Lessons

Challenge: Encountered `403 AuthorizationFailed` errors during deployment when assigning RBAC roles. 
 
 Solution: I implemented a Least Privilege model. Instead of using the 'Owner' role for the application, I assigned the specific `Storage Blob Data Reader` and `Storage Queue Data Message Processor` roles to the Function's Managed Identity. 

## Observability & Monitoring

The infrastructure includes a complete monitoring stack:
- Storage Diagnostics: Captures `StorageWrite` operations to track ingestion.
- App Insights: Provides a distributed trace of the event journey from the container to the processor.

# Terraform Docs

```bash

terraform-docs markdown table --output-file README.md --output-mode inject .

```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.8.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute"></a> [compute](#module\_compute) | ./modules/compute | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ./modules/monitoring | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.blob_reader](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.queue_receiver](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_insights_name"></a> [app\_insights\_name](#input\_app\_insights\_name) | Name of the Application Insights instance | `string` | n/a | yes |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | Name of the App Service Plan | `string` | n/a | yes |
| <a name="input_event_grid_subscription_name"></a> [event\_grid\_subscription\_name](#input\_event\_grid\_subscription\_name) | Name of the Event Grid Subscription | `string` | n/a | yes |
| <a name="input_event_grid_topic_name"></a> [event\_grid\_topic\_name](#input\_event\_grid\_topic\_name) | Name of the Event Grid Topic | `string` | n/a | yes |
| <a name="input_function_app_name"></a> [function\_app\_name](#input\_function\_app\_name) | Name of the Function App | `string` | n/a | yes |
| <a name="input_law_name"></a> [law\_name](#input\_law\_name) | Name of the Log Analytics Workspace | `string` | n/a | yes |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | Name of the Service Plan | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the Storage Account | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | Name of the Storage Container | `string` | n/a | yes |
| <a name="input_storage_queue_name"></a> [storage\_queue\_name](#input\_storage\_queue\_name) | Name of the Storage Queue | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->