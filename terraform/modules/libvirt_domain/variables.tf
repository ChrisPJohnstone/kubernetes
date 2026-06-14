variable "guest_name" {
  description = "Name of the guest"
  type        = string
  nullable    = false
}

variable "guest_type" {
  description = "Type of the guest"
  type        = string
  nullable    = false
  default     = "kvm"
}

variable "memory" {
  description = "Maximum memory allocation for the vm at boot time"
  type        = number
  nullable    = false
  default     = 512
}

variable "memory_unit" {
  description = "Unit for memory allocation"
  type        = string
  nullable    = false
  default     = "Mb"
}

variable "vcpu" {
  description = "Number of Virtual CPU's allocated"
  type        = number
  nullable    = false
  default     = 1
}

variable "running" {
  description = "Wether guest should be started after creation"
  type        = bool
  nullable    = false
  default     = false
}

variable "pool_name" {
  description = "Pool for the guest"
  type        = string
  nullable    = true
}

variable "volume_name" {
  description = "Name of the guest volume"
  type        = string
  nullable    = true
}

variable "target_device" {
  description = "Target device"
  type        = string
  nullable    = false
  default     = "vda"
}

variable "target_bus" {
  description = "Target bus"
  type        = string
  nullable    = false
  default     = "virtio"
}

variable "os_type" {
  description = "OS Type"
  type        = string
  nullable    = false
  default     = "hvm"
}

variable "os_arch" {
  description = "OS Architecture"
  type        = string
  nullable    = false
  default     = "x86_64"
}

variable "os_machine" {
  description = "OS Machine Type"
  type        = string
  nullable    = false
  default     = "q35"
}
