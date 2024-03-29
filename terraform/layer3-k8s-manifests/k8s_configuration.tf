
resource "kubernetes_manifest" "storage-class" {
  manifest   = yamldecode(file("./yaml/configuration/storage-class.yml"))
}

# main
resource "kubernetes_manifest" "main-traefik-middleware-http-redirect" {
  manifest   = yamldecode(file("./yaml/configuration/main/traefik-middleware-http-redirect.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-traefik-middleware-strip-prefix" {
  manifest   = yamldecode(file("./yaml/configuration/main/traefik-middleware-strip-prefix.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-traefik-middleware-redirect-regex" {
  manifest   = yamldecode(file("./yaml/configuration/main/traefik-middleware-redirect-regex.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}

resource "kubernetes_manifest" "main-traefik-servers-transport" {
  manifest   = yamldecode(file("./yaml/configuration/main/traefik-servers-transport.yml"))
  depends_on = [kubernetes_manifest.main-namespace]
}



