#!/bin/bash
TITLE="$1"
BODY="$2"
AMAZON_LINK="$3"
SECTION="${4:-posts}"
IMAGE_PATH="${5:-}"

cd /home/salvatore/audiobookitaliani-blog || exit 1

case "$SECTION" in
  "posts"|"kindle"|"libri") ;;
  *) SECTION="posts" ;;
esac

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g;s/--*/-/g')
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
DATEONLY=$(date -u +"%Y-%m-%d")
FILE="content/$SECTION/$DATEONLY-$SLUG.md"

mkdir -p static/images/covers
mkdir -p "content/$SECTION"

if [ -n "$IMAGE_PATH" ] && [ -f "$IMAGE_PATH" ]; then
  cp "$IMAGE_PATH" "static/images/covers/$SLUG.jpg"
fi

cat > "$FILE" << MD
---
title: "$TITLE"
date: $DATE
author: "AudioBook Italiani Team"
draft: false
tags: ["audiolibri", "recensioni", "$SECTION"]
cover:
  image: '/images/covers/$SLUG.jpg'
  alt: "Copertina $TITLE"
---

$BODY
MD

chmod 644 "$FILE"
chown salvatore:salvatore "$FILE"

CHARS=$(wc -m < "$FILE")
echo "✅ $FILE creato! ($CHARS caratteri)"
echo "🔥 Prossimo: git add . && git commit -m '$TITLE live' && git push"
