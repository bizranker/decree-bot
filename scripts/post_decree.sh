#!/bin/sh

EDICTA_DIR="./edicta"

for file in "$EDICTA_DIR"/*.json; do
    echo "📜 Posting edict: $file"
    curl -X POST -H 'Content-type: application/json' \
         --data @"$file" \
         "$SLACK_WEBHOOK"
done