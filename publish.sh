#!/bin/bash
# Veröffentlicht die Flugbuch-Website: index.html committen und nach GitHub pushen.
# Aufruf im Terminal:  cd ~/Projekte/Travel-Log && ./publish.sh "Kurze Beschreibung"
set -e
cd "$(dirname "$0")"
REPO_URL="${REPO_URL:-https://github.com/MartinKriegler83/travel_log.git}"
MSG="${1:-Flugbuch aktualisiert $(date +%Y-%m-%d)}"
if [ ! -d .git ]; then
  git init -b main
  git remote add origin "$REPO_URL"
fi
if [ "$(git remote get-url origin)" != "$REPO_URL" ]; then
  git remote set-url origin "$REPO_URL"
fi
git rm --cached --ignore-unmatch -q README.md
git add index.html .gitignore publish.sh
if git diff --cached --quiet; then echo "Nichts Neues zu veröffentlichen."; exit 0; fi
git commit -m "$MSG"
git push -u origin main
echo "Fertig. Cloudflare Pages baut die Seite jetzt automatisch neu."
