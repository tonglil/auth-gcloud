#!/bin/bash
set -euo pipefail
cd "$(cd "$(dirname "$0")"; cd ..; pwd)"

CRED=${GCP_JSON_KEY:-${GOOGLE_CREDENTIALS:-${TOKEN}}}
KEY=/tmp/gcloud.json

echo "$CRED" > "$KEY"

gcloud auth activate-service-account --key-file "$KEY"

rm "$KEY"
