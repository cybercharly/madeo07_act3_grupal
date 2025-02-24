resource "kubernetes_service" "nginx_service" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.madeo07_act3_grupal_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [helm_release.nginx_app]
}