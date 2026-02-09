#!/usr/bin/env bash
set -euo pipefail

# Deploy h5games_web_mobileapp to Cloudflare Pages using wrangler
# Usage: ./deploy_pages.sh --project PROJECT_NAME [--dir DIR] [--branch BRANCH] [--account-id ID]

PROJECT=""
DIR="dist"
BRANCH="${CF_PAGES_BRANCH:-production}"
ACCOUNT_ID="${CLOUDFLARE_ACCOUNT_ID:-${CF_ACCOUNT_ID:-}}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2 ;;
    --dir) DIR="$2"; shift 2 ;;
    --branch) BRANCH="$2"; shift 2 ;;
    --account-id) ACCOUNT_ID="$2"; shift 2 ;;
    -h|--help) sed -n '1,200p' "$0"; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [ -z "$PROJECT" ]; then
  echo "Missing --project" >&2
  exit 2
fi

if [ -n "$ACCOUNT_ID" ]; then
  export CLOUDFLARE_ACCOUNT_ID="$ACCOUNT_ID"
fi

command -v wrangler >/dev/null 2>&1 || { echo "wrangler not found. Install/configure wrangler first." >&2; exit 3; }

if [ ! -d "$DIR" ]; then
  echo "Directory not found: $DIR. Run 'npm run build' first to create dist/." >&2
  exit 4
fi

echo "Deploying '$DIR' -> Pages project '$PROJECT' (branch: $BRANCH)"
wrangler pages deploy "$DIR" --project-name "$PROJECT" --branch "$BRANCH" --commit-dirty=true

echo "Deployment finished."
