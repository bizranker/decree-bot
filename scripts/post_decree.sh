#!/bin/bash

# Dynamically locate the .env file relative to the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"

# Load secrets if available
[ -f "$ENV_FILE" ] && source "$ENV_FILE"

# Directory containing JSON decrees
EDICTA_DIR="$SCRIPT_DIR/../edicta"

# Use DECREEBOT_WEBHOOK_URL from Jenkins or .env (fallback to SLACK_WEBHOOK if set)
WEBHOOK_URL="${DECREEBOT_WEBHOOK_URL:-$SLACK_WEBHOOK}"

# Debug output
echo "🔧 Using webhook URL: $WEBHOOK_URL"

for file in "$EDICTA_DIR"/*.json; do
    echo "📜 Posting edict: $file"
    curl -X POST -H 'Content-type: application/json' \
         --data @"$file" \
         "$WEBHOOK_URL"
done
