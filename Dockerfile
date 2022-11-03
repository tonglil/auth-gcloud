FROM google/cloud-sdk:408.0.1

ENV CLOUDSDK_CORE_DISABLE_PROMPTS=1

COPY auth-gcloud.sh /bin/auth-gcloud

ENTRYPOINT ["/bin/auth-gcloud"]
