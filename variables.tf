# Vault CA variables.tf
variable "ca_name" {
  type        = string
  description = "Name of the CA secrets engine"
  default     = "CA_mod"
}

variable "root_ca_mount_path" {
  type        = string
  description = "Mount path of the CA PKI secrets engine"
  default     = "pki/test/pki_module/root_ca"
}

variable "intermediate_ca_mount_path" {
  type        = string
  description = "Mount path of the Intermediate CA PKI secrets engine"
  default     = "pki/test/pki_module/int_ca"
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

variable "root_cn" {
  type        = string
  description = "Common Name of the root certificate being issued"
  default     = "Root CA cn"
}

variable "intermediate_cn" {
  type        = string
  description = "Common Name of the certificate being issued"
  default     = "Intermediate CA cn"
}
