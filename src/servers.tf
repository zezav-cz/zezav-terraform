# == z01.de ==
resource "hcloud_server" "z01_de" {
  name        = "z01.de"
  image       = "debian-13"
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

resource "hcloud_rdns" "z01_de" {
  server_id  = hcloud_server.z01_de.id
  ip_address = hcloud_server.z01_de.ipv4_address
  dns_ptr    = "z01.de.zezav.cz"
}

# == z02.de ==

resource "hcloud_server" "z02_de" {
  name        = "z02.de"
  image       = "debian-13"
  server_type = "cpx32"
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

resource "hcloud_zone_rrset" "zezav_cz_z02_de_a" {
  zone = hcloud_zone.zezav_cz.name
  name = hcloud_server.z02_de.name
  type = "A"

  records = [
    { value = hcloud_server.z02_de.ipv4_address },
  ]
}

resource "hcloud_zone_rrset" "zezav_cz_z02_de_aaaa" {
  zone = hcloud_zone.zezav_cz.name
  name = hcloud_server.z02_de.name
  type = "AAAA"

  records = [
    { value = hcloud_server.z02_de.ipv6_address },
  ]
}

resource "hcloud_rdns" "z02_de" {
  server_id  = hcloud_server.z02_de.id
  ip_address = hcloud_server.z02_de.ipv4_address
  dns_ptr    = "z02.de.zezav.cz"
}

# == z03.de ==

resource "hcloud_server" "z03_de" {
  name        = "z03.de"
  image       = "debian-13"
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

resource "hcloud_zone_rrset" "zezav_cz_z03_de_a" {
  zone = hcloud_zone.zezav_cz.name
  name = hcloud_server.z03_de.name
  type = "A"

  records = [
    { value = hcloud_server.z03_de.ipv4_address },
  ]
}

resource "hcloud_zone_rrset" "zezav_cz_z03_de_aaaa" {
  zone = hcloud_zone.zezav_cz.name
  name = hcloud_server.z03_de.name
  type = "AAAA"

  records = [
    { value = hcloud_server.z03_de.ipv6_address },
  ]
}

resource "hcloud_rdns" "z03_de" {
  server_id  = hcloud_server.z03_de.id
  ip_address = hcloud_server.z03_de.ipv4_address
  dns_ptr    = "z03.de.zezav.cz"
}

output "server_ips" {
  value = {
    "z01.de" = {
      ipv4 = hcloud_server.z01_de.ipv4_address
      ipv6 = hcloud_server.z01_de.ipv6_address
    }
    "z02.de" = {
      ipv4 = hcloud_server.z02_de.ipv4_address
      ipv6 = hcloud_server.z02_de.ipv6_address
    }
    "z03.de" = {
      ipv4 = hcloud_server.z03_de.ipv4_address
      ipv6 = hcloud_server.z03_de.ipv6_address
    }
  }
}
