# Main definition
resource "vault_policy" "main" {
  name = "ca-policy-${var.ca_name}"
  policy = templatefile("${path.module}/policies/ca-root.hcl.tmpl", {
    ca_mount_path = var.ca_mount_path
    }
  )
}

# CA mount path
resource "vault_mount" "root_ca" {
  path        = var.ca_mount_path
  type        = "pki"
  description = "Root CA for ${var.ca_name}"

  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 87600

}

# Root CA
resource "vault_pki_secret_backend_root_cert" "root" {
  depends_on  = [vault_mount.root_ca]
  backend     = vault_mount.root_ca.path
  type        = "internal"
  common_name = var.cn
  country     = "IT"
  locality    = "Catania"
  # ttl                  = 3153600
  format               = "pem"
  private_key_format   = "der" # pragma: allowlist secret
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  ou                   = var.ou
  organization         = var.org
}
