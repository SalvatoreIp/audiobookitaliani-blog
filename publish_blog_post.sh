#!/bin/bash
TITLE="$1"
CONTENT="$2"
BLOG_DIR="$HOME/audiobookitaliani-blog"

cd "$BLOG_DIR" || exit 1

echo "📝 Creando post: $TITLE"

# Genera copertina
echo "🎨 Generando copertina..."
COVER_PATH=$($HOME/.openclaw/skills/generate-book-cover.sh "$TITLE" 2>&1 | tail -1)

# Slug
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | \
       sed 's/[àáâä]/a/g; s/[èéêë]/e/g; s/[ìíîï]/i/g; s/[òóôö]/o/g; s/[ùúûü]/u/g' | \
       sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//')

FILENAME="content/posts/${SLUG}.md"

# Markdown con URL ASSOLUTO per cover
if [ $? -eq 0 ] && [ -n "$COVER_PATH" ]; then
    echo "✅ Copertina generata: $COVER_PATH"
    
    cat > "$FILENAME" << MDEOF
---
title: "$TITLE"
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
draft: false
tags: ["audiolibri", "recensioni"]
cover:
    image: "https://www.audiobookitaliani.com/$COVER_PATH"
    alt: "Copertina $TITLE"
---

$CONTENT
MDEOF
else
    echo "⚠️  Generazione copertina fallita"
    cat > "$FILENAME" << MDEOF
---
title: "$TITLE"
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
draft: false
tags: ["audiolibri", "recensioni"]
---

$CONTENT
MDEOF
fi

echo "✅ Post creato: $FILENAME"

git add .
git commit -m "Nuovo post: $TITLE"
git push origin main

if [ $? -eq 0 ]; then
    echo "🚀 Post pubblicato!"
else
    echo "❌ Errore push"
    exit 1
fi
