module "network_data" {
  source       = "./modules/network_data"
  network_name = "default"
}

module "vm_compute" {
  source      = "./modules/vm_compute"
  vm_name     = "lesson15"
  zone        = "ru-central1-d"
  platform_id = "standard-v3"
  cores       = 2
  memory      = 2
  image_id    = "fd83oqecknfqpm6pnvur"
  size        = 20
  subnets     = module.network_data.subnets
}
