
resource azurerm_linux_function_app this {
  for_each            = var.function_apps
  
  name                        = "func-app-test-jx01" //local.app_names_map[each.key]
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  storage_account_name        = "stobwebhooksboxkdr" //each.value.storage_account_name
  storage_account_access_key  = "HQot5/TNuhtBhMgvhWLWZp+gnIGCiEVje8fLL8c8+Q/LmuwTo3etsSBvWKCLQ4Dj2nPjGvpk/flj+ASt+xi/Cg==" //each.value.storage_account_access_key
  service_plan_id             = "/subscriptions/3c1d6a50-2633-40d2-9b1a-81673a7493a1/resourceGroups/rg-onboarding-webhook/providers/Microsoft.Web/serverfarms/plan-obwebhook-sbox-eus" //each.value.service_plan_id

  site_config {
    always_on               = each.value.always_on
    application_stack {
      dotnet_version    = each.value.dotnet_version
    }
  }

  app_settings      = { for item in each.value.app_settings: item.name => item.value }
}