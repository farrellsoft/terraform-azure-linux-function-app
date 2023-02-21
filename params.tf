
variable application {
  type = string
  validation {
    condition     = length(var.application) > 3
    error_message = "${var.application} must be a minimum of three (3) characters."
  }
}

variable environment {
  type = string
  validation {
    condition     = length(var.environment) == 3
    error_message = "${var.environment} must be three (3) characters."
  }
}

variable instance_number {
  type = string
  validation {
    condition     = can(regex("^[0-9]{3}$", var.instance_number))
    error_message = "${var.instance_number} must be three (3) numbers."
  }
  default   = "001"
}

variable location {
  type        = string
  description = "The location where the resources will be created."
}

variable resource_group_name {
  type        = string
  description = "The name of the resource group in which to create the resources."
}

variable storage_account {
  type = object({
    name        = string
    access_key  = string
  })
  description = "The storage account to use for the function app."
}

variable service_plan_id {
  type        = string
  description = "The ID of the App Service Plan to use for the function app."
}

variable identity_type {
  type        = string
  description = "The type of identity to use for the function app."
  default     = null

  validation {
    condition     = can(regex("^(SystemAssigned|UserAssigned)$", var.identity_type))
    error_message = "${var.identity_type} must be either SystemAssigned or UserAssigned."
  }
}

variable user_managed_identities {
  type        = list(string)
  description = "The list of user managed identities to use for the function app."
  default     = []
}

variable application_insights_key {
  type        = string
  description = "The key of the Application Insights instance to use for the function app."
  default     = null
}

variable app_settings {
  type        = list(object({
    name  = string
    value = string
  }))
  description = "The list of application settings to use for the function app."
  default     = []
}

variable run_from_package {
  type          = bool
  description   = "Whether to use a run from package deployment for the function app."
  default       = false
}

variable virtual_network_integration {
  type                = object({
    subnet_name                           = string
    virtual_network_name                  = string
    virtual_network_resource_group_name   = string
  })
  description        = "The virtual network integration to use for the function app."
  default            =  null
}