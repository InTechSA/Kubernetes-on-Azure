provider "azurerm" {
  version = "1.35.0"
}

provider "azuread" {
  version = "0.6.0"
}

data "azurerm_subscription" "primary" {}

resource "random_pet" "random_name" {
  keepers   = {
    poc_name = var.poc-name
  }
  separator = ""
}

resource "azuread_application" "poc" {
  name = var.poc-name
}

resource "azuread_application_password" "poc" {
  value                 = var.client_secret
  end_date              = "2021-01-01T00:00:00Z"
  application_object_id = azuread_application.poc.id
}

resource "azuread_service_principal" "poc" {
  application_id = azuread_application.poc.application_id
}

resource "azurerm_role_assignment" "poc" {
  principal_id         = azuread_service_principal.poc.object_id
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "acr" {
  principal_id         = azuread_service_principal.poc.object_id
  scope                = azurerm_container_registry.poc.id
  role_definition_name = "AcrPull"
}

resource "azurerm_resource_group" "poc" {
  location = var.location
  name     = var.poc-name
}

resource "azurerm_virtual_network" "poc" {
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  name                = var.poc-name
  resource_group_name = azurerm_resource_group.poc.name

  subnet {
    address_prefix = "10.0.0.0/24"
    name           = var.poc-name
  }

  tags = {
    environment = "poc"
    maintainer  = var.author
  }
}

resource "azurerm_log_analytics_workspace" "poc" {
  location            = var.location
  name                = var.poc-name
  resource_group_name = azurerm_resource_group.poc.name
  sku                 = "PerGB2018"
  retention_in_days   = "30"
}

resource "azurerm_kubernetes_cluster" "poc" {
  dns_prefix          = var.poc-name
  location            = var.location
  name                = var.poc-name
  resource_group_name = azurerm_resource_group.poc.name
  kubernetes_version  = var.kubernetes_version

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    http_application_routing {
      enabled = true
    }
    kube_dashboard {
      enabled = true
    }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.poc.id
    }
  }

  agent_pool_profile {
    name            = "pocprofile"
    vm_size         = var.vm_size
    count           = var.vm_count
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = azuread_application.poc.application_id
    client_secret = azuread_application_password.poc.value
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.ssh_pub_key != "" ? var.ssh_pub_key : file("~/.ssh/id_rsa.pub")
    }
  }

  tags = {
    environment = "poc"
    maintainer  = var.author
  }
}

resource "azurerm_container_registry" "poc" {
  location            = var.location
  name                = "PoCRegistry${random_pet.random_name.id}"
  resource_group_name = azurerm_resource_group.poc.name
  sku                 = "basic"

  tags = {
    environment = "poc"
    maintainer  = var.author
  }
}