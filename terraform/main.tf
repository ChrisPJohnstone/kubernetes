module "resource_pool" {
  source    = "./modules/libvirt_pool"
  pool_name = "kubernetes"
}

module "hoddit" {
  source         = "./modules/virtual_machine"
  depends_on     = [module.resource_pool]
  guest_name     = "hoddit"
  guest_username = "chris"
  ssh_public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  pool_name      = module.resource_pool.pool.name
  running        = true
}

module "doddit" {
  source         = "./modules/virtual_machine"
  depends_on     = [module.resource_pool]
  guest_name     = "doddit"
  guest_username = "chris"
  ssh_public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
  pool_name      = module.resource_pool.pool.name
  running        = true
}
