#!/bin/bash
TITLE="$1"
DESCRIPTION="$2"
AMAZON_LINK="$3"
SECTION="${4:-posts}"
IMAGE_PATH="${5:-}"

cd /home/salvatore/audiobookitaliani-blog || exit 1

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g;s/--*/-/g')
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
DATEONLY=$(date -u +"%Y-%m-%d")
FILE="content/$SECTION/$DATEONLY-$SLUG.md"

mkdir -p static/images/covers

if [ -n "$IMAGE_PATH" ] && [ -f "$IMAGE_PATH" ]; then
  cp "$IMAGE_PATH" "static/images/covers/$SLUG.jpg"
fi

# Genera correlati da post realmente esistenti
CORRELATI=""
while IFS= read -r postfile; do
  post_slug=$(basename "$postfile" .md)
  post_title=$(grep '^title:' "$postfile" | head -1 | sed 's/title: *//;s/"//g')
  [ -n "$post_title" ] && CORRELATI="$CORRELATI\n- [$post_title](/posts/$post_slug/)"
done < <(find content/posts -name "*.md" ! -name ".*" | grep -v "$DATEONLY-$SLUG" | shuf | head -3)

cat > "$FILE" << MD
---
title: "$TITLE"
date: $DATE
author: "AudioBook Italiani Team"
draft: false
tags: ["audiolibri", "recensioni", "$SECTION"]
cover:
  image: '/images/covers/$SLUG.jpg'
  alt: 'Copertina $TITLE'
---
## 👉 [Acquista su Amazon]($AMAZON_LINK)
$DESCRIPTION per ogni appassionato.

## 📖 Introduzione e Contesto
Nato dalla penna di un autore che ha rivoluzionato il panorama letterario, questo libro rappresenta un punto di svolta.

## 📖 Trama (senza spoiler)
Il protagonista si trova immerso in un mondo affascinante dove [qui trama principale senza spoiler].

## 🎯 Perché leggerlo
Questo libro non è solo una storia, ma un'esperienza che cambia il modo di vedere la realtà.
⭐ VOTO: 9/10 - Trasformativo ed emozionante

## 📚 Libri Correlati
$(echo -e "$CORRELATI")

## 👉 [Acquista su Amazon]($AMAZON_LINK)
Supporta AudioBook Italiani acquistando tramite i nostri link!
MD

chmod 644 "$FILE"
chown salvatore:salvatore "$FILE"

# Conta caratteri e valida
CHARS=$(wc -m < "$FILE")
echo "✅ $FILE creato!"
echo "📊 Caratteri attuali: $CHARS (minimo richiesto: 400)"
if [ "$CHARS" -lt 400 ]; then
  echo "⚠️  ATTENZIONE: contenuto sotto i 400 caratteri! Espandi le sezioni!"
else
  echo "✅ Lunghezza OK!"
fi
echo ""
echo "📝 nano $FILE → COMPILA:"
echo "   - 'Introduzione e Contesto': almeno 200 caratteri"
echo "   - 'Trama (senza spoiler)':   almeno 200 caratteri"
echo "   - 'Perché leggerlo':         almeno 150 caratteri"
echo "   - TOTALE MINIMO:             400 caratteri"
echo ""
echo "🔥 git add . && git commit -m '$TITLE live' && git push"
