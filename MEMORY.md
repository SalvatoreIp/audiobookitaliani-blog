# MEMORY.md - Conoscenze a Lungo Termine

## Apprendimenti da sessione precedente (2026-03-02)

### Flusso di lavoro per la pubblicazione di post Hugo:
- Utilizzare sempre lo script `publish_blog_post_PERFETTO.sh`.
- Fornire tutti e 5 i parametri allo script: `TITOLO`, `DESCRIZIONE`, `LINK_AMAZON`, `SEZIONE` (non affidarsi al default "posts"), `PERCORSO_IMMAGINE`.
- Assicurarsi che la `DESCRIZIONE` contenga i tre blocchi con i minimi di caratteri richiesti.
- Sequenza Git obbligatoria: `git pull`, `git add .`, `git commit -m "Messaggio descrittivo"`, `git push`. Eseguire sempre `git pull` prima di `git add` o `git commit`.
- Eseguire i comandi Git con `workdir = "/home/salvatore/audiobookitaliani-blog/"`.

### Gestione del frontmatter YAML:
- Controllare attentamente l'escaping di apostrofi e virgolette all'interno del frontmatter.
- Preferire l'uso delle doppie virgolette (") per le stringhe che contengono apostrofi ('), specialmente nei campi `title` e `alt` delle cover.
- In caso di errori YAML, ispezionare la riga indicata nel log di errore per problemi di indentazione o escaping. (L'errore "did not find expected key" spesso indica un problema con il valore della chiave).

### Contenuto dello script `publish_blog_post_PERFETTO.sh`:
- Lo script è stato modificato per includere il link Amazon all'inizio del corpo del post e per usare la `$DESCRIPTION` completa.

### Identificazione errori comuni:
- In caso di errore "nothing to commit, working tree clean", verificare che il file sia stato effettivamente creato e che il percorso `workdir` sia corretto.

## Lezioni Apprese Sessione Corrente (2026-03-03)

- **Gestione file di memoria:** Assicurarsi di creare `memory/YYYY-MM-DD.md` per la data corrente e controllare quello del giorno precedente, come indicato in `AGENTS.md`. Creare `MEMORY.md` se non esiste all'inizio di una main session.
- **Feedback post:** Il post `Libro Meditazione Profonda e Autoconoscenza di Mariano Ballester` è stato approvato e considerato `molto bene`.
- **Nuova regola operativa:** Prima di eseguire `git push`, mostrare sempre il file Markdown del post creato per la revisione finale di Salvatore.

## Lezioni Apprese Sessione Corrente (2026-03-04)

- **Problemi di memoria interna:** Riscontrati seri problemi nel richiamo della storia della sessione, anche dopo aver riletto i file `SOUL.md`, `MEMORY.md`, `IDENTITY.md`, `OPENCLAW_INSTRUCTIONS.md`. Questo ha portato a ripetizioni e false partenze.
- **Accesso Search Console API:**
    - Per accedere ai dati di performance (clicks, impressions, queries, pages, CTR, position) della Google Search Console, l'API corretta da utilizzare è la **Search Console API** (quella usata per estrarre i dati con `get_performance_data.py`).
    - L'API `webmasters` v3 e `searchconsole` v1 (con i metodi `urlCrawlErrors` o similari) non forniscono direttamente i dati aggregati del "Report sulla Copertura" (pagine non indicizzate, escluse da noindex, redirect, soft 404) come visualizzato nell'interfaccia utente. Tentativi di recuperarli programmaticamente con queste API non sono andati a buon fine.
- **Installazione Dipendenze Python e Ambiente Virtuale:**
    - Ricordare che sui sistemi Linux moderni, `pip install` a livello globale può fallire a causa di `externally-managed-environment`.
    - La procedura corretta è creare e attivare un ambiente virtuale (es. `python3 -m venv venv && source venv/bin/activate`) e installare lì le dipendenze (`pip install google-api-python-client oauth2client pandas`).
- **File Credenziali:** Il file JSON delle credenziali dell'account di servizio (`gen-lang-client-0968553630-1338af4950fd---4a2c0dd7-b7ad-4e1b-b213-d3ccc5777f33.json`) deve essere presente nella working directory (`/home/salvatore/.openclaw/workspace/`) e rinominato in `credentials.json` per essere utilizzato dagli script Python.
- **Script di Performance:** Lo script `get_performance_data.py` è stato verificato e funziona per ottenere i dati di performance. La sua esecuzione richiede l'attivazione dell'ambiente virtuale e l'uso dello script con i parametri `--credentials credentials.json --property_url sc-domain:audiobookitaliani.com`.
- **Errori di Sintassi Comuni:** Prestare massima attenzione all'escaping degli apostrofi (`'`) nelle stringhe `help` di `argparse` o usare le doppie virgolette (`"`) per racchiudere l'intera stringa.
- **Errori di Esecuzione Script Python:** Verificare sempre che l'entry point dello script sia corretto (`if __name__ == '__main__':`) per assicurare che la funzione `main()` venga chiamata.
- **Conferma dello stato corrente:** Lo script `get_performance_data.py` ha prodotto dati significativi sui clic, impression, CTR e posizione media per query e pagine del blog `audiobookitaliani.com`.
- **Risoluzione di problemi di memoria:** In caso di futuri "vuoti di memoria" o comportamenti incoerenti, richiedere immediatamente a Salvatore il contesto più recente e/o la riesecuzione dei tool rilevanti. Prioritizzare il riallineamento della memoria prima di procedere con nuove task.
