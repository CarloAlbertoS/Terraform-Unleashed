variable "namespace" {
  description = "The name of the namespace used"
  default = "cert-manager"
}

variable "emailproduction" {
  description = "The email to be used to configure the production cluster-issuer"
}

variable "emailstaging" {
  description = "The email to be used to configure the staging cluster-issuer"
}