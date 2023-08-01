resource "digitalocean_database_cluster" "terraform_mysql" {
  name       = "terraform-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
  private_network_uuid = digitalocean_vpc.terraform_vpc.id
}