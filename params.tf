
variable function_apps {
  type          = map(object({
    resource_group_name               = string
    application                       = string
    purpose                           = optional(string, "")
    environment                       = string
    instance                          = optional(string, "")
    location                          = string
    storage_account_name              = string
    storage_account_access_key        = string
    service_plan_id                   = string

    dotnet_version                    = optional(string, "6.0")
    always_on                         = optional(bool, false)
    app_settings                      = optional(list(object({
      name                        = string
      value                       = string
    })), [])
  }))
  description   = "Linux Function Apps"
}