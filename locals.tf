locals {
  app_names_map = {
    for k, v in var.function_apps : k =>
      "func-${v["application"]}-${v["environment"]}-${v["instance"] == "" ? "" : "-${v["instance"]}"}"
  }

  system_identity_map = {
    for k, v in var.function_apps : k => v.enable_system_identity
  }

  default_app_settings = [
    {
      name    = "WEBSITE_RUN_FROM_PACKAGE"
      value   = "1"
    }
  ]
}