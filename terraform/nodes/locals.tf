locals {
  gaffer_destination = "${var.guest_username}@${module.gaffer.guest_ip}"
}
