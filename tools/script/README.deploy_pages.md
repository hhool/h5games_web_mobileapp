# deploy_pages.sh

This script deploys the built `dist/` directory to Cloudflare Pages using `wrangler`.

Usage

```bash
cd h5games_web_mobileapp
# build first
npm run build

# deploy
tools/script/deploy_pages.sh --project <PROJECT_NAME> --branch <BRANCH> --account-id <CLOUDFLARE_ACCOUNT_ID>
```

Environment
- `CLOUDFLARE_ACCOUNT_ID` (optional) — Cloudflare account ID; script accepts `--account-id` to set it for the run.
- `CF_PAGES_BRANCH` (optional) — default branch for Pages deployments (defaults to `production` in the script).

Notes
- The script expects `wrangler` to be installed and authorized. Use `wrangler login` or set an API token.
- If the Pages project does not exist, `wrangler` will prompt to create it interactively.
- Recommended CI flow: build on CI, then run this script non-interactively with API token and account id to publish.
