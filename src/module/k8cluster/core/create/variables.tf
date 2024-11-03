variable "create_cluster" {
  type        = bool
  description = "core cluster dns prefix"
  default     = true
}

variable group {}
variable location {}
variable subnet {}
variable tenant {}
variable adm {}
variable tags {
  type = map(string)
}
variable userManagedId {}


variable "dnsprefix" {
  type        = string
  description = "core cluster dns prefix"
  default     = "kr-verticle-core"
}

//https://prices.azure.com/api/retail/prices?api-version=2023-01-01-preview
//https://azure.microsoft.com/en-us/pricing/spot-advisor/
variable "vm-size" {
  type        = string
  description = "nodepool vm definition - required armSkuName"
}

variable "node-count" {
  type        = number
  description = "node count in pool"
  default     = 1
}

variable "lb-sku" {
  type        = string
  description = "az load balancer sku- basic , standard"
  default     = "standard"
}

variable "plugin" {
  type        = string
  description = "Options azure CNI and kubenet"
  default     = "azure"
}

variable "service-cidr" {
  type        = string
  description = "service cidr - must be different from subnet address prefix"
  default     = "10.1.0.0/16"
}

variable "dns-svc-ip" {
  type        = string
  description = "service cidr - must be different from subnet address prefix"
  default     = "10.1.0.11"
}

variable "pod-cidr" {
  type        = string
  description = "service cidr - must be different from subnet address prefix"
  default     = "10.244.0.0/16"
}

variable "max_pods"{
  type        = number
  description = "max number of pods that can be created"
  default     = 5
}

