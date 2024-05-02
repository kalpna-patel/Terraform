data "azurerm_subnet" "data-blk" {
    for_each =var.nic-name
  name                 = each.value.name_sub
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
