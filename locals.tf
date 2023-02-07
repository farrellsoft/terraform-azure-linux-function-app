locals {
  run_from_package_app_settings = var.function_app.run_from_package == false ? [] : [
    {
      name    = "WEBSITE_RUN_FROM_PACKAGE"
      value   = "1"
    }
  ]

  application_insights_app_settings = can(var.function_app.application_insights_key) == false ? [] : [
    {
      name    = "APPINSIGHTS_INSTRUMENTATIONKEY"
      value   = var.function_app.application_insights_key
    }
  ]

  final_app_settings = concat(
    var.function_app.app_settings,
    local.run_from_package_app_settings,
    local.application_insights_app_settings
  )
}