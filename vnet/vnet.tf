resource "azurerm_virtual_network" "vnet-name" {
    for_each = var.vnet-name
  name                = each.value.name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}