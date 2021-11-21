provider "google" {
  project       = "minecraft-on-demand-327813"
  region        = "us-east1"
}

# Runtime resources
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
        image = "us-east1-docker.pkg.dev/minecraft-on-demand-327813/registry/minecraft:latest"
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

# Storage Resources
resource "google_storage_bucket" "bucket" {
  name     = "mod-bucket"
  location = "US"
}

resource "google_pubsub_topic" "lifecycle_management_events" {
  name = "lifecycle_management_events"
}

# Lifecycle management resources
resource "google_storage_bucket_object" "lifecycle_manager" {
  name = "lifecycle_manager"
  source = "./management/lifecycle.py"
  bucket = google_storage_bucket.bucket.name
}

resource "google_cloudfunctions_function" "lifecycle_manager" {
  name = "server_manager"
  description = "Manages server lifecycle"
  runtime = "python39"

  available_memory_mb = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.lifecycle_manager.output_name

  entry_point = "scale_server"
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource = google_pubsub_topic.lifecycle_management_events.id
  }
}