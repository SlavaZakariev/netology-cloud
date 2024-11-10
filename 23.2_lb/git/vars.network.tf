### network vars
variable "vpc_name" {
  type        = string
  default     = "netology-vpc-01"
  description = "VPC network"
}

variable "subnet_name" {
  type        = string
  default     = "netology-subnet-01"
  description = "Subnet name"
}

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
  # https://cloud.yandex.ru/docs/overview/concepts/geo-scope
}

variable "cidr-01" {
  type        = list(string)
  default     = ["10.10.10.0/24"]
  # https://cloud.yandex.ru/docs/vpc/operations/subnet-create
}
