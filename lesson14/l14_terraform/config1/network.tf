data "yandex_vpc_network" "default" {
  name = "default"
}

resource "yandex_vpc_subnet" "public_network" {
  name           = "public_network"
  description    = "Public network for lesson14"
  v4_cidr_blocks = ["10.10.1.0/24"]
  zone           = "ru-central1-d"
  network_id     = data.yandex_vpc_network.default.id
}

resource "yandex_vpc_subnet" "private_network" {
  name           = "private_network"
  description    = "Private network for lesson14"
  v4_cidr_blocks = ["10.10.2.0/24"]
  zone           = "ru-central1-d"
  network_id     = data.yandex_vpc_network.default.id
}
