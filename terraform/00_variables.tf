
variable "project" {
  description = "The project which should be used for all resources in this example"
  default     = "tdp"
}

variable "location" {
  description = "The location default value"
  default     = "eu-west-3"
}

variable "nb_edge" {
  description = "The number of edge server"
  default     = 1
}

variable "nb_worker" {
  description = "The number of worker server"
  default     = 3
}

variable "data_disk_size" {
  description = "The size of data disk in gb"
  default     = 1
}
