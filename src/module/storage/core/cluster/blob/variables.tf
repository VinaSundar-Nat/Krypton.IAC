variable group {}
variable location {}
variable tier {}
variable kind {}
variable subnet {}
variable replication {}
variable tags {}
variable allowip {}

variable "bypasssettings" {
  type = list
  description = "any combination of Logging, Metrics, AzureServices, or None."
  default = ["Metrics"]
}

