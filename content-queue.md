# Coda argomenti per la pubblicazione automatica

Uso interno del cron giornaliero (non è un articolo). Formato:
`- [ ] Titolo proposto | sezione | slug | keyword target (volume/mese, difficoltà) | note`

## Da pubblicare

(vuota: da rifornire con una ricerca keyword OpenSEO in una sessione interattiva)

## Pubblicati

- [x] Il nome della rosa audiolibro: narratore e durata | recensioni | il-nome-della-rosa-audiolibro-italiano-2026 | "il nome della rosa audiolibro" | 2026-09-27, scelta senza dati di volume (coda vuota, filone "audiolibro di un libro molto letto in Italia"). Narratore Tommaso Ragno, edizione integrale Emons (2016, ~20h23m) verificata su Audible/Amazon.it; ASIN B08YYWDN4Z verificato per l'edizione Audible su Amazon.it.

- [x] Audiolibri per dormire: storie e meditazioni su Audible | posts | audiolibri-per-dormire-2026 | "audiolibri per dormire" | 2026-09-26, scelta senza dati di volume. Titoli presi dalle pagine editoriali Audible.it (blog/audiolibri-per-dormire e storie-per-dormire); tutti i link sono di ricerca Audible, nessun ASIN verificato.

- [x] Come ascoltare audiolibri in auto: guida 2026 | posts | ascoltare-audiolibri-in-auto | "ascoltare audiolibri in auto" | 2026-09-26, scelta senza dati di volume. Metodi presi dalla pagina di aiuto ufficiale aiuto.audible.it (Ascoltare Audible in auto); tutti i link sono di ricerca Audible, nessun ASIN.

## Quando la coda è vuota

1. Scegli tra questi filoni, alternandoli: audiolibro di un libro molto letto in Italia ("<titolo> audiolibro italiano"), novità e classifiche del mese, guide pratiche (Audible prova gratuita, Kindle Unlimited conviene, come ascoltare audiolibri in auto), liste tematiche ("audiolibri per dormire", "gialli da ascoltare").
2. Con WebSearch verifica che l'audiolibro esista davvero in italiano su Audible (o su Storytel) e raccogli narratore e durata.
3. Controlla con grep in content/ di non averlo già trattato.
4. Pubblica e aggiungilo sotto "Pubblicati" con `- [x]`, data e la nota "scelta senza dati di volume".
