
module "resource-naming" {
  source  = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version = "0.0.7"
  
  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
}

data "azurerm_client_config" "current" {}

resource azurerm_linux_function_app this {
  name                        = module.resource-naming.function_app_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  
  storage_account_name        = var.storage_account.name
  storage_account_access_key  = var.storage_account.access_key
  service_plan_id             = var.service_plan_id
  https_only                  = true

  site_config {
    always_on               = false
    application_stack {
      dotnet_version    = "6.0"
    }
    vnet_route_all_enabled = local.integrate_with_vnet ? local.vnet_integration.route_all_enabled : null

    dynamic "ip_restriction" {
      for_each = var.networking_config.allow_public_access ? [] : [{}]
      content {
        action = "Deny"
        name   = "Deny Public Access"
      }
    }
  }

  virtual_network_subnet_id     = local.integrate_with_vnet ? local.vnet_subnet_id : null
  app_settings                  = { for item in local.final_app_settings: item.name => item.value }
  
  dynamic "identity" {
    for_each = local.identity_block != null ? [local.identity_block] : []
    content {
      type          = identity.value.type
      identity_ids  = identity.value.identity_ids
    }
  }
}
