resource "azurerm_public_ip" "pip" {
    for_each = var.pip-name
  name                = each.value.name-pip 
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}