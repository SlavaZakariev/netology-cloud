### vms_resources
variable "vms_resources" {
  type            = map(map(number))
  default         = {
    vm-01      = {
      cores       = 2
      memory      = 2
      fraction    = 5
    }
    vm-02      = {
      cores       = 2
      memory      = 2
      fraction    = 5
    }
    nat-vm-01  = {
      cores       = 2
      memory      = 2
      fraction    = 5
    }
  }
}

variable "vm_cpu_id_v1" {
  type        = string
  default     = "standard-v1"
  description = "cpu id v1"
}

variable "vm_os" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "os version"
}

### vm_name/hostname
variable "vm-01" {
  type        = string
  default     = "vm-public"
  description = "vm name"
}

variable "vm-01-ip" {
  type        = string
  default     = "192.168.10.10"
}

variable "vm-02" {
  type        = string
  default     = "vm-private"
  description = "vm name"
}

variable "vm-02-ip" {
  type        = string
  default     = "192.168.20.10"
}

variable "nat-vm-01" {
  type        = string
  default     = "nat-instance-vm-01"
  description = "vm name for nat"
}

variable "nat-instance-ip" {
  type        = string
  default     = "192.168.10.254"
}

variable "nat-instance-image-id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}
