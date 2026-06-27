variable "namespace" {
  description = "Namespace to create resources under"
  type        = string
  nullable    = false
}

variable "metallb_version" {
  description = "Version of MetalLB to install"
  type        = string
  nullable    = false
  default     = "0.16.1"
}
