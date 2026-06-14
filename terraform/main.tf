module "resource_pool" {
  source    = "./modules/libvirt_pool"
  pool_name = "kubernetes"
}

module "debian_volume" {
  source      = "./modules/libvirt_volume"
  depends_on  = [module.resource_pool]
  volume_name = "debian"
  pool_name   = module.resource_pool.pool.name
}

module "hoddit" {
  source         = "./modules/libvirt_domain"
  depends_on     = [module.debian_volume]
  guest_name     = "hoddit"
  guest_username = "chris"
  ssh_public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  pool_name      = module.resource_pool.pool.name
  volume_name    = module.debian_volume.volume.name
  running        = true
}

# TODO: Fix volumes and start second VM
# module "doddit" {
#   source     = "./modules/libvirt_domain"
#   guest_name = "doddit"
#   pool_name   = module.resource_pool.pool.name
#   volume_name = module.debian_volume.volume.name
#   running    = true
# }
#
