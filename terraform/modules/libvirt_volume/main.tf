resource "libvirt_volume" "guest_volume" {
  name = var.volume_name
  pool = var.pool_name
  create = {
    content = {
      url = var.volume_source
    }
  }
  target = {
    format = {
      type = var.volume_target_format
    }
  }
}
