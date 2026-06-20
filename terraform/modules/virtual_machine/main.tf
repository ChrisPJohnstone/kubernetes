resource "libvirt_volume" "guest_volume" {
  name   = "${var.guest_name}-volume.qcow2"
  pool   = var.pool_name
  source = var.volume_source
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "guest_seed" {
  name           = "${var.guest_name}-cloudinit.iso"
  pool           = var.pool_name
  meta_data      = <<-EOF
    instance-id: ${var.guest_name}
    local-hostname: ${var.guest_name}
  EOF
  user_data      = templatefile("${path.module}/../../templates/cloudinit.yml", {
    guest_username = var.guest_username
    ssh_public_key = var.ssh_public_key
    apt_key_dir    = var.apt_key_dir
  })
}

resource "libvirt_domain" "guest" {
  name      = var.guest_name
  type      = var.guest_type
  memory    = var.memory
  vcpu      = var.vcpu
  running   = var.running
  arch      = var.os_arch
  machine   = var.os_machine
  cloudinit = libvirt_cloudinit_disk.guest_seed.id

  boot_device {
    dev = ["hd"]
  }

  disk {
    volume_id = libvirt_volume.guest_volume.id
  }

  network_interface {
    network_name   = var.network_interface
    wait_for_lease = true
  }

  console {
    type        = var.console_type
    target_port = var.console_target_port
  }
}
