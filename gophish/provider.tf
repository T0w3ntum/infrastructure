variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "client_name" {}
variable "domain_name" {}

provider "digitalocean" {
  token = "${var.do_token}"
}
