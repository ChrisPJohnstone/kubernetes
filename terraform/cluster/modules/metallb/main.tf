resource "helm_release" "metallb_release" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  version          = var.metallb_version
  namespace        = var.namespace
  create_namespace = false
}
