locals {
  ssh_keys = {
    zezav_id_ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDy8nNjXqO4l1tHZwkoRYvKhhmBCIpbp2LWb3W63USkv trojakjan24@gmail.com"
  }
}

resource "hcloud_ssh_key" "zezav_id_ed25519" {
  name       = "zezav_id_ed25519"
  public_key = local.ssh_keys["zezav_id_ed25519"]
}
