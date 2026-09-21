resource "yandex_vpc_security_group" "public_sg" {
  name        = "public_sg"
  description = "Security group for public network"
  network_id  = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "yandex_vpc_security_group" "private_sg" {
  name        = "private_sg"
  description = "Security group for private network"
  network_id  = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Port 8080"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

