variable "volume_name" {
  description = "Name of the volume"
  type        = string
  nullable    = false
}

variable "pool_name" {
  description = "Name of resource pool for the volume"
  type        = string
  nullable    = false
}

variable "volume_source" {
  description = "Source for the volume"
  type        = string
  nullable    = false
  default     = "/tmp/debian.qcow2"
}

variable "volume_target_format" {
  description = "Target format for the volume"
  type        = string
  nullable    = false
  default     = "qcow2"
}
