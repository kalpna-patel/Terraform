resource "azurerm_linux_virtual_machine" "example" {
    for_each = var.vm-name
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.username[each.key].value
  admin_password = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.airtel-nic[each.key].id
  ]

 
  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}
data "azurerm_network_interface" "airtel-nic" {
    for_each = var.vm-name
  name                 = each.value.nic-name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "key-vault" {
    for_each = var.vm-name
  name                = "linux-vm-01-key"
  resource_group_name = "hcl-rg"
}

data "azurerm_key_vault_secret" "password" {
    for_each = var.vm-name
   name         = "password"
  key_vault_id = data.azurerm_key_vault.key-vault[each.key].id
}

data "azurerm_key_vault_secret" "username" {
    for_each = var.vm-name
name         = "username"
  key_vault_id = data.azurerm_key_vault.key-vault[each.key].id
}
