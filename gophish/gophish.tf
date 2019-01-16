resource "digitalocean_droplet" "gophish" {
  image = "ubuntu-16-04-x64"
  name = "${var.instance_name}"
  region = "nyc1"
  size = "1GB"
  ssh_keys = ["${var.ssh_fingerprint}"]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = ["mkdir /root/gophish"]
  }

  provisioner "file" {
    source = "${var.gophish_directory}"
    destination = "/root/gophish"
  }

  provisioner "file" {
    source = "/etc/letsencrypt/live/${var.domain_name}/fullchain.pem"
    destination = "/root/gophish/${var.domain_name}.crt"
  }

  provisioner "file" {
    source = "/etc/letsencrypt/live/${var.domain_name}/privkey.pem"
    destination = "/root/gophish/${var.domain_name}.key"
  }

  provisioner "remote-exec" {
    inline = [
      "sed -i 's/example.crt/${var.domain_name}.crt/' /root/gophish/config.json",
      "sed -i 's/example.key/${var.domain_name}.key/' /root/gophish/config.json",
      "sed -i 's/0.0.0.0:80/0.0.0.0:443/' /root/gophish/config.json",
      "sed -i 's/false/true/' /root/gophish/config.json",
      "chmod a+x /root/gophish/gophish"
      ]
  }
}
