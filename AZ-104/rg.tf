resource "azurerm_resource_group" "resource-group" {
  location = var.RG_LOCATION
  name     = var.RG_NAME
}

