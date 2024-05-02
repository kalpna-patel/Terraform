resource "azurerm_network_interface" "nic" {
for_each = var.nic-name
  name                =each.value.name
  location            =each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.nameipconfig
    subnet_id                     = data.azurerm_subnet.data-blk[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}


