resource "libvirt_domain" "guest" {
  name        = var.guest_name
  type        = var.guest_type
  memory      = var.memory
  memory_unit = var.memory_unit
  vcpu        = var.vcpu
  os = {
    type         = var.os_type
    type_arch    = var.os_arch
    type_machine = var.os_machine
  }
  devices = {
    disks = [{
      source = {
        file = {
          file = var.source_path
        }
      }
      target = {
        dev = target.device
        bus = target.bus
      }
    }]
  }
}
