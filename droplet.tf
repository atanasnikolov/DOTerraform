# ERP DROPLET #################################################################
resource "digitalocean_droplet" "terraform-erp" {
  image  = "ubuntu-22-04-x64"
  name   = "terraform-erp"
  region = "fra1"
  size   = "s-1vcpu-2gb"
  vpc_uuid = digitalocean_vpc.terraform_vpc.id
  ssh_keys = [38946637]
}