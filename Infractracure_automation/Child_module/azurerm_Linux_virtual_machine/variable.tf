variable "key_vault_name" {
  type = string
  
}
variable "secrate_username" {
  type = string
  
}
variable "secrate_password" {
  
}
variable "subnet_name" {
  type = string
}
variable "vnet_name" {
  type = string
  
}
variable "pip_name" {
  type = string
  description = "ye public ip ka variable hai"
  
}
variable "todo_nic_name" {
    type = string
  
}

variable "location" {
  type = string
}

variable "resource_resouce_group" {
    type = string
  
}
variable "ip_configuration_name" {
  type = string
}


variable "todo_linux_vm_name" {
    type = string
  
}

variable "vm_size" {
    type = string
  
}

variable "publisher" {
    type = string
  
}
variable "offer" {
  type = string
}

variable "sku" {
  type = string
}