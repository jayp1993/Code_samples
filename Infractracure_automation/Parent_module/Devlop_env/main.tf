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

module "todo-frontend-subnet" {
  depends_on           = [module.todo-vnet]
  source               = "../../Child_module/azurerm_subnet"
  subnet_name          = "dev-todo-frontend-subnet"
  resource_group_name  = "dev-todo-rg"
  virtual_network_name = "dev-todo-vnet"
  address_prefixes     = ["10.10.10.0/25"]
}

module "todo-backend-subnet" {
  depends_on           = [module.todo-vnet]
  source               = "../../Child_module/azurerm_subnet"
  subnet_name          = "dev-todo-backend-subnet"
  resource_group_name  = "dev-todo-rg"
  virtual_network_name = "dev-todo-vnet"
  address_prefixes     = ["10.10.10.128/25"]
}

module "todo_linux_frontendvm" {
  source = "../../Child_module/azurerm_Linux_virtual_machine"
  todo_nic_name="todo_forntend_nic"
  location="Central India"
 resource_resouce_group="dev-todo-rg"
 ip_configuration_name="ipconfig-frontendvm"
 subnet_id="/subscriptions/bd3dbcd1-3262-48f5-95f6-0a9c3f3411d3/resourceGroups/dev-todo-rg/providers/Microsoft.Network/virtualNetworks/dev-todo-vnet/subnets/dev-todo-frontend-subnet"
 todo_linux_vm_name="todo-frontendvm"
 vm_size="Standard_B2s"
 vm_admin_user="azureuser"
 vm_admin_password="Admin@123456"
 publisher="canonical"  #Publisher ID
 offer="0001-com-ubuntu-server-jammy" #Product ID
 sku="22_04-lts" #Plan ID

}

module "todo_linux_backendvm" {
  source = "../../Child_module/azurerm_Linux_virtual_machine"
  todo_nic_name="todo_backend_nic"
  location="Central India"
 resource_resouce_group="dev-todo-rg"
 ip_configuration_name="ipconfig-backendvm"
 subnet_id="/subscriptions/bd3dbcd1-3262-48f5-95f6-0a9c3f3411d3/resourceGroups/dev-todo-rg/providers/Microsoft.Network/virtualNetworks/dev-todo-vnet/subnets/dev-todo-backend-subnet"
 todo_linux_vm_name="todo-backenddvm"
 vm_size="Standard_B2s"
 vm_admin_user="azureuser"
 vm_admin_password="Admin@123456"
 publisher="Canonical"  #Publisher ID
 offer="0001-com-ubuntu-server-focal" #Product ID
 sku="20_04-lts" #Plan ID

}

module "mssql_server" {
  source = "../../Child_module/azurerm-mssql_server"
mssql_server_name="todo-mssqlsever0001"
resource_group_name = "dev-todo-rg"
location = "Central India"
administrator_login = "azureuser"
administrator_login_password = "Admin@123456"

  
}

module "mssql_dabase" {
source = "../../Child_module/azurerm_mssql_database"
  mssqldatabase_name = "todo-app-db02"
  mssql_server_id = "/subscriptions/bd3dbcd1-3262-48f5-95f6-0a9c3f3411d3/resourceGroups/dev-todo-rg/providers/Microsoft.Sql/servers/todo-mssqlsever0001"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  license_type =  "LicenseIncluded"
  max_size_gb = 2
  sku_name = "Basic"
}


