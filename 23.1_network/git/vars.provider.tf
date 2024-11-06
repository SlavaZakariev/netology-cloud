###cloud vars
variable "token" {
  type        = string
  default     = "y0_***"
  sensitive   = true
  # https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  default     = "b1gq1***"
  # https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1grc***"
  # https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id
}
