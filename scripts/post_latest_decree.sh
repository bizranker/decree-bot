#!/bin/bash

# Intern DecreeBot Processor
# 🧑‍\u🏫 Interns must commit a new edict to /edicta to trigger the pipeline.
# ☕ Starbucks run is presumed complete before invocation.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/../.env"
EDICTA_DIR="$SCRIPT_DIR/../edicta"

# Load secrets if available
[ -f "$ENV_FILE" ] && source "$ENV_FILE"

# Resolve Slack webhook
WEBHOOK_URL="${DECREEBOT_WEBHOOK_URL:-$SLACK_WEBHOOK}"

# Debug output
echo "🔌 Using webhook URL: ${WEBHOOK_URL:0:30}..."

# Select the latest edict based on filename sort order
latest_edict=$(ls -1 "$EDICTA_DIR"/*.json | sort | tail -n 1)

if [ -z "$latest_edict" ]; then
  echo "🚫 No edicts found in $EDICTA_DIR."
  exit 1
fi

# Send the latest edict to Slack
echo "📄 Posting latest edict: $latest_edict"
curl -X POST -H 'Content-type: application/json' \
     --data "@$latest_edict" \
     "$WEBHOOK_URL"

echo "✅ Decree from intern has been issued successfully."