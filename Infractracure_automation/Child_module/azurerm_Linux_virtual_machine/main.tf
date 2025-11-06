resource "azurerm_network_interface" "todo-nic" {
  name                = var.todo_nic_name
  location            = var.location
  resource_group_name =var.resource_resouce_group

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "todo-linux-vm" {
  name                = var.todo_linux_vm_name
  resource_group_name = var.resource_resouce_group
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_user
  admin_password = var.vm_admin_password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.todo-nic.id] #implic dependancies
#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}