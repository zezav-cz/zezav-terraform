resource "hcloud_zone" "zezav_cz" {
  name              = "zezav.cz"
  mode              = "primary"
  ttl               = 3600
  delete_protection = true
}

resource "hcloud_zone_rrset" "zezav_cz_a_records" {
  for_each = toset(["@", "www", "dir", "blog", "private"])
  zone     = hcloud_zone.zezav_cz.name
  name     = each.key
  type     = "A"

  records = [
    { value = hcloud_server.z01_de.ipv4_address }
  ]
}

resource "hcloud_zone_rrset" "vpn_zezav_cz" {
  zone = hcloud_zone.zezav_cz.name
  name = "vpn"
  type = "A"

  records = [
    { value = hcloud_server.z03_de.ipv4_address }
  ]
}

# == Github ==
resource "hcloud_zone_rrset" "zezav_cz_gh_txt" {
  zone = hcloud_zone.zezav_cz.name
  name = "_github-pages-challenge-zezav-cz"
  type = "TXT"

  records = [
    { value = provider::hcloud::txt_record("72aeaf4b0b2726d7ed44c62617fd6c") }
  ]
}

# == Lara ==
resource "hcloud_zone_rrset" "zezav_cz_lara_mx" {
  zone = hcloud_zone.zezav_cz.name
  name = "@"
  type = "MX"
  ttl  = 600

  records = [
    { value = "1 mx1.larksuite.com." },
    { value = "5 mx2.larksuite.com." },
    { value = "10 mx3.larksuite.com." }
  ]
}

resource "hcloud_zone_rrset" "zezav_cz_lara_txt" {
  zone = hcloud_zone.zezav_cz.name
  name = "@"
  type = "TXT"
  ttl  = 600

  records = [
    { value = provider::hcloud::txt_record("verification-code-site-App_lark=nrS1tj9eN8cJtHPx3cSo") },
    { value = provider::hcloud::txt_record("v=spf1 +include:spf.onlarksuite.com -all") }
  ]
}

resource "hcloud_zone_rrset" "zezav_cz_lara_txt_dkim" {
  zone = hcloud_zone.zezav_cz.name
  name = "lark2603032321._domainkey"
  type = "TXT"
  ttl  = 600

  records = [
    { value = provider::hcloud::txt_record("v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3X1h+GexBGEThr5HIpL5Q/6Lv6Xk54Wo5k35EQSQ0Bauxg7uvJ40JuTn0Zqwu0ixzeeV0w3IO0zJMGOgHC2ouZ14EGyu/uEWhyQQVvJh6JKMFOo/OAya+b3MIKHMneGm7Pw2RjqEIRnT3Grw8XYp+ksUoJrznn+DKVg5EOP8XwELhacQF6twMGmSqjUEideN9RAw0QmVkbnf6p0Lp4+f1tTu0hA9NPwwe+0jAY0FEBr4McnzAvHPwswFyuhAjAQn8wFYUWz3jxxT8xe3bdBPzYkm+v6K9p1X2LWYJv0rXm2Sp8/YoH97vVhwrLiqmBiy1QL0sbpcxy6RmUJNXawuRQIDAQAB") },
  ]
}
