variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for deployment"
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network"
}

variable "vnet_address_space" {
  type        = string
  description = "Address space for the VNet"
}

variable "subnet_map" {
  type        = map(string)
  description = "Map of subnet names to address prefixes"
}

variable "containerapp_env_name" {
  type        = string
  description = "Name of the Container App environment"
}

variable "containerapp_name" {
  type        = string
  description = "Name of the Container App"
}

variable "container_image" {
  type        = string
  description = "Docker image for the container app"
}

variable "container_port" {
  type        = number
  description = "Port the container listens on"
}

variable "application_gateway_name" {
  type        = string
  description = "Name of the Application Gateway"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID"
}
