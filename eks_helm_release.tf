resource "helm_release" "nginx_app" {
  name       = "nginx-app"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  namespace  = kubernetes_namespace.madeo07_act3_grupal_namespace.metadata[0].name

  set {
    name  = "replicaCount"
    value = "2"
  }

  set {
    name  = "image.repository"
    value = "cybercharly/madeo07_act3_grupal"
  }

  set {
    name  = "image.tag"
    value = "nginx"
  }

  set {
    name  = "podLabels.app"
    value = "nginx-app"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.port"
    value = "80"
  }
}

resource "helm_release" "postgres_db" {
  name       = "postgres-db"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.madeo07_act3_grupal_namespace.metadata[0].name

  set {
    name  = "global.postgresql.auth.database"
    value = "mydatabase"
  }

  set {
    name  = "global.postgresql.auth.username"
    value = "myuser"
  }

  set {
    name  = "global.postgresql.auth.password"
    value = "mypassword"
  }

  set {
    name  = "image.repository"
    value = "cybercharly/madeo07_act3_grupal"
  }

  set {
    name  = "image.tag"
    value = "postgres"
  }

  set {
    name  = "primary.persistence.enabled"
    value = "true"
  }

  set {
    name  = "primary.persistence.size"
    value = "8Gi"
  }
}
