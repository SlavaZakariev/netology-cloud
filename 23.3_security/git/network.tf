resource "yandex_vpc_network" "network-01" {
  name = var.vpc_name
 }

resource "yandex_vpc_subnet" "subnet-01" {
  name           = var.subnet_name
  zone           = var.zone_a
  network_id     = yandex_vpc_network.network-01.id
  v4_cidr_blocks = var.cidr-01
 }
