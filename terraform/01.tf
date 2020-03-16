resource "digitalocean_droplet" "do" {
  image  = "centos-7-x64"
  name   = "do-centos"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
}
