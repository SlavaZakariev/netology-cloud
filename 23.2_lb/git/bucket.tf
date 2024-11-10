# Создание сервисной УЧ
resource "yandex_iam_service_account" "sa-bucket" {
  name = "sa-backet"
}

# Выделение прав для сервисной УЧ
resource "yandex_resourcemanager_cloud_iam_member" "bucket-editor" {
  cloud_id   = var.cloud_id
  role       = "storage.editor"
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

# Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
  description        = "static access key for bucket"
}

# Использование ключа для бакета
resource "yandex_storage_bucket" "netology-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "zakariev-netology-bucket"
  acl        = "public-read"
}

# Добавляем графический файл в бакет
resource "yandex_storage_object" "object-1" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.netology-bucket.bucket
  key        = "Picture-01.jpg"
  source     = "files/Picture-01.jpg"
  acl        = "public-read"
  depends_on = [ yandex_storage_bucket.netology-bucket ]
}
