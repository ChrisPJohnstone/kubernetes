module "resource_pool" {
  source    = "./modules/libvirt_pool"
  pool_name = "kubernetes"
}

module "gaffer" {
  source          = "./modules/virtual_machine"
  depends_on      = [module.resource_pool]
  is_control_node = true
  guest_name      = "gaffer"
  cloud_init_path = "./templates/cloudinit.yml"
  guest_username  = "chris"
  ssh_public_key  = file(pathexpand("~/.ssh/id_ed25519.pub"))
  pool_name       = module.resource_pool.pool.name
  running         = true
}

module "hoddit" {
  source          = "./modules/virtual_machine"
  depends_on      = [module.gaffer]
  guest_name      = "hoddit"
  cloud_init_path = "./templates/cloudinit.yml"
  guest_username  = "chris"
  ssh_public_key  = file(pathexpand("~/.ssh/id_ed25519.pub"))
  pool_name       = module.resource_pool.pool.name
  running         = true
}

module "doddit" {
  source          = "./modules/virtual_machine"
  depends_on      = [module.gaffer]
  guest_name      = "doddit"
  cloud_init_path = "./templates/cloudinit.yml"
  guest_username  = "chris"
  ssh_public_key  = file(pathexpand("~/.ssh/id_ed25519.pub"))
  pool_name       = module.resource_pool.pool.name
  running         = true
}
