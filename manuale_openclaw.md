# 📖 Manuale OpenClaw — AudiobookItaliani Blog

## 🗂️ Struttura del Blog

- **Root:** `/home/salvatore/audiobookitaliani-blog/`
- **Immagini:** `static/images/`

### 📁 Cartelle Content (scegliere in base alla sezione)

| Cartella | Percorso | Sezione del Menu |
|----------|----------|-----------------|
| Posts | `content/posts/` | Blog / Articoli |
| Libri | `content/libri/` | Libri |
| Kindle | `content/kindle/` | Kindle |

👉 **Prima di creare il file, chiedere a Salvatore in quale sezione va il contenuto.**

---

## 📝 Formato del Post

### Nome file
```
YYYY-MM-DD-titolo-del-libro.md
```
Esempio: `2026-03-10-il-canto-dei-cuori-ribelli.md`

### Frontmatter obbligatorio
```yaml
---
title: "Titolo del Libro"
date: YYYY-MM-DD
image: '/images/NomeImmagine.png'
description: "Breve descrizione"
---
```

---

## ⚠️ Regole Fondamentali

### 1. Cartella corretta
✅ Scegliere tra `posts/`, `libri/` o `kindle/` in base alla sezione  
❌ Mai creare sottocartelle o percorsi alternativi

### 2. Markdown puro
✅ Usare solo sintassi Markdown  
❌ Mai usare HTML raw (es. `<br>`, `<p>`, `<div>`)

### 3. Immagini — CASE SENSITIVE!
✅ Il path deve corrispondere ESATTAMENTE al nome file  
❌ `canto cuori.png` ≠ `Canto cuori.png`  
👉 Verificare sempre maiuscole/minuscole del file in `static/images/`

### 4. Link Amazon
✅ Usare il link specifico per il libro in questione  
❌ Mai copiare il link da un altro post  
👉 Verificare sempre che il link rimandi al libro corretto

### 5. Workflow obbligatorio
```
1. Chiedere a Salvatore: posts, libri o kindle?
2. Creare il file .md nella cartella corretta
3. Mostrare anteprima a Salvatore
4. Aspettare conferma esplicita
5. Solo dopo → git add . && git commit -m "..." && git push
```

---

## 🔄 Comandi Git Standard

```bash
cd ~/audiobookitaliani-blog
git add .
git commit -m "Add: titolo-del-libro"
git push
```

---

## ✅ Checklist Pre-Push

- [ ] Cartella giusta (posts / libri / kindle)?
- [ ] Nome immagine case-sensitive corretto?
- [ ] Link Amazon specifico per questo libro?
- [ ] Niente HTML raw nel testo?
- [ ] Confermato da Salvatore?

---

*Manuale creato il 10 marzo 2026 — AudiobookItaliani 🐉*
