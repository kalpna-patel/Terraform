# resource "azurerm_subnet" "subnet" {
#     for_each = var.bst-name
#   name                 = each.value.name
#   resource_group_name  = each.value.resource_group_name
#   virtual_network_name = each.value.virtual_network_name
#   address_prefixes     = each.value.address_prefixes
# }

# resource "azurerm_public_ip" "pip" {
#     for_each = var.pip-name
#   name                = each.value.name-pip
#   location            = each.value.location
#   resource_group_name =each.value.resource_group_name
#   allocation_method   = each.value.allocation_method
#   sku                 = each.value.sku
# }

resource "azurerm_bastion_host" "example" {
    for_each = var.bst-name
  name                = each.value.name-bst 
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.nameip
    subnet_id            = data.azurerm_subnet.bastion-subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
  }
}

data "azurerm_subnet" "bastion-subnet" {
    for_each = var.bst-name
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
    for_each = var.bst-name
name                = "airtel-pip"
  resource_group_name = "hcl-rg"
}