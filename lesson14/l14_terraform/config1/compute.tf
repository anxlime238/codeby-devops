resource "yandex_compute_disk" "boot-disk-1" {
  name     = "boot-disk-1"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = 20
  image_id = "fd83oqecknfqpm6pnvur"
}

resource "yandex_compute_disk" "boot-disk-2" {
  name     = "boot-disk-2"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = 20
  image_id = "fd83oqecknfqpm6pnvur"
}

resource "yandex_vpc_address" "vm1_ip" {
  external_ipv4_address {
    zone_id = "ru-central1-d"
  }
}

resource "yandex_vpc_address" "vm2_ip" {
  name = "terraform2-ip"

  external_ipv4_address {
    zone_id = "ru-central1-d"
  }
}

resource "yandex_compute_instance" "vm-1" {
  name        = "terraform1"
  zone        = "ru-central1-d"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.public_network.id
    nat            = true
    nat_ip_address = yandex_vpc_address.vm1_ip.external_ipv4_address[0].address
    security_group_ids = [
      yandex_vpc_security_group.public_sg.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_ed25519")
    host        = yandex_vpc_address.vm1_ip.external_ipv4_address[0].address
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}

resource "yandex_compute_instance" "vm-2" {
  name        = "terraform2"
  zone        = "ru-central1-d"
  platform_id = "standard-v3"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-2.id
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.private_network.id
    nat            = true
    nat_ip_address = yandex_vpc_address.vm2_ip.external_ipv4_address[0].address
    security_group_ids = [
      yandex_vpc_security_group.private_sg.id
    ]

  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_ed25519")
    host        = yandex_vpc_address.vm2_ip.external_ipv4_address[0].address
    timeout     = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

}
