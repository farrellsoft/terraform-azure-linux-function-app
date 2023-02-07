
resource azurerm_linux_function_app this {
  name                        = "func-${var.function_app.application}"
  location                    = var.function_app.location
  resource_group_name         = var.function_app.resource_group_name
  storage_account_name        = var.function_app.storage_account_name
  storage_account_access_key  = var.function_app.storage_account_access_key
  service_plan_id             = var.function_app.service_plan_id
  https_only                  = true

  site_config {
    always_on               = var.function_app.always_on
    application_stack {
      dotnet_version    = var.function_app.dotnet_version
    }
  }

  app_settings      = { for item in local.final_app_settings: item.name => item.value }
  dynamic "identity" {
    for_each          = var.function_app.enable_system_identity == false ? [] : [{}]

    content {
      type          = "SystemAssigned"
    }
  }
}
