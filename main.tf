# Main definition
# Follows https://learn.hashicorp.com/tutorials/vault/pki-engine?in=vault/secrets-management

# Policy requirements
resource "vault_policy" "main" {
  name = "ca-policy-${var.ca_name}"
  policy = templatefile("${path.module}/policies/ca-root.hcl.tmpl", {
    root_ca_mount_path         = var.root_ca_mount_path,
    intermediate_ca_mount_path = var.intermediate_ca_mount_path
    }
  )
}

# Step 1.1 - 1.2 - Create Root CA mount path
resource "vault_mount" "root_ca" {
  path        = var.root_ca_mount_path
  type        = "pki"
  description = "Root CA for ${var.ca_name}"

  default_lease_ttl_seconds = 3600
  # Step 1.2 - tune secrets backend
  max_lease_ttl_seconds = 87600

}

# Step 1.3 - generate Root CA cert
resource "vault_pki_secret_backend_root_cert" "root" {
  depends_on           = [vault_mount.root_ca]
  backend              = vault_mount.root_ca.path
  type                 = "internal"
  common_name          = var.root_cn
  country              = "IT"
  locality             = "Catania"
  ttl                  = 3153600
  format               = "pem"
  private_key_format   = "der" # pragma: allowlist secret
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  ou                   = var.ou
  organization         = var.org
}

resource "vault_pki_secret_backend_role" "role" {
  backend          = vault_mount.root_ca.path
  name             = "test_role"
  ttl              = 3600
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = [var.root_cn]
  allow_subdomains = true
}


# Step 7
resource "vault_pki_secret_backend_config_urls" "root" {
  backend = vault_mount.root_ca.path
  issuing_certificates = [
    "http://192.168.1.16:8200/v1/${vault_mount.root_ca.path}/ca"
  ]
  crl_distribution_points = ["http://192.168.1.16:8200/v1/${vault_mount.root_ca.path}/crl"]
}


# Step 2: Intermediate CA mount path.
resource "vault_mount" "intermediate_ca" {
  path        = var.intermediate_ca_mount_path
  type        = "pki"
  description = "Intermediate CA for ${var.ca_name}"
  # Step 2.2 - tune secrets engine
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 87600

}


# Step 2.3 - Generate CSR
resource "vault_pki_secret_backend_intermediate_cert_request" "base" {
  depends_on   = [vault_mount.intermediate_ca]
  backend      = vault_mount.intermediate_ca.path
  type         = "internal"
  common_name  = var.intermediate_cn
  alt_names    = [var.intermediate_cn]
  key_bits     = 4096
  country      = "IT"
  ou           = var.ou
  organization = var.org
  locality     = "Catania"
}

resource "vault_pki_secret_backend_root_sign_intermediate" "base" {
  depends_on     = [vault_pki_secret_backend_role.role]
  backend        = vault_mount.root_ca.path
  format         = "pem_bundle"
  csr            = vault_pki_secret_backend_intermediate_cert_request.base.csr
  common_name    = var.intermediate_cn
  use_csr_values = true
}

resource "vault_pki_secret_backend_intermediate_set_signed" "base" {
  backend     = vault_mount.intermediate_ca.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.base.certificate
}
