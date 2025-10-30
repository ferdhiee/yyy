#!/usr/bin/env bash
# Deploy helper (bash)
# Usage: ./deploy.sh <repo-name> [--public]

REPO_NAME=${1:-$(basename "$(pwd)")}
PUBLIC_FLAG=$2
BRANCH=main

echo "Preparing to deploy: $(pwd)"
if [ ! -d .git ]; then
  git init
  echo "Initialized git repository."
fi
git add -A
git commit -m "Initial commit" 2>/dev/null || echo "No changes or commit failed"

if command -v gh >/dev/null 2>&1; then
  VIS="--private"
  if [ "$PUBLIC_FLAG" = "--public" ]; then
    VIS="--public"
  fi
  echo "Creating repo via gh..."
  gh repo create "$REPO_NAME" $VIS --source=. --remote=origin --push --confirm || { echo "gh create failed"; exit 1; }
  echo "Created and pushed."
else
  echo "gh CLI not found. Please create a GitHub repo and run:" 
  echo "  git remote add origin https://github.com/<you>/$REPO_NAME.git"
  echo "  git push -u origin $BRANCH"
fi

echo "If you want Pages auto-deploy, enable GitHub Pages in repo settings or use the included Actions workflow (.github/workflows/pages.yml)."
