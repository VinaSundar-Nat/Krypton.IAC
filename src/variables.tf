variable "kr-naming-prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "kr"
}

variable "CREATE_CLUSTER" {
  type        = bool
  description = "Variable decides if cluster can be created"
}

variable "CREATE_VAULT" {
  type        = bool
  description = "Variable decides if cluster can be created"
}


/*Auth Definitions*/

variable "AZ_CLIENT_ID" {
  type        = string
  description = "az sp client id"
  sensitive   = true
}

variable "AZ_TENNENT_ID" {
  type        = string
  description = "az sp tennent id"
  sensitive   = true
}

variable "AZ_CERT_PASSWORD" {
  type        = string
  description = "az cert pass"
  sensitive   = true
}

variable "AZ_CERT_PATH" {
  type        = string
  description = "az cert path"
  sensitive   = true
}

variable "AZ_SUBSCRIPTION" {
  type        = string
  description = "az sp client id"
  sensitive   = true
}

/*End*/

/*Tag Definitions*/

variable "owner" {
  type        = string
  description = "Owner email address"
  default     = "vinasundar.kr@hotmail.com"
}

variable "source_system" {
  type        = string
  description = "Source system deployment profile"
  default     = "krypton"
}

variable "division" {
  type        = string
  description = "division profile"
  default     = "krypton.ops"
}

/*End*/

variable "az-location" {
  type        = map(string)
  description = "locations definitions specfic to env"
}

variable "az-nsg-sourceip" {
  type        = map(string)
  description = "Source IP definition for upstream inbound requests - service cluster"
}

/*AZ Network */

variable "az-vnet-address" {
  type        = map(string)
  description = "vent address space"
}

variable "az-src-endpoints" {
  type    = list(string)
  default = ["Microsoft.AzureCosmosDB", "Microsoft.Storage", "Microsoft.KeyVault"]
}

/*End*/

/*AZ Key management  */
variable "az-vault-retention" {
  type        = map(string)
  description = "vault retention period specfic to env"
}

variable "az-vault-purge" {
  type        = bool
  description = "storage replication specfic to env (Local , zone, Geo Local (R), Geo Zone (R))"
  default     = true
}

/*End*/


/*AZ Data Source */

variable "az-cosmos-offer" {
  type        = string
  description = "az cosmos db offer type (standard,autoscale)"
  default     = "Standard"
}

variable "az-cosmos-consistency" {
  type        = map(string)
  description = "consistency levels specfic to environment (Strong,BoundedStaleness,Session,ConsistentPrefix,Eventual)."
}

/*End*/

/*AZ Storage */

variable "az-storage-tier" {
  type        = map(string)
  description = "az storage tier (Standard,Premium)"
}

variable "az-storage-kind" {
  type        = string
  description = "az storage kind (BlobStorage,BlockBlobStorage,FileStorage,StorageV2)"
  default     = "StorageV2"
}

variable "az-storage-replication" {
  type        = map(string)
  description = "az storage repliction (Standard,Premium)"
}

variable "az-storage-allowrule" {
  type        = map(list(string))
  description = "Public IPs allowed to view / access storage"
}

/*End*/

/*AZ AKS */
variable "aks_max_pods" {
  type        = map(number)
  description = "aks max pods"
}

variable "aks-vm-size" {
  type        = map(string)
  description = "size of the vm"
}

variable "az-keyvault-key-perm" {
  type        = map(list(string))
  description = "Key vault key permissions"
}

variable "az-keyvault-sec-perm" {
  type        = map(list(string))
  description = "Key vault secret permissions"
}

variable "az-keyvault-cert-perm" {
  type        = map(list(string))
  description = "Key vault cert permissions"
}