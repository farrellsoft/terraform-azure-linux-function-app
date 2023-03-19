terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}

data azurerm_client_config current {}
module "resource-naming" {
  source  = "app.terraform.io/Farrellsoft/resource-naming/azure"
  version = "0.0.9"
  
  application         = var.application
  environment         = var.environment
  instance_number     = var.instance_number
}

locals {
  resource_group_id     = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}"
}

resource azapi_resource this {
  type            = "Microsoft.Web/sites@2022-03-01"
  name            = module.resource-naming.function_app_name
  parent_id       = local.resource_group_id
  location        = var.location

  body            = jsonencode({
    kind            = "functionapp,linux"
    properties      = {
      httpsOnly                   = false
      reserved                    = true
      serverFarmId                = var.service_plan_id
      #vnetName                    = var.networking_config.virtual_network_configuration.virtual_network_name
      virtualNetworkSubnetId      = local.vnet_subnet_id
      vnetContentShareEnabled     = true
      siteConfig        = {
        appSettings       = [
          {
            name  = "AzureWebJobsStorage",
            value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account.name};AccountKey=${var.storage_account.access_key};EndpointSuffix=core.windows.net"
          },
          {
            name  = "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING",
            value = "DefaultEndpointsProtocol=https;AccountName=${var.storage_account.name};AccountKey=${var.storage_account.access_key};EndpointSuffix=core.windows.net"
          },
          {
            name  = "FUNCTIONS_WORKER_RUNTIME",
            value = "dotnet"
          },
          {
            name  = "FUNCTIONS_EXTENSION_VERSION",
            value = "~4"
          },
          {
            name  = "WEBSITE_CONTENTSHARE",
            value = "privateapp-dev"
          }
        ],
        linuxFxVersion  = "DOTNET|6.0"
      }
    }
  })
}

#module "private-endpoint" {
#  source            = "../terraform-azure-private-endpoint"
#  count             = length(var.private_endpoints)
#
#  application         = var.application
#  environment         = var.environment
#  instance_number     = var.instance_number
#  subnet_id           = var.private_endpoints[count.index].subnet_id
#  resource_group_name = var.private_endpoints[count.index].resource_group_name
#  resource_type       = "functionapp"
#
#  private_connections = {
#    functionapp = {
#      resource_id           = azurerm_linux_function_app.this.id
#      subresource_names     = [ "sites" ]
#      purpose               = var.private_endpoints[count.index].purpose
#      private_dns_zone_id   = var.private_endpoints[count.index].private_dns_zone_id
#    }
#  }
#}
