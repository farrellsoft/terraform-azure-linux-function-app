
terraform {
}

module "regioncodes" {
  source  = "app.terraform.io/Kyndryl-CIO/regioncodes/azurerm"
  version = "0.0.2"
}