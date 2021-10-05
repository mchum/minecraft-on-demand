provider "google" {
  project       = "minecraft-on-demand-327813"
  region        = "us-east1"
}

resource "google_cloud_run_service" "minecraft" {
    count       = var.enabled ? 1 : 0
    name        = "minecraft-server"
    location    = "us-east1"

    template {
        metadata {
            name    = "minecraft-server-fabric"
            annotations = {
                "autoscaling.knative.dev/maxScale"  = "1"
            }
        }

        spec {
            containers {
                image           = "us-east1-docker.pkg.dev/minecraft-on-demand-327813/registry/minecraft:latest"
                ports {
                    container_port  = 25565
                }
                resources {
                    limits = {
                        "memory"  = "4Gi"
                    }
                }
            }
        }
    }

    traffic {
        percent         = 100
        latest_revision = true
    }
}
