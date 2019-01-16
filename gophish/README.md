# Gophish deployment

- Generate Certificates

```bash
sudo certbot certonly -d [domain] --manual --preferred-challenges dns
```

- Make tfvars file, or answer the questions when executing script.

```
do_token = ""		# Digital Ocean access token
pvt_key = ""		# full path to private key
pub_key = ""		# full path to public key
ssh_fingerprint = ""	# ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub | awk '{print $2}'
instance_name = ""	# Sets name of the Instance in DO
domain_name = ""	# use the exact domain name you used when generating your letsencrypt certificate
gophish_directory = ""	# Full path to the gophish directory
```

- Run terraform

```bash
sudo terraform apply -var-file=var.tfvars
```

Profit
