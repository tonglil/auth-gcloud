# auth-gcloud

Activate the service account for gcloud using a GCP service account JSON credential.

Also see https://github.com/tonglil/auth-gke/.

## Usage

```sh
docker run \
  -e TOKEN="$(cat service-account.json)" \
  tonglil/auth-gcloud
```

## Example

Using this replaces (Drone 0.4):

```yml
build:
  image: google/cloud-sdk
  environment:
    TOKEN_B64: $$GOOGLE_CREDENTIALS_B64
    GOOGLE_APPLICATION_CREDENTIALS: /tmp/gcloud.json
  commands:
    # Pass base 64 encoded credential and decode for gcloud login
    - echo $TOKEN_B64 | base64 -d > $GOOGLE_APPLICATION_CREDENTIALS
    - gcloud auth activate-service-account --key-file "$GOOGLE_APPLICATION_CREDENTIALS"
    - gcloud ...
```

With (Drone 0.5+):

```yml
pipeline:
  image: tonglil/auth-gcloud
  commands:
    - auth-gcloud
    - gcloud ...
  secret: [google_credentials]
```
