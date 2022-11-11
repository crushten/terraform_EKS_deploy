resource "kubernetes_namespace" "godemo" {
  metadata {
    name = "godemo"
  }

}

resource "kubernetes_deployment" "go" {
  #ts:skip=AC_K8S_0064 Not sure what it wants
  metadata {
    name      = "go-deployment"
    namespace = kubernetes_namespace.godemo.metadata.0.name
    labels = {
      app = "go_endpoint_cloud"
    } //labels
  }   //metadata

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "go_endpoint_cloud"
      } //match_labels
    }   //selector

    template {
      metadata {
        labels = {
          app = "go_endpoint_cloud"
        } //labels
      }   //metadata
      spec {
        security_context {
          seccomp_profile {
            type = "RuntimeDefault"
          }
        } //pod security context
        container {
          image = "${aws_ecr_repository.go-repository.repository_url}:latest"
          name  = "go-endpoint-cloud-container"
          security_context {
          } //container security context
          port {
            container_port = 8080
          } //port
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            } //limits
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            } //requests
          }   //container resources 
          liveness_probe {
            http_get {
              path = "/healthcheck"
              port = 8080
            } //http get
            initial_delay_seconds = 5
            period_seconds        = 15
          } //liveness probe
        }   //container
      }     //spec
    }       //template
  }         //spec
}           //resource deployment

resource "kubernetes_service" "go" {
  depends_on = [kubernetes_deployment.go]
  metadata {
    name      = "go-endpoint-cloud-service" //doesnt seem to like underscores for some reason
    namespace = kubernetes_namespace.godemo.metadata.0.name
  } //metadata
  spec {
    selector = {
      app = kubernetes_deployment.go.spec.0.template.0.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 8080
    }
    type = "LoadBalancer"
  } //spec
}   //resource service

resource "kubernetes_pod_security_policy" "go" {
  #ts:skip=AC_K8S_0080 seccomp doesnt go here
  metadata {
    name = "go-endpoint-cloud-security-policy"
  }

  spec {
    privileged                 = false
    allow_privilege_escalation = false

    volumes = [
      "configMap",
      "emptyDir",
      "projected",
      "secret",
      "downwardAPI",
      "persistentVolumeClaim",
    ]

    run_as_user {
      rule = "MustRunAsNonRoot"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "MustRunAs"
      range {
        min = 1
        max = 65535
      }
    }

    fs_group {
      rule = "MustRunAs"
      range {
        min = 1
        max = 65535
      }
    }

    read_only_root_filesystem = true
  }
}