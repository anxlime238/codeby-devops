terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "network_name" {
  type = string
}

data "yandex_vpc_network" "network" {
  name = var.network_name
}

data "yandex_vpc_subnet" "subnets" {
  for_each = toset(data.yandex_vpc_network.network.subnet_ids)

  subnet_id = each.value
}

output "subnets" {
  value = data.yandex_vpc_subnet.subnets
}
