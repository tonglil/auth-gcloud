#!/bin/bash
set -euo pipefail

main() {
  CRED=${GOOGLE_CREDENTIALS:-${GCP_JSON_KEY:-${TOKEN}}}
  KEY=/tmp/gcloud.json

  echo "$CRED" > "$KEY"

  _trace gcloud version
  _trace gcloud auth activate-service-account --key-file "$KEY"

  _trace rm "$KEY"
}

check() {
  if [[ -z "${GOOGLE_CREDENTIALS:-${GCP_JSON_KEY:-${TOKEN:-}}}" ]]; then
    echo "Google JSON credential not provided (GOOGLE_CREDENTIALS/GCP_JSON_KEY/TOKEN)"
    exit 1
  fi
}

# Display the underlying command
_trace() {
  cmd=($@)
  echo "$ ${cmd[*]}"
  "${cmd[@]}"
}

check

main
