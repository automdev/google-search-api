#!/usr/bin/env bash
# Google Search API – cURL example
# Usage: AUTOM_API_KEY=your-key bash google_search.sh
set -euo pipefail

curl -sS -G "https://api.autom.dev/v1/google/search" \
  -H "x-api-key: ${AUTOM_API_KEY}" \
  --data-urlencode query=YOUR_VALUE
