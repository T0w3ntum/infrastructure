output "ip" {
  value = "${digitalocean_droplet.gophish.ipv4_address}"
}
