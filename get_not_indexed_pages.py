import argparse
import google.oauth2.credentials
from google.oauth2 import service_account
from googleapiclient.discovery import build
import json
import datetime

# Impostazioni per l'API
SCOPES = ['https://www.googleapis.com/auth/webmasters.readonly']
SEARCH_CONSOLE_API_SERVICE_NAME = 'searchconsole' # Modificato a 'searchconsole'
SEARCH_CONSOLE_API_VERSION = 'v1' # Modificato a 'v1'

def get_service(credentials_file):
    """Restituisce un oggetto di servizio Google Search Console autenticato."""
    credentials = service_account.Credentials.from_service_account_file(
        credentials_file, scopes=SCOPES)
    return build(SEARCH_CONSOLE_API_SERVICE_NAME, SEARCH_CONSOLE_API_VERSION,
                 credentials=credentials)

def get_indexing_status(service, property_url):
    """Ottiene un riepilogo dello stato di indicizzazione (copertura) per la proprietà."""
    print(f"Tentativo di ottenere lo stato di copertura per {property_url} usando {SEARCH_CONSOLE_API_SERVICE_NAME} {SEARCH_CONSOLE_API_VERSION}...")
    try:
        # L'API Search Console v1 non ha un endpoint diretto per "pagine non indicizzate"
        # e i relativi conteggi come nella UI. Quella funzionalità è lato UI o richiede
        # chiamate più complesse all'API siteVerification o custom reports.

        # Possiamo però ottenere i tipi di errori di scansione generali.
        # Il metodo urlCrawlErrors.query di solito serve per ottenere le categorie di errore,
        # mentre urlCrawlErrors.list fornisce esempi di URL con errori.

        # Cerchiamo di ottenere i tipi di errore e per ciascuno, il numero di URL.
        # Questo è il modo più vicino per avere una scomposizione degli errori di scansione.
        
        # Primo, otteniamo le categorie di errori
        error_rules = service.urlCrawlErrors().query(siteUrl=property_url).execute()
        
        total_not_indexed = 0
        print("\n--- Dettagli degli errori di scansione ---")
        if 'urlCrawlErrorType' in error_rules:
            for error_type in error_rules['urlCrawlErrorType']:
                category = error_type['category']
                count = error_type['count']
                platform = error_type['platform']
                print(f"  Categoria: {category}, Piattaforma: {platform}, Conteggio URL: {count}")
                total_not_indexed += count
        else:
            print("Nessun tipo di errore di scansione rilevato.")

        print(f"\nTotale URL con errori di scansione (approssimativo delle 'non indicizzate' a causa di errori): {total_not_indexed}")
        print("\nNota: I conteggi sopra riflettono solo le URL con errori di scansione attivi. \nNon includono altre categorie di 'non indicizzate' come 'Escluse da noindex', 'Pagine con reindirizzamento', ecc., \nche vengono mostrate nella UI di Google Search Console ma non sono direttamente accessibili tramite questa API v1 in questo formato aggregato.")

        return total_not_indexed
        
    except Exception as e:
        print(f"Errore durante il recupero dello stato di copertura: {e}")
        return -1


def main():
    parser = argparse.ArgumentParser(description='Ottiene lo stato di indicizzazione dalla Google Search Console.')
    parser.add_argument('--credentials', required=True, help="Percorso al file JSON delle credenziali dell'account di servizio.")
    parser.add_argument('--property_url', required=True, help="L'URL della proprietà Search Console (es. sc-domain:example.com).")
    args = parser.parse_args()

    service = get_service(args.credentials)
    count = get_indexing_status(service, args.property_url)
    if count != -1:
        print(f"Riepilogo: {count} URL con errori di scansione.\nPer un report più dettagliato, consulta la UI di Google Search Console.")

if __name__ == '__main__':
    main()
