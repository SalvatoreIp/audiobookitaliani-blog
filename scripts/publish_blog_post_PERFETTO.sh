#!/bin/bash
TITLE="$1"
DESCRIPTION="$2"
AMAZON_LINK="$3"
SECTION="${4:-posts}"

cd /home/salvatore/audiobookitaliani-blog || exit 1

SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g;s/--*/-/g')
DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
FILE="content/$SECTION/$DATE-$SLUG.md"

cat > "$FILE" << MD
---
title: "$TITLE"
date: $DATE
author: "AudioBook Italiani Team"
draft: false
tags: ["audiolibri", "recensioni", "$SECTION"]
---

## 👉 [Acquista su Amazon]($AMAZON_LINK)

**$DESCRIPTION** - Un'opera imperdibile che esplora temi profondi e universali.

**[PARAGRAFO1: Introduzione 200 parole - contesto autore + importanza opera]**

### 📚 Libri Correlati
[link1: stesso autore] | [link2: stesso genere] | [link3: tuo post simile]

**[PARAGRAFO2: Trama senza spoiler - 200 parole]**

**[PARAGRAFO3: Perché leggerlo + voto - 150 parole]**

⭐ **VOTO: [9/10 - trasformativo / 8/10 - eccellente / 10/10 - capolavoro]**

## 👉 [Acquista su Amazon]($AMAZON_LINK)

**Supporta AudioBook Italiani acquistando tramite i nostri link!**
MD

echo "✅ $FILE creato con struttura SEO-PERFETTA (500+ parole)!"
echo "📝 Apri: nano $FILE"
echo "✏️  Compila:"
echo "   [PARAGRAFO1] → intro + autore"
echo "   [link1] → altro libro STESSO AUTORE"  
echo "   [link2] → altro libro STESSO GENERE"
echo "   [link3] → TUO post simile (es: /libri/montecristo/)"
echo "   [PARAGRAFO2] → trama"
echo "   [PARAGRAFO3] → perché leggerlo"
echo "   [VOTO] → 8-10/10"
echo "🔥 Poi: git add . && git commit -m 'feat: $TITLE' && git push"
