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

Drone 0.5+:

```yml
pipeline:
  gcp-actions:
    image: tonglil/auth-gcloud
    commands:
      - auth-gcloud
      - gcloud ...
    secrets: [google_credentials]
```

Using this replaces Drone 0.4:

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

## Releasing

Use the base image's `gcloud` version number as the tag:

```
make pull
make version
```

## Common uses

Cleanup GCR:

```yml
  gcr-cleanup:
    image: tonglil/auth-gcloud:alpine
    secrets: [google_credentials]
    environment:
      - REGISTRY=us.gcr.io
      - REPO=project/image
    commands:
      - auth-gcloud
        # delete untagged images
      - gcloud container images list-tags "$REGISTRY/$REPO" --filter='-tags:*' --format='get(digest)' --limit=unlimited | xargs -I {arg} gcloud container images delete "$REGISTRY/$REPO@{arg}" --quiet
        # only keep most recent 50 images
      - gcloud container images list-tags "$REGISTRY/$REPO" --format='get(digest)' --limit=unlimited | tail -n +51 | xargs -I {arg} gcloud container images delete "$REGISTRY/$REPO@{arg}" --quiet --force-delete-tags
```

Tag an existing GCR image on release:

```yml
  gcr-tag:
    image: tonglil/auth-gcloud:alpine
    secrets: [google_credentials]
    environment:
      - REGISTRY=us.gcr.io
      - REPO=project/image
    commands:
      - auth-gcloud
      - gcloud container images add-tag "$REGISTRY/$REPO:${DRONE_COMMIT}" "$REGISTRY/$REPO:${DRONE_TAG}" "$REGISTRY/$REPO:stable" --quiet
    when:
      event: tag
```

Copy an existing GCR image on release:

```yml
  gcr-tag:
    image: tonglil/auth-gcloud:alpine
    secrets: [google_credentials]
    environment:
      - SRC_REGISTRY=us.gcr.io
      - SRC_REPO=project/image1
      - DST_REGISTRY=us.gcr.io
      - DST_REPO=project/image2
    commands:
      - auth-gcloud
      # it is possible to tag/copy to multiple destinations
      - gcloud container images add-tag "$SRC_REGISTRY/$SRC_REPO:${DRONE_COMMIT}" "$DST_REGISTRY/$DST_REPO:${DRONE_TAG}" --quiet
    when:
      event: tag
```
