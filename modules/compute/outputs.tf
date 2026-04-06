output "app_service_id" {
  value = azurerm_service_plan.service_plan.id
}

output "function_app_id" {
  value = azurerm_linux_function_app.function_app.id
}

output "function_app_identity_principal_id" {
  value = azurerm_linux_function_app.function_app.identity[0].principal_id
}
