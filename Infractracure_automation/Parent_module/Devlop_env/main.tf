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


module "todo-frontendvm" {

source = "../../Child_module/azurerm_virtual_machine"
nic_name="dev-todo-frontendvm_nic"
nic_location = "Central India"
rg_name = "dev-todo-rg"
ip_config = "dev-todo-frontendvm-ipconfig1"
subnet_id = "/subscriptions/bd3dbcd1-3262-48f5-95f6-0a9c3f3411d3/resourceGroups/dev-todo-rg/providers/Microsoft.Network/virtualNetworks/dev-todo-vnet/subnets/dev-todo-frontend-subnet"
  vm_name = "dev-todo-frontendvm"
  vm_location = "Central India"
  vm_size = "Standard_F2"
  user_admin = "adminuser"
  vm_password = "Admin@123456"
  vm_image_offer = "0001-com-ubuntu-server-jammy"
  vm_image_publisher = "canonical"
  vm_image_sku = "22_04-lts-ARM"
  
}

module "todo-backendvm" {

source = "../../Child_module/azurerm_virtual_machine"
nic_name="dev-todo-backend_nic"
nic_location = "Central India"
rg_name = "dev-todo-rg"
ip_config = "dev-todo-frontendvm-ipconfig2"
subnet_id = "/subscriptions/bd3dbcd1-3262-48f5-95f6-0a9c3f3411d3/resourceGroups/dev-todo-rg/providers/Microsoft.Network/virtualNetworks/dev-todo-vnet/subnets/dev-todo-backend-subnet"
  vm_name = "dev-todo-backendvm"
  vm_location = "Central India"
  vm_size = "Standard_F2"
  user_admin = "adminuser"
  vm_password = "Admin@123456"
  vm_image_offer = "0001-com-ubuntu-pro-focal"
  vm_image_publisher = "canonical"
  vm_image_sku = "pro-20_04-lts"
  
}