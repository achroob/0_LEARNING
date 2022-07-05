variable "RG_NAME" {
  default = "demorg"
}

variable "RG_LOCATION" {
  default = "northeurope"
}

variable "VNET_ADDRESS" {
  default = "10.1.0.0/16"
}

variable "VNET_NAME" {
  default = "demovnet"
}

variable "VNET_SUBNET1" {
  default = "sub1"
}

variable "VNET_SUBNET1_NIC1" {
  default = "nic1"
}

variable "VNET_SUBNET1_ADDRESS" {
  default = "10.1.1.0/24"
}

variable "VM_NAME" {
  default = "demovm"
}

variable "VM_SIZE" {
  default = "Standard_D2_v3"
}

variable "VM_PWD" {
  description = "Enter password while configuring"
  sensitive   = true
}

variable "VM_USER" {
  default = "linuxusr"
}

variable "VM_PUBLIC_IP" {
  default = "demopubip"
}

variable "NSG_NAME" {
  default = "demonsg"
}

variable "INGRESS_PORTS" {
  type    = list(number)
  default = [80, 22]
}
