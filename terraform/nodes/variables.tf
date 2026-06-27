variable "guest_username" {
  description = "Username to create on guest"
  type        = string
  nullable    = false
  default     = "chris"
}

variable "volume_source" {
  description = "Source for the volume"
  type        = string
  nullable    = false
  default     = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
}

variable "ssh_key_path" {
  description = "Path to SSH public key"
  type        = string
  nullable    = false
  default     = "~/.ssh/id_ed25519.pub"
}

variable "workers" {
  description = "Names of workers to create"
  type        = set(string)
  nullable    = false
  default     = ["hoddit", "doddit"]
}

variable "node_ips" {
  description = "Static IPs assigned to each node"
  type        = map(string)
  nullable    = false
  default = {
    gaffer = "192.168.122.10"
    hoddit = "192.168.122.11"
    doddit = "192.168.122.12"
  }
}

variable "ssh_cmd" {
  description = "Base SSH command to use"
  type        = string
  nullable    = false
  default     = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
}

variable "kubeconfig_path" {
  description = "Where to store kubeconfig"
  type        = string
  nullable    = false
  default     = "../kubeconfig"
}
