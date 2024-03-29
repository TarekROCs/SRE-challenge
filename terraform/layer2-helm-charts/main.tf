# Install ECK operator via helm-charts
resource "helm_release" "eck-operator" {
  name = "eck-operator"

  repository       = "https://helm.elastic.co"
  chart            = "eck-operator"
  namespace        = "elastic-system"
  create_namespace = "true"


}

# Install traefik via helm-charts
resource "helm_release" "traefik" {
  name = "traefik"

  repository       = "https://traefik.github.io/charts"
  chart            = "traefik"
  namespace        = "traefik"
  create_namespace = "true"

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/alibaba-cloud-loadbalancer-address-type"
    value = "intranet"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/alicloud-loadbalancer-name"
    value = "traefik"
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/alicloud-loadbalancer-ip"
    value = "x.x.x.x"
  }

}



#Install sealed secrets via helm-charts
resource "helm_release" "sealed_secrets" {
  name = "sealed-secrets"

  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  namespace        = "sealed-secrets"
  create_namespace = "true"

}

#Install ArgoCD via helm-charts
resource "helm_release" "argo" {
  name = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd" 
  namespace  = "argo" 
  version    = "5.34.5"

  # An option for setting values that I generally use
  values = [jsonencode({
    someKey = "someValue"
  })]

  # Another option, individual sets
  set {
    name  = "someKey"
    value = "someValue"
  }

  set_sensitive {
    name  = "someOtherKey"
    value = "someOtherValue"
  } 
}

#Install PostgreSQL via helm-charts
resource "helm_release" "database" {
  name  = "database"
  chart = "stable/postgresql"

  set {
    name  = "postgresqlUsername"
    value = "user"
  }

  set {
    name  = "postgresqlPassword"
    value = "xxx"
  }

  set {
    name  = "initdbScripts"
    value = "init.sql: |${file("../backend/init.sql")}"
  }
} 
