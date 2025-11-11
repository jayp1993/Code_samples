
data "azurerm_key_vault" "key-vault-data" {
  name                = var.key_vault_name
  resource_group_name = var.resource_resouce_group
}

data "azurerm_key_vault_secret" "keyvault-secrate-username-data" {
  name         = var.secrate_username
  key_vault_id = data.azurerm_key_vault.key-vault-data.id
}

data "azurerm_key_vault_secret" "keyvault-secrate-password-data" {
  name         = var.secrate_password
  key_vault_id = data.azurerm_key_vault.key-vault-data.id
}

data "azurerm_public_ip" "pip-data" {
  name                = var.pip_name
  resource_group_name = var.resource_resouce_group
}
data "azurerm_subnet" "todo-subnet-data" {
  name                 = var.subnet_name
  virtual_network_name =var.vnet_name
  resource_group_name  = var.resource_resouce_group
}