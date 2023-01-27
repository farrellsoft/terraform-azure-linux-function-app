
output "function_apps" {
  value = { for k, v in azurerm_linux_function_app.this : k => {
    name                = v.name
    id                  = v.id
    hostname            = v.default_hostname
    object_id           = can(v.identity.0.principal_id) ? v.identity.0.principal_id : null
  } }
  description = "The Map of the Function Apps"
}