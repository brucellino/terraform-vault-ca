# simple example for Vault CA module

terraform {
  backend "consul" {
    path = "terraform/modules/tfmod-vault-ca"
  }
}

module "simple" {
  source = "../../"
}
