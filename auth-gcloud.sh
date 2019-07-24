#!/bin/bash
set -euo pipefail

main() {
  CRED=${GCP_JSON_KEY:-${GOOGLE_CREDENTIALS:-${TOKEN}}}
  KEY=/tmp/gcloud.json

  echo "$CRED" > "$KEY"

  _trace gcloud version
  _trace gcloud auth activate-service-account --key-file "$KEY"

  _trace rm "$KEY"
}

# Display the underlying command
_trace() {
  cmd=($@)
  echo "$ ${cmd[*]}"
  "${cmd[@]}"
}

main
