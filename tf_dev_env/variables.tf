variable "project_name" {
  description = "Please Enter project ID "
  type        = string
  default     = ""
}

variable "region" {
  description = "Please Enter Region to deploy Server"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "Please Enter Zone to deploy Server"
  type        = string
  default     = "europe-west1-b"
}

variable "keyfile" {
  description = "Please Enter json name file and path"
  type        = string
  default     = "../gcp_key/gcp-task-key.json"
}

variable "vm_type" {
  description = "Please Enter type of VM"
  type        = string
  default     = "g1-small"
}

variable "image_type" {
  description = "Please Enter type of image"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "ssh_user" {
  description = "Please Enter user who will be use SSH"
  type        = string
  default     = "atrofymchuk"
}

variable "name_env" {
  description = "Please enter name for instance"
  type        = string
  default     = "at-app"
}

variable "port_range" {
  description = "Please Enter range port"
  type        = string
  default     = "80"
}

variable "ip_address" {
  description = "Please Enter ip address"
  type        = string
  default     = ""
}

variable "status" {
  description = "Please Enter status of instances 'RUNNING' or 'TERMINATED'"
  type        = string
  default     = "RUNNING"
}

variable "ip_cidr_range" {
  description = "Please Enter ip cidr range address"
  type        = string
  default     = "10.132.0.64/28"
}

variable "source_range_determined" {
 description = "Please Enter ip source range address determined by you to access to ssh"
 type        = list
 default     = ["45.152.73.81", "45.152.74.95", "35.205.204.74", "194.44.67.36", "35.205.69.158"]
}

variable "source_range_all" {
 description = "Please Enter ip source range address for other"
 type        = list
 default     = ["0.0.0.0/0"]
}

variable "port_ssh" {
 description = "Please Enter ip source range address"
 type        = list
 default     = ["22"]
}

variable "port_app" {
 description = "Please Enter ip source range address"
 type        = list
 default     = ["80","8080"]
}
