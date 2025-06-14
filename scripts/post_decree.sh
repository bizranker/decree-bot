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

# Find latest .json decree based on modification time
latest_file=$(ls -t "$EDICTA_DIR"/*.json | head -n1)

if [ -z "$latest_file" ]; then
  echo "⚠️ No decree file found in $EDICTA_DIR"
  exit 1
fi

echo "📜 Posting latest edict: $latest_file"

curl -X POST -H 'Content-type: application/json' \
     --data @"$latest_file" \
     "$WEBHOOK_URL"

