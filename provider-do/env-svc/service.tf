# DEFINE THE VARIABLE FOR THE DIGITAL OCEAN API TOKEN
# SET THE VALUE IN /global/secret.tfvars
variable "do_api_token" {}

# DEFINE THE VARIABLE FOR THE SSH KEY TO USE DURING PROVISIONING
# SET THE VALUE IN /global/secret.tfvars
variable "do_ssh_key_id" {}


# CONFIGURE THE DIGITAL OCEAN PROVIDER
provider "digitalocean" {
    token = "${var.do_api_token}"
}
