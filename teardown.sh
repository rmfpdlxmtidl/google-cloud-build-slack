#!/bin/bash

# Clean config file.
cat <<EOF > config.json
{"SLACK_WEBHOOK_URL" : "https://hooks.slack.com/services/XXX"}
EOF

[ -z "$PROJECT_ID" ] && echo "Need to set PROJECT_ID" && exit 1;
gcloud config set project $PROJECT_ID

# Delete function.
gcloud beta functions delete cloud-build-slack-notification
echo "Function cloud-build-slack-notification deleted."

# Delete bucket.
if [ -z "$BUCKET_NAME" ]; then
  echo "BUCKET_NAME variable is not set, cannot delete bucket"
else
  gsutil rm -r gs://$BUCKET_NAME
  echo "Bucket $BUCKET_NAME deleted."
fi
