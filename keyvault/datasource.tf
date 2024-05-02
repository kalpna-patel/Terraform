data "azurerm_key_vault" "key-vault" {
    for_each = var.key-name
    name                = "linux-vm-01-key"
  resource_group_name = "hcl-rg"
}

data "azurerm_key_vault_secret" "password" {
    for_each = var.key-name
   name         = "password"
  key_vault_id = data.azurerm_key_vault.key-vault[each.key].id
}

data "azurerm_key_vault_secret" "username" {
    for_each = var.key-name
name         = "username"
  key_vault_id = data.azurerm_key_vault.key-vault[each.key].id
}