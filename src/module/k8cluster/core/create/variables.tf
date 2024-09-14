variable group {}
variable location {}
variable tags {}
variable subnet {}
variable tenant {}
variable adm {}


variable "dnsprefix" {
  type        = string
  description = "core cluster dns prefix"
  default     = "kr-verticle-core"
}

variable "vm-size" {
  type        = string
  description = "nodepool vm definition - https://cloudprice.net/?timeoption=month"
  default     = "standard_b2pls_v2"
}

variable "node-count" {
  type        = number
  description = "node count in pool"
  default     = 2
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

