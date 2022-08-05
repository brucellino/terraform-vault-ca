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

variable "ou" {
  type        = string
  description = "Organizational Unit name"
  default     = "CA OU"
}

variable "org" {
  type        = string
  description = "Description of the organization"
  default     = "Default Organization"
}

variable "cn" {
  type        = string
  description = "Common Name of the certificate being issued. Should be a fqdn"
  default     = "test.local"
}
