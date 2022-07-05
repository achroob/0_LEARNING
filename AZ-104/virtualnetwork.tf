resource "azurerm_virtual_network" "vnet" {
  address_space       = [var.VNET_ADDRESS]
  location            = var.RG_LOCATION
  name                = var.VNET_NAME
  resource_group_name = azurerm_resource_group.resource-group.name //to establish dependency
}

resource "azurerm_subnet" "sub1" {
  name                 = var.VNET_SUBNET1
  resource_group_name  = var.RG_NAME
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.VNET_SUBNET1_ADDRESS]
}

resource "azurerm_network_interface" "nic1" {
  location            = var.RG_LOCATION
  name                = var.VNET_SUBNET1_NIC1
  resource_group_name = azurerm_resource_group.resource-group.name

  ip_configuration {
    name                          = "ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.sub1.id
    public_ip_address_id          = azurerm_public_ip.demopubip.id
  }
}

resource "azurerm_public_ip" "demopubip" {
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.resource-group.location
  name                = var.VM_PUBLIC_IP
  resource_group_name = azurerm_resource_group.resource-group.name
}

resource "azurerm_network_security_group" "demonsg" {
  location            = var.RG_LOCATION
  name                = var.NSG_NAME
  resource_group_name = azurerm_resource_group.resource-group.name

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "Allow_port_80"
    priority                   = 100
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "Allow_port_22"
    priority                   = 200
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  network_security_group_id = azurerm_network_security_group.demonsg.id
  subnet_id                 = azurerm_subnet.sub1.id
}