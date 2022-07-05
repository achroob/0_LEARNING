resource "azurerm_virtual_machine" "demovm" {
  location              = azurerm_resource_group.resource-group.location
  name                  = var.VM_NAME
  network_interface_ids = [azurerm_network_interface.nic1.id]
  resource_group_name   = azurerm_resource_group.resource-group.name
  vm_size               = var.VM_SIZE

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    create_option     = "FromImage"
    name              = "osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
  }

  os_profile {
    computer_name  = var.VM_NAME
    admin_username = var.VM_USER
    admin_password = var.VM_PWD
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}