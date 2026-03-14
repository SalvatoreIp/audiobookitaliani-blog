# Istruzioni Operative Blog Hugo (AGGIORNATE)

## ✅ REGOLE D'ORO PER PUBBLICARE SENZA ERRORI

### 1. **SEZIONE CORRETTA** (obbligatorio)
- **Solo queste cartelle esistono**: `posts`, `kindle`, `libri`
- **Esempio**: Se vuoi un articolo standard → `SEZIONE=posts`
- **Verifica**: `ls /home/salvatore/audiobookitaliani-blog/content/`

### 2. **IMMAGINE PERFETTA**
- **Percorso fisico**: `static/images/covers/nome-file.jpg`
- **Nel frontmatter YAML**:
  ```yaml
  cover:
    image: /images/covers/nome-file.jpg' 
    alt: 'Descrizione accessibile'
  ```
- **Attenzione**: Copia SEMPRE l'immagine in `static/` PRIMA della pubblicazione

### 3. **DESCRIZIONE FORMATTATA** (minimo 400 caratteri totali)
- **Struttura obbligatoria**:
  ```
## 👉 [Acquista su Amazon](https://amzn.to/...)
[Introduzione libera] (min 200 caratteri)

## 📖 Introduzione e Contesto
[Contenuto] (min 200 caratteri)

## 📖 Trama (senza spoiler)
[Contenuto] (min 200 caratteri)

## 🎯 Perché leggerlo
[Contenuto] (min 150 caratteri)
⭐ VOTO: X/10 - Descrizione breve

## 📚 Libri Correlati
- [Titolo](/link/)

## 👉 [Acquista su Amazon](https://amzn.to/...)
Supporta AudioBook Italiani acquistando tramite i nostri link!
  ```
- **Esempio di BUONA descrizione**:
  > "## 👉 [Acquista su Amazon](https://amzn.to/...)
Un'opera che insegna a riconoscere la magia nell'ordinario..."

## 🛠 FLUSSO OPERATIVO COMPLETO
```bash
# 1. Posiziona l'immagine in static/
mkdir -p static/images/covers/
cp /percorso/immagine.jpg static/images/covers/nome-file.jpg

# 2. Esegui lo script con SEZIONE corretta
./scripts/publish_blog_post_PERFETTO.sh \
  "Titolo Post" \
  "Introduzione...\n\nTrama...\n\nPerché leggerlo..." \
  "https://amzn.to/..." \
  "posts" \
  "/cover/nome-file.jpg"

# 3. Verifica il commit prima del push
git diff
```

---

## 🕵️ NAVIGAZIONE STEALTH ANTI-BOT

### Quando usarla
Usa lo script stealth quando un sito blocca il browser normale (Cloudflare, Amazon, IBS, ecc.)

### Comando
    ~/.openclaw/skills/stealth-browser/generate.sh URL

### Regole ASSOLUTE
- MAI usare Browser Relay - siamo su VPS, Chrome locale NON ESISTE!
- MAI chiedere di attivare estensioni Chrome
- Se un sito blocca -> usa stealth-browser, non il browser interno


---

## LINK AMAZON AFFILIATI

- **Formato obbligatorio**: `## 👉 [Acquista su Amazon](https://amzn.to/XXXXXXX)` (con emoji e formattazione)
- **Posizione**: All'inizio e alla fine del corpo del post
- **Testo personalizzato**: Alla fine, aggiungere "Supporta AudioBook Italiani acquistando tramite i nostri link!"
- **Esempio**:
  ```markdown
## 👉 [Acquista su Amazon](https://amzn.to/...)
Un'opera che insegna a riconoscere la magia nell'ordinario...

... (contenuto del post) ...

## 👉 [Acquista su Amazon](https://amzn.to/...)
Supporta AudioBook Italiani acquistando tramite i nostri link!
  ```
