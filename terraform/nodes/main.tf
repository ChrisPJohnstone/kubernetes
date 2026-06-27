module "resource_pool" {
  source    = "./modules/libvirt_pool"
  pool_name = "kubernetes"
}

resource "libvirt_volume" "base_volume" {
  name   = "debian-13-base.qcow2"
  pool   = module.resource_pool.pool.name
  source = var.volume_source
  format = "qcow2"
}

module "gaffer" {
  source = "./modules/virtual_machine"
  depends_on = [
    module.resource_pool,
    libvirt_volume.base_volume
  ]
  is_control_node = true
  guest_name      = "gaffer"
  template_dir    = "./templates/"
  base_volume_id  = libvirt_volume.base_volume.id
  guest_username  = var.guest_username
  ssh_public_key  = file(pathexpand(var.ssh_key_path))
  pool_name       = module.resource_pool.pool.name
  ssh_cmd         = var.ssh_cmd
  guest_ip        = var.node_ips["gaffer"]
}

resource "null_resource" "fetch_kubeconfig" {
  depends_on = [module.gaffer]
  provisioner "local-exec" {
    command = <<-EOF
      echo "Extraction kubeconfig"
      ${var.ssh_cmd} ${local.gaffer_destination} 'sudo cat /etc/kubernetes/admin.conf' > ${var.kubeconfig_path}
    EOF
  }
}

module "workers" {
  for_each       = var.workers
  source         = "./modules/virtual_machine"
  depends_on     = [null_resource.fetch_kubeconfig]
  guest_name     = each.key
  template_dir   = "./templates/"
  base_volume_id = libvirt_volume.base_volume.id
  guest_username = var.guest_username
  ssh_public_key = file(pathexpand(var.ssh_key_path))
  pool_name      = module.resource_pool.pool.name
  ssh_cmd        = var.ssh_cmd
  guest_ip       = var.node_ips[each.key]
}

resource "null_resource" "connect_workers" {
  depends_on = [module.workers]
  for_each   = var.workers
  provisioner "local-exec" {
    command = <<-EOF
      echo "Connecting ${each.key} to cluster"
      JOIN_CMD=$(${var.ssh_cmd} ${local.gaffer_destination} "sudo kubeadm token create --print-join-command 2>/dev/null")
      ${var.ssh_cmd} ${var.guest_username}@${var.node_ips[each.key]} "sudo $JOIN_CMD"
    EOF
  }
}
