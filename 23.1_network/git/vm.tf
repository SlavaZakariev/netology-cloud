### ===vm-01===
data "yandex_compute_image" "vm-01" {
  family = var.vm_os
}

resource "yandex_compute_instance" "vm-01" {
  name        = var.vm-01
  hostname    = var.vm-01
  platform_id = var.vm_cpu_id_v1
  resources {
    cores         = var.vms_resources.vm-01.cores
    memory        = var.vms_resources.vm-01.memory
    core_fraction = var.vms_resources.vm-01.fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm-01.image_id
      name     = var.vm-01
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-01.id
    nat        = true
    ip_address = var.vm-01-ip
  }

  scheduling_policy {preemptible = true}

  metadata = local.metadata
}

### ===vm-02===
data "yandex_compute_image" "vm-02" {
  family = var.vm_os
}

resource "yandex_compute_instance" "vm-02" {
  name        = var.vm-02
  hostname    = var.vm-02
  platform_id = var.vm_cpu_id_v1
  resources {
    cores         = var.vms_resources.vm-02.cores
    memory        = var.vms_resources.vm-02.memory
    core_fraction = var.vms_resources.vm-02.fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.vm-02.image_id
      name     = var.vm-02
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-02.id
    nat        = false
    ip_address = var.vm-02-ip
  }

  scheduling_policy {preemptible = true}

  metadata = local.metadata
}

### ===nat-vm-01===
data "yandex_compute_image" "nat-vm-01" {
  family = var.vm_os
}

resource "yandex_compute_instance" "nat-vm-01" {
  name        = var.nat-vm-01
  hostname    = var.nat-vm-01
  platform_id = var.vm_cpu_id_v1
  resources {
    cores         = var.vms_resources.nat-vm-01.cores
    memory        = var.vms_resources.nat-vm-01.memory
    core_fraction = var.vms_resources.nat-vm-01.fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.nat-vm-01.image_id
      name     = var.nat-instance-image-id
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-01.id
    nat        = true
    ip_address = var.nat-instance-ip
  }

  scheduling_policy {preemptible = true}

  metadata = local.metadata
}
