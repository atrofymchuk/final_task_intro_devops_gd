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
variable "vm_type_bastion" {
  description = "Please Enter type of VM"
  type        = string
  default     = "f1-micro"
}
variable "image_type_bastion" {
  description = "Please Enter type of image"
  type        = string
  default     = "centos-cloud/centos-7"
}
variable "vm_type" {
  description = "Please Enter type of VM"
  type        = string
  default     = "e2-medium"
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
  description = "Please Enter name of instance"
  type        = string
  default     = "at-infra"
}
variable "port_8080" {
  description = "Please Enter range port"
  type        = string
  default     = "8080"
}
variable "port_nexus" {
  description = "Please Enter range port"
  type        = string
  default     = "8081,8082"
}
variable "protocol" {
  description = "Please Enter ip address"
  type        = string
  default     = "TCP"
}
variable "status" {
  description = "Please Enter status of instances 'RUNNING' or 'TERMINATED'"
  type        = string
  default     = "RUNNING"
}

variable "ip_cidr_range_public_subnetwork" {
 description = "Please Enter ip cidr range public subnetwork"
 type        = string
 default     = "10.132.0.32/28"
}

variable "ip_cidr_range_private_subnetwork" {
 description = "Please Enter ip cidr range private subnetwork"
 type        = string
 default     = "10.132.0.48/28"
}

variable "type_of_address" {
 description = "Please Enter type of address"
 type        = string
 default     = "EXTERNAL"
}

variable "source_range_determined" {
 description = "Please Enter ip source range address determined by you"
 type        = list
 default     = ["45.152.73.81", "45.152.74.95", "45.152.73.81", "194.44.67.36", "45.152.74.147"]
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

variable "port_jenkins" {
 description = "Please Enter ip source range address"
 type        = list
 default     = ["8080"]
}

variable "port_nexus_1" {
 description = "Please Enter ip source range address"
 type        = list
 default     = ["8081", "8082", "8083"]
}

#variable "port_nexus_2" {
# description = "Please Enter ip source range address"
# type        = list
# default     = ["8082"]
#}
