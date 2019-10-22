variable "location" {
  type    = string
  default = "francecentral"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "vm_count" {
  type    = number
  default = 1
}
variable "admin_username" {
  type    = string
  default = "intech"
}
variable "ssh_pub_key" {
  type    = string
  default = ""
}

variable "poc-name" {
  type    = string
  default = "poc-kubernetes"
}

variable "author" {
  type = string
}
variable "client_secret" {
  type    = string
  default = "69b92da7-27eb-4dcf-a0b9-879d83e5faec"
}

variable "kubernetes_version" {
  type    = string
  default = "1.14.7"
}