resource "libvirt_volume" "guest_volume" {
  name   = "${var.guest_name}-volume.qcow2"
  pool   = var.pool_name
  source = var.volume_source
  format = "qcow2"
}

resource "libvirt_cloudinit_disk" "guest_seed" {
  name           = "${var.guest_name}-cloudinit.iso"
  pool           = var.pool_name
  user_data      = <<-EOF
    #cloud-config
    disable_root: true
    users:
      - name: ${var.guest_username}
        ssh_authorized_keys:
          - ${var.ssh_public_key}
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
    packages:
      - containerd
      - apt-transport-https
      - ca-certificates
      - curl
      - gpg
    runcmd:
      # Disable Swap
      - swapoff -a
      - sed -i '/ swap / s/^/#/' /etc/fstab

      # Install Kubelet
      - curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
      - echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
      - sudo apt-get update
      - sudo apt-get install -y kubelet
      - sudo apt-mark hold kubelet
      - sudo systemctl enable --now kubelet
  EOF
  meta_data      = <<-EOF
    instance-id: ${var.guest_name}
    local-hostname: ${var.guest_name}
  EOF
  network_config = <<-EOF
    version: 2
    ethernets:
      enp0s3:
        dhcp4: true
  EOF
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
