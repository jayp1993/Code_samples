variable "subnet_name" {
  type = string
}
variable "vnet_name" {
  type = string
  
}
variable "pip_name" {
  type = string
  
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

variable "vm_admin_user" {
    type = string
  
}

variable "vm_admin_password" {
  
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