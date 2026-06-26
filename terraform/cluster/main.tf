resource "kubernetes_namespace_v1" "namespace" {
  metadata { name = var.namespace }
}

module "prometheus" {
  source     = "./modules/prometheus/"
  depends_on = [kubernetes_namespace_v1.namespace]
  namespace  = local.namespace
  config_path = "${var.config_dir}prometheus.yml"
}
