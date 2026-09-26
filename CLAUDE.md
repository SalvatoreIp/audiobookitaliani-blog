# CLAUDE.md

Guida per Claude Code in questo repository.

## Cos'è

Sito Hugo `www.audiobookitaliani.com` (tema PaperMod): audiolibri, Kindle e libri in italiano, con link affiliati Amazon/Audible. Cloudflare Pages progetto `audiobookitaliani-blog` (collegato a Git, ma si pubblica comunque anche con wrangler). Repo `SalvatoreIp/audiobookitaliani-blog`, remote via SSH (niente token nell'URL).

## Comandi

```bash
cd /home/salvatore/audiobookitaliani-blog && rm -rf public/ && hugo --minify \
  && npx wrangler pages deploy public --project-name audiobookitaliani-blog --commit-dirty=true \
  && git add content static && git commit -m "TITOLO" && git push
```

- Questo repo non ha `.env`: per wrangler esporta quello di `/home/salvatore/risparmio-energetico/.env` (stesso account Cloudflare).
- Aggiungi a git solo `content/` e `static/` (nella root ci sono molti file sparsi non tracciati da non committare).
- `scripts/salva_immagine.py URL SLUG` — salva un'immagine ElevenLabs come `static/images/covers/SLUG.jpg` a 1280 px.
- Pubblicazione automatica: cron della VPS alle 11:05 → `scripts/daily_publish_vps.sh` (prompt in `scripts/daily_publish_prompt.txt`), log in `logs/daily_publish.log`.

## Struttura contenuti

- Sezioni: `posts` (guide, liste, articoli generali), `recensioni` (audiolibri e servizi come Audible), `kindle` (ebook e Kindle), `libri` (libri cartacei). Non crearne altre.
- File: `content/<sezione>/<slug>.md`. URL: `https://www.audiobookitaliani.com/<sezione>/<slug>/`.
- Copertine in `static/images/covers/`, referenziate come `/images/covers/<slug>.jpg`.
- `OPENCLAW_INSTRUCTIONS.md` contiene le vecchie regole OpenClaw (link, formato Audible): valgono ancora per il formato dei link.

Frontmatter (virgolette doppie, niente apici singoli):

```yaml
---
title: "max 60 caratteri"
date: YYYY-MM-DDTHH:MM:SS+02:00
draft: false
description: "120-155 caratteri con keyword"
tags: ["tag1", "tag2", "tag3"]
cover:
  image: "/images/covers/slug.jpg"
  alt: "..."
---
```

## Regole editoriali

- Italiano, 900-1400 parole, testo originale. Mai segnaposto tipo "[qui trama]" o link vuoti `()`.
- Dati sui libri (autore, anno, narratore, durata, editore) solo se verificati sul web; mai trame o premi inventati. Niente spoiler senza avviso.
- Link affiliati con tag `audiobookit-21` (voluto). Audible: `https://www.amazon.it/dp/ASIN?actionCode=AZIOther35606092201BR&tag=audiobookit-21`; prodotti: `https://www.amazon.it/dp/ASIN?tag=audiobookit-21`. ASIN solo se trovato davvero; altrimenti link di ricerca `https://www.amazon.it/s?k=TITOLO&i=audible&tag=audiobookit-21`. Mai `amzn.to`.
- Box CTA dopo l'introduzione:
  ```html
  <div class="cta-box">
    <a href="https://www.amazon.it/s?k=parole+chiave&i=audible&tag=audiobookit-21" target="_blank" rel="nofollow sponsored" class="cta-button">🎧 Ascolta ... su Audible</a>
  </div>
  ```
- Chiusura con "Supporta AudioBook Italiani acquistando tramite i nostri link!". 2-3 link interni ad articoli correlati.
- Slug: minuscolo e trattini, niente accenti né apostrofi. Mai post di prova.
