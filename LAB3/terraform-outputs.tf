output "id" {
  value = module.kubernetes.id
}

output "kube_config" {
  value     = module.kubernetes.kube_config
  sensitive = true
}

output "client_key" {
  value     = module.kubernetes.client_key
  sensitive = true
}

output "client_certificate" {
  value     = module.kubernetes.client_certificate
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.kubernetes.cluster_ca_certificate
  sensitive = true
}


output "host" {
  value = module.kubernetes.host
}

output "ingress_ip" {
  value = module.ingress.public_ip
}
