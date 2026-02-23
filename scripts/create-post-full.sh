#!/bin/bash
# Blog Post Creator - Multi-Section Version
set -e

BLOG_DIR="/home/salvatore/audiobookitaliani-blog"
TITLE="$1"
DESCRIPTION="$2"
CATEGORY="${3:-audiolibri}"

if [ -z "$TITLE" ]; then
  echo "❌ Usage: create-post-full.sh 'Title' 'Description' [category]"
  exit 1
fi

if [ "$CATEGORY" = "kindle" ]; then
  SECTION="kindle"
elif [ "$CATEGORY" = "libri" ]; then
  SECTION="libri"
else
  SECTION="posts"
fi

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
DATE=$(date +%Y-%m-%d)
DATETIME=$(date -u +%Y-%m-%dT%H:%M:%SZ)
POST_FILE="${BLOG_DIR}/content/${SECTION}/${DATE}-${SLUG}.md"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 BLOG POST GENERATOR"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 Titolo: $TITLE"
echo "📂 Sezione: $SECTION"
echo "📂 Slug: $SLUG"
echo "📅 Data: $DATE"
echo ""

echo "🎨 Step 1/3: Generazione cover con AI..."
IMAGE_PROMPT="book cover design, $TITLE, italian literature style, dramatic lighting, professional photography, 4k quality, centered composition, elegant typography space, cinematic atmosphere, rich colors, depth of field"
IMAGE_FILE="${BLOG_DIR}/static/images/${SLUG}.png"

cd "$BLOG_DIR"

if [ -f "${BLOG_DIR}/scripts/leonardo-generate.py" ]; then
  python3 "${BLOG_DIR}/scripts/leonardo-generate.py" "$IMAGE_PROMPT" "$IMAGE_FILE"
  if [ -f "$IMAGE_FILE" ]; then
    IMAGE_PATH="/images/${SLUG}.png"
    echo "✅ Cover generata: $IMAGE_FILE"
  else
    echo "⚠️ Cover non generata"
    IMAGE_PATH=""
  fi
else
  echo "⚠️ Script Leonardo non trovato"
  IMAGE_PATH=""
fi

echo ""
echo "📄 Step 2/3: Creazione file post..."

cat > "$POST_FILE" << POSTEOF
---
title: "$TITLE"
date: $DATETIME
draft: false
tags: ["audiolibri", "recensioni", "$CATEGORY"]
cover:
  image: $IMAGE_PATH
  alt: "$TITLE - Copertina"
  caption: "Recensione completa"
categories: ["$SECTION"]
description: "$DESCRIPTION"
---

[PLACEHOLDER_TESTO_RECENSIONE]
POSTEOF

echo "✅ Post creato: $POST_FILE"

echo ""
echo "📦 Step 3/3: Deploy su GitHub..."

cd "$BLOG_DIR"
git add "$POST_FILE" 2>/dev/null
[ -f "$IMAGE_FILE" ] && git add "$IMAGE_FILE" 2>/dev/null
git commit -m "📚 New post: $TITLE [$SECTION]"
git push

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 COMPLETATO!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 File: $POST_FILE"
echo "📂 Sezione: $SECTION"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
