terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

variable "vm_name" {
  type = string
}

variable "zone" {
  type = string
}

variable "platform_id" {
  type = string
}

variable "cores" {
  type = number
}

variable "memory" {
  type = number
}

variable "image_id" {
  type = string
}

variable "size" {
  type = number
}


variable "subnets" {
}

resource "yandex_compute_instance" "vm" {
  name                      = var.vm_name
  zone                      = var.zone
  platform_id               = var.platform_id
  
  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = var.size
    }
  }

  network_interface {
    subnet_id = [
      for subnet in values(var.subnets) :
      subnet.id
      if subnet.zone == var.zone
    ][0]

    nat            = true
  }

}

