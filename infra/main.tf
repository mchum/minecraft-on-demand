provider "aws" {
  project = "minecraft-on-demand"
  region = "us-east1"
}

resource "google_cloud_run_service" "minecraft" {
    count       = var.enabled ? 1 : 0
    name        = "minecraft-server"
    location    = "us-east1"
    template {
        metadata = {
            name    = "minecraft-server"
            annotations {
                "autoscaling.knative.dev/maxScale"  = "1"
            }
        }
        spec {
            containers {
                image           = "itzg/minecraft-server"
                port            = 25565
                env {
                    name    = "TYPE"
                    value   = "FABRIC"
                }
            }
        }
    }
    traffic {
        percent         = 100
        latest_revision = true
    }
}
