resource "kubernetes_manifest" "main-namespace" {
  manifest   = yamldecode(file("./yaml/deployments/main/01-namespace.yml"))
}

resource "kubernetes_manifest" "main-http-tls-secret" {
  manifest   = yamldecode(file("./yaml/deployments/main/secret/http-tls.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-s3-keys" {
  manifest   = yamldecode(file("./yaml/deployments/main/secret/s3-keys.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

# Elasticsearch
resource "kubernetes_manifest" "main-elasticsearch" {
  field_manager {
    name            = "manager"
    force_conflicts = true
  }
  manifest   = yamldecode(file("./yaml/deployments/main/02-elasticsearch.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

# Kibana
resource "kubernetes_manifest" "main-kibana" {
  field_manager {
    name            = "manager"
    force_conflicts = true
  }
  computed_fields = ["spec"]
  manifest   = yamldecode(file("./yaml/deployments/main/03-kibana.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

# Fleet server
resource "kubernetes_manifest" "main-fleet-service-account" {
  field_manager {
    name            = "manager"
    force_conflicts = true
  }
  manifest   = yamldecode(file("./yaml/deployments/main/fleet/service-account.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-fleet-cluster-role" {
  field_manager {
    name            = "manager"
    force_conflicts = true
  }
  manifest   = yamldecode(file("./yaml/deployments/main/fleet/cluster-role.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-fleet-cluster-role-binding" {
  field_manager {
    name            = "manager"
    force_conflicts = true
  }
  manifest   = yamldecode(file("./yaml/deployments/main/fleet/cluster-role-binding.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-fleet" {
  field_manager {
    name            = "manager"
    force_conflicts = true
  }
  computed_fields = ["spec"]
  manifest   = yamldecode(file("./yaml/deployments/main/04-fleet.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}



# Ingress
resource "kubernetes_manifest" "main-elasticsearch-ingress-route" {
  manifest   = yamldecode(file("./yaml/deployments/main/ingress/elasticsearch-ingress.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-kibana-ingress-route" {
  manifest   = yamldecode(file("./yaml/deployments/main/ingress/kibana-ingress.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-fleet-ingress-route" {
  manifest   = yamldecode(file("./yaml/deployments/main/ingress/fleet-ingress.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}
