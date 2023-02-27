
data azurerm_virtual_network this {
  count             = local.integrate_with_vnet == false ? 0 : 1

  name                = var.networking_config.virtial_network_configuration.virtual_network_name
  resource_group_name = var.networking_config.virtial_network_configuration.virtual_network_resource_group_name
}