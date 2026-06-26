locals {
  namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  prometheus_config_map = kubernetes_config_map_v1.prometheus_config.metadata[0].name
}
