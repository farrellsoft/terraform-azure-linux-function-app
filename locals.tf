locals {
  run_from_package_app_settings = var.run_from_package == false ? [] : [
    {
      name    = "WEBSITE_RUN_FROM_PACKAGE"
      value   = "1"
    }
  ]

  application_insights_app_settings = can(var.application_insights_key) == false ? [] : [
    {
      name    = "APPINSIGHTS_INSTRUMENTATIONKEY"
      value   = var.application_insights_key
    }
  ]

  final_app_settings = concat(
    var.app_settings,
    local.run_from_package_app_settings,
    local.application_insights_app_settings
  )

  identity_block = can(var.identity_type) == false ? null : {
    type          = var.identity_type
    identity_ids  = var.identity_type == "SystemAssigned" ? null : var.user_managed_identities
  }
}