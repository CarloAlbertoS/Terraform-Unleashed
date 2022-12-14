resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "v4.0.1"
  namespace  = var.namespace

  set {
    name  = "namespace"
    value = var.namespace
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.ingress.ip_address
  }

  set {
    name  = "controller.enableTLSPassthrough"
    value = true
  }

  set {
    name  = "controller.replicaCount"
    value = var.controllerReplicaCount
  }

  depends_on = [
    null_resource.delay,
    kubernetes_namespace.ingress
  ]
}

