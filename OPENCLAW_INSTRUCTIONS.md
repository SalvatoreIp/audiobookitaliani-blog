# Istruzioni Operative Blog AudiobookItaliani (v3.0)
> Leggere INTEGRALMENTE prima di operare. Queste istruzioni sovrascrivono qualsiasi versione precedente.

---

## 1. SEZIONI ESISTENTI (non crearne di nuove)
Le uniche cartelle valide sotto content/ sono:
- posts/      — articoli generali, guide, liste
- kindle/     — articoli su ebook e Kindle
- libri/      — recensioni libri cartacei
- recensioni/ — recensioni audiolibri e servizi (es. Audible)

---

## 2. FRONTMATTER OBBLIGATORIO
---
title: "Titolo SEO max 60 caratteri"
date: YYYY-MM-DDTHH:MM:SS+02:00
draft: false
description: "Descrizione 120-155 caratteri con keyword principale"
tags: ["tag1", "tag2", "tag3"]
cover:
  image: /images/covers/nome-file.jpg
  alt: "Descrizione immagine"
---
MAI usare virgolette singole nel frontmatter — Hugo va in errore.
Il campo image deve avere lo slash iniziale: /images/covers/...

---

## 3. IMMAGINI

### Articoli su audiolibri o libri specifici
NON usare Pixabay — non ha copertine di libri reali.
Usa la copertina ufficiale Amazon:
mkdir -p static/images/covers/
wget -O static/images/covers/SLUG.jpg "https://images-na.ssl-images-amazon.com/images/P/ASIN.jpg"
Sostituisci ASIN con il codice reale del prodotto verificato su Amazon.it

### Articoli generici (guide, liste, confronti)
Usa Pixabay con keyword in INGLESE generiche:
- "audiobook headphones"
- "reading book"
- "listening music"
- "library books"
MAI inventare keyword specifiche per un titolo.

Comando Pixabay:
PIXABAY_KEY=$(grep PIXABAY_API_KEY /home/salvatore/audiobookitaliani-blog/.env | cut -d= -f2)
URL=$(wget -qO- "https://pixabay.com/api/?key=$PIXABAY_KEY&q=audiobook+headphones&image_type=photo&orientation=horizontal&per_page=3" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['hits'][0]['largeImageURL'])")
wget -O static/images/covers/SLUG.jpg "$URL"

---

## 4. LINK AFFILIAZIONE — REGOLE CRITICHE

MAI usare link abbreviati amzn.to — non sono tracciabili e possono perdere il tag affiliazione.

Formato obbligatorio per prodotti Amazon standard:
https://www.amazon.it/dp/ASIN?tag=audiobookit-21

Formato obbligatorio per audiolibri Audible:
https://www.amazon.it/dp/ASIN?actionCode=AZIOther35606092201BR&tag=audiobookit-21

Workflow link obbligatorio — MAI scrivere link Amazon a mano:
1. Scrivi nell'articolo link di ricerca generici: [Acquistalo su Amazon](https://www.amazon.it/s?k=TITOLO+LIBRO&i=audible)
2. Dopo aver salvato il file esegui lo script corretto:
   - Per Audible:  python3 /home/salvatore/fix-audible-links.py percorso/file.md
   - Per prodotti: python3 /home/salvatore/fix-amazon-links.py percorso/file.md
3. Gli script verificano gli ASIN reali su Amazon e inseriscono i link corretti con tag e actionCode automaticamente.

Posizione link nell'articolo:
- Un link all'inizio del corpo articolo
- Un link alla fine prima della conclusione
- Testo finale: "Supporta AudioBook Italiani acquistando tramite i nostri link!"

---

## 5. NAVIGAZIONE STEALTH ANTI-BOT

Usa lo script stealth quando un sito blocca il browser normale (Cloudflare, Amazon, ecc.):
~/.openclaw/skills/stealth-browser/generate.sh URL

Regole assolute:
- MAI usare Browser Relay — siamo su VPS, Chrome locale NON ESISTE
- MAI chiedere di attivare estensioni Chrome
- Se un sito blocca → usa stealth-browser, non il browser interno

---

## 6. PIPELINE DEPLOY OBBLIGATORIA (ordine esatto)

cd /home/salvatore/audiobookitaliani-blog
rm -rf public/
hugo --minify
npx wrangler pages deploy public --project-name audiobookitaliani-blog --commit-dirty=true
git add .
git commit -m "Descrizione articolo"
git push

MAI fare solo git push senza wrangler deploy — Cloudflare può essere lenta o non rispondere.

## TITOLI PIN PINTEREST — REGOLA AGGIORNATA
SCHEMA TITOLO CHE FUNZIONA:
- Curiosità: "Sapevi che Fahrenheit 451 fu scritto in soli 9 giorni?"
- Beneficio: "Come ascoltare L'Alchimista e cambiare prospettiva sulla vita"
- Domanda: "Audible vale davvero la pena? La risposta onesta"
- Emozione: "Il libro che ha cambiato la vita a milioni di persone"

TITOLI DA EVITARE:
- "Fahrenheit 451 audiolibro italiano 2026" → SEO arido, nessuna emozione
- "Dove ascoltare L'Alchimista su Audible" → istruzione, non hook
