###network vars
variable "vpc_name" {
  type        = string
  default     = "netology-vpc-01"
  description = "VPC network"
}

variable "subnet_name-01" {
  type        = string
  default     = "public"
  description = "Subnet name"
}

variable "subnet_name-02" {
  type        = string
  default     = "private"
  description = "Subnet name"
}

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  # https://cloud.yandex.ru/docs/overview/concepts/geo-scope
}

variable "cidr-01" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  # https://cloud.yandex.ru/docs/vpc/operations/subnet-create
}

variable "cidr-02" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  # https://cloud.yandex.ru/docs/vpc/operations/subnet-create
}
