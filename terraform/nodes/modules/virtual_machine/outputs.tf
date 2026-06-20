output "guest_name" {
  value = libvirt_domain.guest.name
}

output "guest_ip" {
  description = "IP address of the guest"
  value       = try(libvirt_domain.guest.network_interface[0].addresses[0], null)
}
