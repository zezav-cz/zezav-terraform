resource "hcloud_zone" "zezav_cz" {
  name              = "zezav.cz"
  mode              = "primary"
  ttl               = 3600
  delete_protection = true
}


resource "hcloud_zone_rrset" "zezav_cz_a_records" {
  for_each = toset(["@", "www", "pub", "dir", "blog"])
  zone     = hcloud_zone.zezav_cz.name
  name     = each.key
  type     = "A"

  records = [
    { value = hcloud_server.z01_de.ipv4_address }
  ]
}

resource "hcloud_zone_rrset" "zezav_cz_gh_txt" {
  zone = hcloud_zone.zezav_cz.name
  name = "_github-pages-challenge-zezav-cz"
  type = "TXT"

  records = [
    { value = provider::hcloud::txt_record("72aeaf4b0b2726d7ed44c62617fd6c") }
  ]
}

