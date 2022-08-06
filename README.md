[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit) [![pre-commit.ci status](https://results.pre-commit.ci/badge/github/brucellino/tfmod-template/main.svg)](https://results.pre-commit.ci/latest/github/brucellino/tfmod-template/main) [![semantic-release: conventional](https://img.shields.io/badge/semantic--release-conventional-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

# Terraform Vault CA module

A terraform module for creating a Vault CA.

## Examples

The `examples/` directory contains the example usage of this module.
These examples show how to use the module in your project, and are also use for testing in CI/CD.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >1.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.8.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_mount.intermediate_ca](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.root_ca](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_pki_secret_backend_config_urls.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_config_urls) | resource |
| [vault_pki_secret_backend_intermediate_cert_request.first](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_intermediate_cert_request) | resource |
| [vault_pki_secret_backend_role.role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_role) | resource |
| [vault_pki_secret_backend_root_cert.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_root_cert) | resource |
| [vault_pki_secret_backend_root_sign_intermediate.first](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_root_sign_intermediate) | resource |
| [vault_policy.main](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_name"></a> [ca\_name](#input\_ca\_name) | Name of the CA secrets engine | `string` | `"CA_mod"` | no |
| <a name="input_cn"></a> [cn](#input\_cn) | Common Name of the certificate being issued. Should be a fqdn | `string` | `"test.local"` | no |
| <a name="input_intermediate_ca_mount_path"></a> [intermediate\_ca\_mount\_path](#input\_intermediate\_ca\_mount\_path) | Mount path of the Intermediate CA PKI secrets engine | `string` | `"pki/test/pki_module/int"` | no |
| <a name="input_org"></a> [org](#input\_org) | Description of the organization | `string` | `"Default Organization"` | no |
| <a name="input_ou"></a> [ou](#input\_ou) | Organizational Unit name | `string` | `"CA OU"` | no |
| <a name="input_root_ca_mount_path"></a> [root\_ca\_mount\_path](#input\_root\_ca\_mount\_path) | Mount path of the CA PKI secrets engine | `string` | `"pki/test/pki_module/root"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
