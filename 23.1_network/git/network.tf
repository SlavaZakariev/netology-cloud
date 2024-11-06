resource "yandex_vpc_network" "network-01" {
  name = var.vpc_name
 }

resource "yandex_vpc_subnet" "subnet-01" {
  name           = var.subnet_name-01
  zone           = var.zone_a
  network_id     = yandex_vpc_network.network-01.id
  v4_cidr_blocks = var.cidr-01
 }

resource "yandex_vpc_subnet" "subnet-02" {
  name           = var.subnet_name-02
  zone           = var.zone_a
  network_id     = yandex_vpc_network.network-01.id
  route_table_id = yandex_vpc_route_table.nat-route-table.id
  v4_cidr_blocks = var.cidr-02
 }

resource "yandex_vpc_route_table" "nat-route-table" {
  network_id            = yandex_vpc_network.network-01.id

  static_route {
    destination_prefix  = "0.0.0.0/0"
    next_hop_address    = var.nat-instance-ip
  }
}
