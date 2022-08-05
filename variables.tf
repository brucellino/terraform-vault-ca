# Vault CA variables.tf
variable "ca_name" {
  type        = string
  description = "Name of the CA secrets engine"
  default     = "CA_mod"
}

variable "ca_mount_path" {
  type        = string
  description = "Mount path of the CA PKI secrets engine"
  default     = "pki_module"
}
