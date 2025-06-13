#!/bin/bash

# Load secrets if available
source .env 2>/dev/null

# Directory containing JSON decrees
EDICTA_DIR="./edicta"

# Use DECREEBOT_WEBHOOK_URL from .env or fallback to SLACK_WEBHOOK
WEBHOOK="${DECREEBOT_WEBHOOK_URL:-$SLACK_WEBHOOK}"

for file in "$EDICTA_DIR"/*.json; do
    echo "📜 Posting edict: $file"
    curl -X POST -H 'Content-type: application/json' \
         --data @"$file" \
         "$WEBHOOK"
done
