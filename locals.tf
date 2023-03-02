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

  identity_block = var.identity_type == null ? null : {
    type          = var.identity_type
    identity_ids  = var.identity_type == "SystemAssigned" ? null : var.user_managed_identities
  }

  integrate_with_vnet = var.networking_config.virtual_network_configuration != null ? true : false
  vnet_integration    = var.networking_config.virtual_network_configuration

  vnet_rg             = local.integrate_with_vnet ? local.vnet_integration.virtual_network_resource_group_name : ""
  vnet_name           = local.integrate_with_vnet ? local.vnet_integration.virtual_network_name : ""
  vnet_subnet_name    = local.integrate_with_vnet ? local.vnet_integration.subnet_name : ""
  vnet_subnet_id      = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${local.vnet_rg}/providers/Microsoft.Network/virtualNetworks/${local.vnet_name}/subnets/${local.vnet_subnet_name}"
}