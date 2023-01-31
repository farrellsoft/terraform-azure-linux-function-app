
resource azurerm_linux_function_app this {
  for_each            = var.function_apps
  
  name                        = local.app_names_map[each.key]
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  storage_account_name        = each.value.storage_account_name
  storage_account_access_key  = each.value.storage_account_access_key
  service_plan_id             = each.value.service_plan_id

  site_config {
    always_on               = each.value.always_on
    httpsOnly               = true
    ftpsState               = "FtpsOnly"
    application_stack {
      dotnet_version    = each.value.dotnet_version
    }
  }

  app_settings      = { for item in each.value.app_settings: item.name => item.value }
  dynamic "identity" {
    for_each          = local.system_identity_map[each.key] == false ? [] : [{}]

    content {
      type          = "SystemAssigned"
    }
  }
}