

resource "azurerm_network_interface" "todo-nic" {
  name                = var.todo_nic_name
  location            = var.location
  resource_group_name =var.resource_resouce_group

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.todo-subnet-data.id
    public_ip_address_id =data.azurerm_public_ip.pip-data.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "todo-linux-vm" {
  name                = var.todo_linux_vm_name
  resource_group_name = var.resource_resouce_group
  location            = var.location
  size                = var.vm_size
  admin_username      =data.azurerm_key_vault_secret.keyvault-secrate-username-data.value
  admin_password = data.azurerm_key_vault_secret.keyvault-secrate-password-data.value
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
custom_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "Welcome to Cloud Tech Hacks NGINX Server!" > /var/www/html/index.html
          EOF
  )

}