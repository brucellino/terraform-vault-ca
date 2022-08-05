# Main definition
resource "vault_policy" "main" {
  name = "ca-policy-${var.ca_name}"
  policy = templatefile("${path.module}/policies/ca-root.hcl.tmpl", {
    ca_mount_path = var.ca_mount_path
    }
  )
}
