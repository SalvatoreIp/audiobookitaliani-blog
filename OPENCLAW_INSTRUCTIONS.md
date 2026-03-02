# 🐉 OPENCLAW - Guida Gestione Blog Hugo

## ❌ NON RIMUOVERE MAI NULLA!
Il blog è GIÀ CONFIGURATO e FUNZIONANTE!

## 📂 Percorsi Importanti
- **Blog directory:** `/home/salvatore/audiobookitaliani-blog`
- **Contenuti:** `content/posts/`
- **URL live:** https://www.audiobookitaliani.com

## ✅ Come Creare Nuovo Post

### Passo 1: Vai nella directory
```bash
cd /home/salvatore/audiobookitaliani-blog


## 🔗 Gestione Link Affiliazione Amazon

### REGOLA IMPORTANTE:
NON generare mai link Amazon autonomamente!
Salvatore ti manda sempre il link corretto via Telegram.

### Come ricevi il link:
Salvatore scrive su Telegram:
"Aggiorna post [nome-post] con questo link: https://amzn.to/xxxxx"

### Cosa fare quando ricevi il link:
1. Trova il file in content/posts/ che corrisponde al nome del post
2. Cerca la sezione "Dove Ascoltare" nel post
3. Aggiungi il link in questo formato:

## Dove Ascoltare

Ascolta su Audible: https://amzn.to/xxxxx
Prova gratuita 30 giorni disponibile!
Acquistando tramite questo link supporti AudioBook Italiani gratuitamente.

4. Fai git add, commit e push
5. Conferma a Salvatore con il link live del post

### NON fare mai:
- Generare link Amazon da solo
- Modificare link esistenti gia approvati
- Usare link senza tag affiliazione di Salvatore


## 🐍 Sostituzioni Testo nei File .md
NON usare sed per sostituire testo nei file markdown!
Gli asterischi ** e le parentesi [] fanno crashare sed.
USA SEMPRE python3 per sostituire testo nei file .md:

python3 -c "
f = '/path/al/file.md'
content = open(f).read()
content = content.replace('TESTO_VECCHIO', 'TESTO_NUOVO')
open(f, 'w').write(content)
print('Fatto!')
"

## 🗂️ SEZIONI DEL SITO - REGOLA FONDAMENTALE

Il comando createBlogPost accetta 3 parametri:
1. Titolo
2. Descrizione  
3. Sezione (NON è il genere letterario!)

### Valori corretti per il 3° parametro:
- "audiolibri" → pubblica in content/posts/
- "kindle" → pubblica in content/kindle/
- "libri" → pubblica in content/libri/

### Esempio corretto:
createBlogPost 'Il Nome della Rosa' 'Capolavoro di Umberto Eco' 'kindle'

### ❌ NON usare come 3° parametro:
- fantascienza, fantasy, giallo, classici, horror, romanzi
- Quelli vanno nei TAG dentro il post, non come sezione!

## ⚠️ NOMI SEZIONI ESATTI
I nomi delle sezioni sono ESATTAMENTE questi tre:
- "audiolibri"
- "kindle"
- "libri"

NON usare MAI:
- "libri-cartacei" ❌
- "libri cartacei" ❌
- "ebook" ❌
- "audiobook" ❌
