FROM google/cloud-sdk:latest

COPY auth-gcloud.sh /bin/auth-gcloud

ENTRYPOINT ["/bin/auth-gcloud"]
