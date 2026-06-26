locals {
  prometheus_config_map = kubernetes_config_map_v1.prometheus_config.metadata[0].name
}
