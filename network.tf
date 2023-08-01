# ERP VPC #####################################################################
resource "digitalocean_vpc" "terraform_vpc" {
  name     = "terraform-erp-vpc"
  region   = "fra1"
  description = " This VPC is created via terraform to re-create the ERP system"
}

# FIREWALL FOR ERP ############################################################
resource "digitalocean_firewall" "terraform-erp" {
  name = "terraform-erp-firewall"

  droplet_ids = [digitalocean_droplet.terraform-erp.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "25060"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "587"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "25060"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# DOMAIN FOR ERP ##############################################################
data "digitalocean_domain" "terraform-testgenericsoft-eu" {
  name = "testgenericsoft.eu"
}

resource "digitalocean_record" "terraform-erp-record" {
  domain = data.digitalocean_domain.terraform-testgenericsoft-eu.id
  type   = "A"
  name   = "terraform-erp"
  value  = digitalocean_droplet.terraform-erp.ipv4_address
}