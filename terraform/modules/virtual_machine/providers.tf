terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      # TODO: Check if version constraint can be loosened
      version = "0.9.8"
    }
  }
}
