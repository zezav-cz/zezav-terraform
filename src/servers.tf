resource "hcloud_server" "z01_de" {
  name        = "z01.de"
  image       = "debian-12"
  server_type = "cx23"
  location    = "nbg1"
  ssh_keys    = [hcloud_ssh_key.zezav_id_ed25519.name]
  labels = {
    management    = "true"
    management_by = "terraform"
  }
  firewall_ids = []
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}

resource "hcloud_zone_rrset" "zezav_cz_z01_de_a" {
  zone = hcloud_zone.zezav_cz.name
  name = hcloud_server.z01_de.name
  type = "A"

  records = [
    { value = hcloud_server.z01_de.ipv4_address },
  ]
}

resource "hcloud_zone_rrset" "zezav_cz_z01_de_aaaa" {
  zone = hcloud_zone.zezav_cz.name
  name = hcloud_server.z01_de.name
  type = "AAAA"

  records = [
    { value = hcloud_server.z01_de.ipv6_address },
  ]
}

resource "hcloud_rdns" "master" {
  server_id  = hcloud_server.z01_de.id
  ip_address = hcloud_server.z01_de.ipv4_address
  dns_ptr    = "z01.de.zezav.cz"
}

output "ips" {
  value = {
    ipv4 = hcloud_server.z01_de.ipv4_address
    ipv6 = hcloud_server.z01_de.ipv6_address
  }
}
