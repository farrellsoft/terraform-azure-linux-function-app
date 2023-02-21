
data azurerm_virtual_network this {
  count             = local.integrate_with_vnet == null ? 0 : 1

  name                = var.virtual_network_integration.virtual_network_name
  resource_group_name = var.virtual_network_integration.virtual_network_resource_group_name
}