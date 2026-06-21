locals {
  guest_ip          = try(libvirt_domain.guest.network_interface[0].addresses[0], "")
  guest_destination = "${var.guest_username}@${local.guest_ip}"
  guest_ssh_cmd     = "${var.ssh_cmd} ${local.guest_destination}"
}
