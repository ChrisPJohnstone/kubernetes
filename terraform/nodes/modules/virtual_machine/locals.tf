locals {
  guest_ip = libvirt_domain.guest.network_interface[0].addresses[0]
}
