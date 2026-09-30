# Coda argomenti per la pubblicazione automatica

Uso interno del cron giornaliero (non è un articolo). Formato:
`- [ ] Titolo proposto | sezione | slug | keyword target (volume/mese, difficoltà) | note`

## Da pubblicare

(vuota: da rifornire con una ricerca keyword OpenSEO in una sessione interattiva)

## Pubblicati

- [x] Piccole donne audiolibro italiano: la voce di Alessandra Mastronardi | recensioni | piccole-donne-audiolibro-italiano-2026 | "piccole donne audiolibro" | 2026-09-30, scelta senza dati di volume (coda vuota, filone "audiolibro di un libro molto letto in Italia", non ancora coperto: verificato con grep che nessun altro articolo trattava Piccole donne). Edizione Emons narrata da Alessandra Mastronardi (11h55m, pubblicata 21/05/2020) verificata su Audible.it/Amazon.it; ASIN B088JZSHX5 verificato su amazon.it. Citata anche l'edizione alternativa Recitar Leggendo/Laura Pierantoni, non usata come link principale.

- [x] 1984 di Orwell audiolibro italiano: narratore e durata | recensioni | 1984-orwell-audiolibro-italiano-2026 | "1984 audiolibro" | 2026-09-29, scelta senza dati di volume (coda vuota, filone "audiolibro di un libro molto letto in Italia", non ancora coperto). Edizione Mondadori narrata da Daniele Crasti (11h12m, pubblicata 18/12/2019) verificata su Audible.it/Amazon.it; ASIN B085VGCK4Z verificato su amazon.it. Citata anche l'edizione alternativa GoodMood/Daniele Ornatelli (ASIN B08RJV5N9C), non usata come link principale.

- [x] Migliori audiolibri horror da ascoltare: 5 classici da brivido | posts | migliori-audiolibri-horror | "audiolibri horror" | 2026-09-28, scelta senza dati di volume (coda vuota, filone "liste tematiche"; evitato il filone "audiolibro di libro molto letto" già usato ieri, ed evitato l'argomento gialli/thriller perché già coperto da migliori-audiolibri-thriller-italiani-2026). Titoli e dati (narratore, durata, editore, ASIN) verificati via web search e pagine Audible.it/Amazon.it: Dracula (Paolo Pierobon, Emons, ASIN B0BJS77S21), Frankenstein (Massimo Popolizio, Emons, 9h32m, ASIN B07YQ4GZGP), Il richiamo di Cthulhu (Librinpillole, Vizi Editore, 1h37m, ASIN B09T3DQ8FF), Racconti del terrore di Poe (Troiano/Mancioppi, GoodMood, 1h28m, ASIN B01BY1V1F6). Per Il giro di vite (Lalle/Riva, Saga Egmont) non ho trovato un ASIN amazon.it affidabile: link di ricerca.

- [x] Il nome della rosa audiolibro: narratore e durata | recensioni | il-nome-della-rosa-audiolibro-italiano-2026 | "il nome della rosa audiolibro" | 2026-09-27, scelta senza dati di volume (coda vuota, filone "audiolibro di un libro molto letto in Italia"). Narratore Tommaso Ragno, edizione integrale Emons (2016, ~20h23m) verificata su Audible/Amazon.it; ASIN B08YYWDN4Z verificato per l'edizione Audible su Amazon.it.

- [x] Audiolibri per dormire: storie e meditazioni su Audible | posts | audiolibri-per-dormire-2026 | "audiolibri per dormire" | 2026-09-26, scelta senza dati di volume. Titoli presi dalle pagine editoriali Audible.it (blog/audiolibri-per-dormire e storie-per-dormire); tutti i link sono di ricerca Audible, nessun ASIN verificato.

- [x] Come ascoltare audiolibri in auto: guida 2026 | posts | ascoltare-audiolibri-in-auto | "ascoltare audiolibri in auto" | 2026-09-26, scelta senza dati di volume. Metodi presi dalla pagina di aiuto ufficiale aiuto.audible.it (Ascoltare Audible in auto); tutti i link sono di ricerca Audible, nessun ASIN.

## Quando la coda è vuota

1. Scegli tra questi filoni, alternandoli: audiolibro di un libro molto letto in Italia ("<titolo> audiolibro italiano"), novità e classifiche del mese, guide pratiche (Audible prova gratuita, Kindle Unlimited conviene, come ascoltare audiolibri in auto), liste tematiche ("audiolibri per dormire", "gialli da ascoltare").
2. Con WebSearch verifica che l'audiolibro esista davvero in italiano su Audible (o su Storytel) e raccogli narratore e durata.
3. Controlla con grep in content/ di non averlo già trattato.
4. Pubblica e aggiungilo sotto "Pubblicati" con `- [x]`, data e la nota "scelta senza dati di volume".
