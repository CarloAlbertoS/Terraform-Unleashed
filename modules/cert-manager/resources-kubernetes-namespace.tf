resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
}
resource "kubernetes_namespace" "cert-manager" {
  metadata {
    annotations = {
      name = var.namespace
    }

    labels = {
      "app.kubernetes.io/name"     = var.namespace
      "app.kubernetes.io/instance" = var.namespace
    }

    name = var.namespace
  }
  depends_on = [
    null_resource.delay
  ]
}