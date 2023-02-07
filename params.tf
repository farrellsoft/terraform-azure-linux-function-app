variable function_app {
  type          = object({
    resource_group_name               = string
    application                       = string
    location                          = string
    storage_account_name              = string
    storage_account_access_key        = string
    service_plan_id                   = string
    enable_system_identity            = optional(bool, false)
    application_insights_key          = optional(string, null)
    run_from_package                  = optional(bool, true)

    dotnet_version                    = optional(string, "6.0")
    always_on                         = optional(bool, false)
    app_settings                      = optional(list(object({
      name                        = string
      value                       = string
    })), [])
  })
  description   = "Linux Function App"
}