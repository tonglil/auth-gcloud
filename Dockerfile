FROM google/cloud-sdk:465.0.0

ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1

COPY auth-gcloud.sh /bin/auth-gcloud

ENTRYPOINT ["/bin/auth-gcloud"]
