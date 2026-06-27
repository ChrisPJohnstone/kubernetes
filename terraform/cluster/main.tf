resource "kubernetes_namespace_v1" "namespace" {
  metadata { name = var.namespace }
}

resource "helm_release" "envoy_gateway_release" {
  depends_on = [kubernetes_namespace_v1.namespace]
  name = "envoy-gateway"
  chart = "oci://docker.io/envoyproxy/gateway-helm"
  version = var.envoy_gateway_version
  namespace = local.namespace
  create_namespace = false
}

resource "kubernetes_manifest" "envoy_gatewayclass" {
  depends_on = [helm_release.envoy_gateway_release]
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind = "GatewayClass"
    metadata = {
      name = "envoy-gatewayclass"
    }
    spec = {
      controllerName = "gateway.envoyproxy.io/gatewayclass-controller"
    }
  }
}


resource "kubernetes_manifest" "envoy_gateway" {
  depends_on = [kubernetes_manifest.envoy_gatewayclass]
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind = "Gateway"
    metadata = {
      name = "envoy-gateway"
      namespace = local.namespace
    }
    spec = {
      gatewayClassName = "envoy-gatewayclass"
      listeners = [{
        name = "http"
        protocol = "HTTP"
        port = 80
      }]
    }
  }
}

module "prometheus" {
  source     = "./modules/prometheus/"
  namespace  = local.namespace
  config_path = "${var.config_dir}prometheus.yml"
}
