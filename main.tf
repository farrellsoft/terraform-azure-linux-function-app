
provider azurerm {
  features {}
}

module "resource-naming" {
  source  = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version = "0.0.7"
  
  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
}

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
  }

  app_settings      = { for item in local.final_app_settings: item.name => item.value }
  dynamic "identity" {
    for_each = can(local.identity_block) ? [local.identity_block] : []
    content {
      type          = identity.value.type
      identity_ids  = identity.value.identity_ids
    }
  }
}
