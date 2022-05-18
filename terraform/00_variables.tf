
variable "project" {
  description = "The project which should be used for all resources in this example"
  default     = "tdp"
}

variable "location" {
  description = "The location default value"
  default     = "eu-west-3"
}

variable "master_instance_type" {
  description = "The type of instance for master server"
  default     = "t3a.large"
}

variable "nb_edge" {
  description = "The number of edge server"
  default     = 1
}

variable "edge_instance_type" {
  description = "The type of instance for edge server"
  default     = "t3a.nano"
}

variable "nb_worker" {
  description = "The number of worker server"
  default     = 3
}

variable "worker_instance_type" {
  description = "The type of instance for worker server"
  default     = "t3a.nano"
}

variable "data_disk_size" {
  description = "The size of data disk in gb"
  default     = 1
}
