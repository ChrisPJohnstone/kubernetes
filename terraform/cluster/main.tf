resource "kubernetes_namespace_v1" "namespace" {
  metadata { name = var.namespace }
}

module "metallb" {
  depends_on = [kubernetes_namespace_v1.namespace]
  source     = "./modules/metallb/"
  namespace  = local.namespace
}

# module "envoy" {
#   depends_on = [module.metallb]
#   source     = "./modules/envoy/"
#   namespace  = local.namespace
# }
#
# module "prometheus" {
#   depends_on  = [kubernetes_namespace_v1.namespace]
#   source      = "./modules/prometheus/"
#   namespace   = local.namespace
#   config_path = "${var.config_dir}prometheus.yml"
# }
#
# resource "kubernetes_manifest" "prometheus_route" {
#   depends_on = [module.envoy, module.prometheus]
#   manifest = {
#     apiVersion = "gateway.networking.k8s.io/v1"
#     kind       = "HTTPRoute"
#     metadata = {
#       name      = "prometheus-route"
#       namespace = var.namespace
#     }
#     spec = {
#       parentRefs = [{ name = module.envoy.gateway_name }]
#       hostnames  = ["prometheus.${var.domain}"]
#       rules = [{
#         backendRefs = [{
#           name = module.prometheus.service_name
#           port = module.prometheus.service_port
#         }]
#       }]
#     }
#   }
# }
