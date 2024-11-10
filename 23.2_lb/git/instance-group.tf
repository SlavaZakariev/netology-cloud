# Создать сервисную учётную запись для группы
resource "yandex_iam_service_account" "sa-ig" {
  name = "sa-ig"
}

# Выдать права
resource "yandex_resourcemanager_folder_iam_member" "ig-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-ig.id}"
}

# Создание группы
resource "yandex_compute_instance_group" "ig-01" {
  name               = "fixed-ig-with-balancer"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.sa-ig.id

  instance_template {
    resources {
      cores         = 2
      memory        = 2
      core_fraction = 5
    }

    boot_disk {
      initialize_params {
        image_id = var.lamp-instance-image-id
      }
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnet-01.id]
      nat = true
    }

    scheduling_policy {preemptible = true}

    metadata = {
      ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
      user-data = <<EOF
#!/bin/bash
apt install httpd -y
cd /var/www/html
echo '<html><img src="http://${yandex_storage_bucket.netology-bucket.bucket_domain_name}/Picture-01.jpg"/></html>' > index.html
service httpd start
EOF
    }
  }

  scale_policy {
    fixed_scale {
        size = 3
    }
  }

  allocation_policy {
    zones = [var.zone_a]
  }

  deploy_policy {
    max_unavailable  = 1
    max_creating     = 3
    max_expansion    = 1
    max_deleting     = 1
    startup_duration = 3
  }

  health_check {
    http_options {
        port = 80
        path = "/"
    }
  }

  depends_on = [ yandex_storage_bucket.netology-bucket ]

  load_balancer {
    target_group_name = "target-group"
  }
}
