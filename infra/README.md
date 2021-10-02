* Docker container: https://hub.docker.com/r/itzg/minecraft-server
* GCP Cloud Run to run container
* GCP Cloud Storage for world save
* Connection detection might be a Cloud Function of some sort
* No need for Helm or Kustomize since there's no long term permanent EKS stuff

```
user@localhost:~$ export GOOGLE_APPLICATION_CREDENTIALS=~/.secrets/gcp_creds.json 
user@localhost:~$ terraform plan -out .tfplan
user@localhost:~$ terraform apply .tfplan
```
