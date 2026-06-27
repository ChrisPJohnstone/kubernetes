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

variable "gateway_name" {
  description = "Name of gateway for domain"
  type        = string
  nullable    = false
}

variable "domain" {
  description = "Domain to create service under"
  type        = string
  nullable    = false
}

variable "container_port" {
  description = "Port prometheus container listens on"
  type        = number
  nullable    = false
  default     = 9090
}

variable "service_port" {
  description = "Port the Kubernetes service exposes"
  type        = number
  nullable    = false
  default     = 9090
}
