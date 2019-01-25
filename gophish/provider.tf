variable "do_token" {}
variable "pub_key" {}
variable "pvt_key" {}
variable "ssh_fingerprint" {}
variable "instance_name" {}
variable "domain_name" {}
variable "gophish_directory" {}

provider "digitalocean" {
  token = "${var.do_token}"
}
