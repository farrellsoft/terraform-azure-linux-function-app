
output "name" {
  value = azurerm_linux_function_app.this.name
}

output id {
  value = azurerm_linux_function_app.this.id
}

output "default_hostname" {
  value = azurerm_linux_function_app.this.default_hostname
}

output "system_assigned_identity_id" {
  value = local.identity_block != null ? azurerm_linux_function_app.this.identity.0.principal_id : null
}