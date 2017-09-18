# auth-gcloud

Activate the service account for gcloud using a GCP service account JSON credential.

## Usage

```sh
docker run \
  -e TOKEN="$(cat service-account.json)" \
  tonglil/auth-gcloud
```
