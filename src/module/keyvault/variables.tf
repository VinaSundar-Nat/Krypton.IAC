variable location {}
variable group {}
variable tags {
  type = map(string)
}

variable sku {
  type        = string
  description = "az key vault sku- premium , standard"
  default     = "standard"
}

variable userPrincipal {}
variable servicePrincipal {}

variable key-permissions {
  description = "Managed identity / service principal key permissions"
}

variable secret-permissions {
  description = "Managed identity / service principal secret permissions"
}

variable cert-permissions {
  description = "Managed identity / service principal secret permissions"
}

variable create_vault{
  type        = bool
  description = "requires vault"
  default     = true
}