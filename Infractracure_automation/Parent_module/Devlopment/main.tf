module "todo-rg" {
  source      = "../../Child_module/azurerm_resource_group"
  rg_name     = "dev-todo-rg"
  rg_location = "Central India"
}

module "todo-vnet" {
  depends_on          = [module.todo-rg]
  source              = "../../Child_module/azurerm_azure_network"
  vnet_name           = "dev-todo-vnet"
  vnet_location       = "Central India"
  resource_group_name = "dev-todo-rg"
  address_space       = ["10.10.10.0/24"]

}
#dard-1:Subnet frontend & backend ke lie alg-2 module bna rhe hai
module "todo-frontend-subnet" {
  depends_on           = [module.todo-vnet]
  source               = "../../Child_module/azurerm_subnet"
  subnet_name          = "dev-todo-frontend-subnet"
  resource_group_name  = "dev-todo-rg"
  virtual_network_name = "dev-todo-vnet"
  address_prefixes     = ["10.10.10.0/25"]
}

# module "todo-backend-subnet" {
#   depends_on           = [module.todo-vnet]
#   source               = "../../Child_module/azurerm_subnet"
#   subnet_name          = "dev-todo-backend-subnet"
#   resource_group_name  = "dev-todo-rg"
#   virtual_network_name = "dev-todo-vnet"
#   address_prefixes     = ["10.10.10.128/25"]
# }
#dard-1:Vm ke lie bhi alg-2 module bna rhe hai

module "todo_linux_frontendvm" {
  depends_on             = [module.todo-frontend-subnet]
  source                 = "../../Child_module/azurerm_Linux_virtual_machine"
  key_vault_name = "devopslocker0000"
  secrate_username = "vm-username"
  secrate_password = "vm-password"
  pip_name="todo-frontend-pip"
  subnet_name            = "dev-todo-frontend-subnet"
  vnet_name              = "dev-todo-vnet"
  todo_nic_name          = "todo_frontend_nic"
  location               = "Central India"
  resource_resouce_group = "dev-todo-rg"
  ip_configuration_name  = "ipconfig-frontendvm"
  todo_linux_vm_name = "todo-frontendvm"
  vm_size           = "Standard_B2s"
  publisher         = "canonical"                    #Publisher ID
  offer             = "0001-com-ubuntu-server-jammy" #Product ID
  sku               = "22_04-lts"                    #Plan ID
}

# module "todo_linux_backendvm" {
#   depends_on             = [module.todo-backend-subnet]
#   source                 = "../../Child_module/azurerm_Linux_virtual_machine"
#   key_vault_name = "todo-locker"
#   secrate_username = "todo-vm-username"
#   secrate_password = "todo-vm-password"
#   subnet_name            = "dev-todo-backend-subnet"
#   vnet_name              = "dev-todo-vnet"
#   pip_name = "todo-backend-pip"
#   todo_nic_name          = "todo_backend_nic"
#   location               = "Central India"
#   resource_resouce_group = "dev-todo-rg"
#   ip_configuration_name  = "ipconfig-backendvm"
#   todo_linux_vm_name     = "todo-backenddvm"
#   vm_size                = "Standard_B2s"
#   publisher              = "Canonical"                    #Publisher ID
#   offer                  = "0001-com-ubuntu-server-focal" #Product ID
#   sku                    = "20_04-lts"                    #Plan ID

# }

# module "mssql_server" {
#   depends_on = [ module.todo-rg ]
#   source                       = "../../Child_module/azurerm-mssql_server"
#   mssql_server_name            = "todo-mssqlsever0001"
#   resource_group_name          = "dev-todo-rg"
#   location                     = "Central India"
#   administrator_login          = "azureuser"
#   administrator_login_password = "Admin@123456"


# }

# module "mssql_database" {
#   depends_on         = [module.mssql_server]
#   source             = "../../Child_module/azurerm_mssql_database"
#   mysql_server_name = "todo-mssqlsever0001"
#   resource_group_name = "dev-todo-rg"
#   mssqldatabase_name = "todo-app-db02"
#   collation          = "SQL_Latin1_General_CP1_CI_AS"
#   license_type       = "LicenseIncluded"
#   max_size_gb        = 2
#   sku_name           = "Basic"
# }

module "todo-frontend-pip" {
  depends_on = [module.todo-rg  ]
  source              = "../../Child_module/azurerm_pip"
  pip_name            = "todo-frontend-pip"
  resource_group_name = "dev-todo-rg"
  location            = "Central India"
  allocation_method   = "Static"
}

# module "todo-backend-pip" {
#   depends_on = [ module.todo-rg ]
#   source              = "../../Child_module/azurerm_pip"
#   pip_name            = "todo-backend-pip"
#   resource_group_name = "dev-todo-rg"
#   location            = "Central India"
#   allocation_method   = "Static"

# }

module "kv" {
  depends_on = [module.todo-rg]
  source = "../../Child_module/azurerm_keyvault"
  kv_name = "devopslocker0000"
  location = "Central India"
  resouce_group_name = "dev-todo-rg"
}