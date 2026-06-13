module "hoddit" {
  source = "./modules/virtual_machine"
  guest_name   = "hoddit"
}

module "doddit" {
  source = "./modules/virtual_machine"
  guest_name   = "doddit"
}
