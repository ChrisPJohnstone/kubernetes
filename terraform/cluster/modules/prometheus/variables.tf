variable "config_path" {
  description = "Path to prometheus config"
  type        = string
  nullable    = false
}

variable "namespace" {
  description = "Namespace to create resources under"
  type        = string
  nullable    = false
}
