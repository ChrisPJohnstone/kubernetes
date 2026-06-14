output "volume" {
  value       = libvirt_volume.guest_volume
  description = "The volume ID for this VM"
}
