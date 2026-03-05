import argparse
import google.oauth2.credentials
from google.oauth2 import service_account
from googleapiclient.discovery import build
import csv

# Impostazioni per l'API Indexing (non webmasters v3 per l'invio)
SCOPES = ['https://www.googleapis.com/auth/indexing'] # Scope specifico per Indexing API
DISCOVERY_URL = 'https://indexing.googleapis.com/$discovery/rest?version=v3' # URL Discovery per Indexing API v3

def get_service(credentials_file):
    """Restituisce un oggetto di servizio Google Indexing API autenticato."""
    credentials = service_account.Credentials.from_service_account_file(
        credentials_file, scopes=SCOPES)
    
    # La Indexing API non usa il nome servizio e versione tradizionale, ma un URL Discovery
    return build('indexing', 'v3', credentials=credentials, discoveryServiceUrl=DISCOVERY_URL)

def request_indexing(service, url):
    """Richiede l'indicizzazione di una singola URL tramite l'Indexing API."""
    body = {
        'url': url,
        'type': 'URL_UPDATED' # Oppure 'URL_DELETED'
    }
    try:
        # urlNotifications è l'unico metodo disponibile (publish)
        response = service.urlNotifications().publish(body=body).execute()
        print(f"Richiesta di indicizzazione inviata per: {url}. Risposta: {response}")
        return True
    except Exception as e:
        print(f"Errore durante l'invio della richiesta di indicizzazione per {url}: {e}")
        print("Assicurati che l'account di servizio abbia i permessi corretti per l'Indexing API (scope 'https://www.googleapis.com/auth/indexing').")
        return False

def main():
    parser = argparse.ArgumentParser(description="Richiede l'indicizzazione di URL tramite Google Search Console Indexing API.")
    parser.add_argument('--credentials', required=True, help="Percorso al file JSON delle credenziali dell'account di servizio.")
    parser.add_argument('--csv_file', required=True, help="Percorso al file CSV contenente l'elenco delle URL.")
    args = parser.parse_args()

    # URL di base del sito per comporre gli URL completi dal CSV se necessario
    BASE_URL = 'https://www.audiobookitaliani.com'

    urls_from_csv = []
    with open(args.csv_file, mode='r', newline='') as file:
        reader = csv.reader(file)
        next(reader) # Salta l'header
        for row in reader:
            full_url = f"https://www.audiobookitaliani.com{row[0].strip()}" # Usiamo BASE_URL esplicitamente
            urls_from_csv.append(full_url)
    
    # Filtra le URL secondo la strategia decisa
    urls_to_index = []
    for url in urls_from_csv:
        relative_url = url.replace(BASE_URL, '')
        if (
            relative_url.startswith('/posts/') or
            relative_url == '/about/' or
            relative_url == '/privacy/' or
            relative_url == '/kindle/' or 
            relative_url.startswith('/libri/') 
        ): 
            urls_to_index.append(url)
    
    print(f"Trovate {len(urls_to_index)} URL da inviare per l'indicizzazione.")

    if not urls_to_index:
        print("Nessuna URL da inviare per l'indicizzazione dopo il filtraggio.")
        return

    service = get_service(args.credentials)
    for url in urls_to_index:
        request_indexing(service, url)

if __name__ == '__main__':
    main()
