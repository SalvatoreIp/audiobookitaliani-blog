#!/bin/bash
# Script: Pubblica post blog con copertina

TITLE="$1"
CONTENT="$2"
BLOG_DIR="$HOME/audiobookitaliani-blog"

cd "$BLOG_DIR" || exit 1

echo "📝 Creando post: $TITLE"

# ⭐ GENERA COPERTINA
echo "🎨 Generando copertina..."
COVER_PATH=$($HOME/.openclaw/skills/generate-book-cover.sh "$TITLE" 2>&1 | tail -1)

if [ $? -eq 0 ] && [ -n "$COVER_PATH" ] && [[ "$COVER_PATH" == /images/* ]]; then
    echo "✅ Copertina generata: $COVER_PATH"
    CONTENT_WITH_IMAGE="![Copertina $TITLE]($COVER_PATH)

$CONTENT"
else
    echo "⚠️  Generazione copertina fallita, procedo senza immagine"
    CONTENT_WITH_IMAGE="$CONTENT"
fi

# Crea slug per filename
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | \
       sed 's/[àáâä]/a/g; s/[èéêë]/e/g; s/[ìíîï]/i/g; s/[òóôö]/o/g; s/[ùúûü]/u/g' | \
       sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')

FILENAME="content/posts/${SLUG}.md"

# Crea file Markdown
cat > "$FILENAME" << MDEOF
---
title: "$TITLE"
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
draft: false
tags: ["audiolibri", "recensioni"]
---

$CONTENT_WITH_IMAGE
MDEOF

echo "✅ Post creato: $FILENAME"

# Git push
git add .
git commit -m "Nuovo post: $TITLE"
git push origin main

if [ $? -eq 0 ]; then
    echo "🚀 Post pubblicato su audiobookitaliani.com!"
else
    echo "❌ Errore push Git"
    exit 1
fi
