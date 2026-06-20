output "guest_name" {
  value = libvirt_domain.guest.name
}

output "guest_ip" {
  description = "IP address of the guest"
  value       = local.guest_ip
}
