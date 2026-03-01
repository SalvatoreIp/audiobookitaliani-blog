#!/bin/bash
TITLE="$1"
DESCRIPTION="$2"
AMAZON_LINK="$3"
SECTION="${4:-posts}"
IMAGE_PATH="${5:-}"

cd /home/salvatore/audiobookitaliani-blog || exit 1

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g;s/--*/-/g')
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
FILE="content/$SECTION/$DATE-$SLUG.md"

mkdir -p static/images/covers

if [ -n "$IMAGE_PATH" ] && [ -f "$IMAGE_PATH" ]; then
  cp "$IMAGE_PATH" "static/images/covers/$SLUG.jpg"
fi

COVER="cover: image: '/images/covers/$SLUG.jpg' alt: 'Copertina $TITLE'"

# 📚 CORRELATI DINAMICI — URL lowercase completo come Hugo genera
CORRELATI=""
while IFS= read -r f; do
    TITLE_C=$(grep '^title:' "$f" | head -1 | sed 's/^title:[[:space:]]*//' | tr -d '"')
    # Genera lo slug dal titolo del file correlato
    SLUG_C=$(echo "$TITLE_C" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g;s/--*/-/g')
    if [ -n "$TITLE_C" ] && [ -n "$SLUG_C" ]; then
        CORRELATI="$CORRELATI[$TITLE_C](/$SECTION/$SLUG_C/) | "
    fi
done < <(ls content/$SECTION/*.md 2>/dev/null | grep -v "$FILE" | grep -v '_index.md' | shuf | head -3)
CORRELATI="${CORRELATI%' | '}"
if [ -z "$CORRELATI" ]; then
    CORRELATI="[Tutti i libri](/$SECTION/)"
fi

cat > "$FILE" << MD
---
title: "$TITLE"
date: $DATE
author: "AudioBook Italiani Team"
draft: false
tags: ["audiolibri", "recensioni", "$SECTION"]
$COVER
---
## 👉 [Acquista su Amazon]($AMAZON_LINK)
$DESCRIPTION per ogni appassionato.

## 📖 Introduzione e Contesto
Nato dalla penna di un autore che ha rivoluzionato il panorama letterario, questo libro rappresenta un punto di svolta. L'autore porta un bagaglio di esperienze uniche che si riflettono in ogni pagina.

### 📚 Libri Correlati
$CORRELATI

## 📖 Trama (senza spoiler)
Il protagonista si trova immerso in un mondo affascinante dove [qui trama principale senza spoiler]. La narrazione scorre fluida, tenendo il lettore incollato alle pagine.

## 🎯 Perché leggerlo
Questo libro non è solo una storia, ma un'esperienza che cambia il modo di vedere la realtà. Profondità filosofica + trama avvincente = lettura imperdibile.
⭐ VOTO: 9/10 - Trasformativo ed emozionante

## 👉 [Acquista su Amazon]($AMAZON_LINK)
Supporta AudioBook Italiani acquistando tramite i nostri link!
MD

chmod 644 "$FILE"
chown salvatore:salvatore "$FILE"
echo "✅ Permessi corretti: $FILE"
echo "✅ $FILE creato PERFETTO!"
echo "📝 nano $FILE → COMPILA:"
echo " - Espandi 'Introduzione e Contesto' (200 parole)"
echo " - Personalizza 'Trama' (200 parole)"
echo " - Migliora 'Perché leggerlo' + voto (150 parole)"
echo "🔥 git add . && git commit -m '$TITLE live' && git push"
