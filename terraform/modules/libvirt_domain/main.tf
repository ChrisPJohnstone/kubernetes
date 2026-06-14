resource "libvirt_domain" "guest" {
  name        = var.guest_name
  type        = var.guest_type
  memory      = var.memory
  memory_unit = var.memory_unit
  vcpu        = var.vcpu
  running     = var.running
  os = {
    type         = var.os_type
    type_arch    = var.os_arch
    type_machine = var.os_machine
  }
  devices = {
    disks = [{
      source = {
        volume = {
          pool   = var.pool_name
          volume = var.volume_name
        }
      }
      target = {
        dev = var.target_device
        bus = var.target_bus
      }
    }]
  }
}
