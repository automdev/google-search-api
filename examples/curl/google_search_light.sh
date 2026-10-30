#!/usr/bin/env bash
# Google Search Light API – cURL example
# Usage: AUTOM_API_KEY=your-key bash google_search_light.sh
set -euo pipefail

curl -sS -G "https://api.autom.dev/v1/google/search/light" \
  -H "x-api-key: ${AUTOM_API_KEY}" \
  --data-urlencode query=YOUR_VALUE
