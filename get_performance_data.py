
import datetime
from googleapiclient.discovery import build
from google.oauth2 import service_account
import json
import pandas as pd

# Percorso del file JSON delle credenziali
CREDENTIALS_FILE = 'credentials.json'

# Costruisci l'oggetto del servizio Search Console
credentials = service_account.Credentials.from_service_account_file(
    CREDENTIALS_FILE,
    scopes=['https://www.googleapis.com/auth/webmasters.readonly'])

service = build('webmasters', 'v3', credentials=credentials)

# Proprietà del sito da analizzare
site_url = 'sc-domain:audiobookitaliani.com'

# Date per la query (ultimi 3 mesi)
end_date = datetime.date.today()
start_date = end_date - datetime.timedelta(days=90)

# Costruisci la richiesta di query per la performance
request = {
    'startDate': start_date.isoformat(),
    'endDate': end_date.isoformat(),
    'dimensions': ['query', 'page'], # Raggruppiamo per query e pagina
    'rowLimit': 1000, # Aumentiamo a 1000 righe
    'startRow': 0,
    'dataState': 'all' # Richiede i dati più recenti disponibili
}

print(f"Recuperando i dati di Search Console per {site_url} dal {start_date} al {end_date} (prime 1000 righe)...")

try:
    response = service.searchanalytics().query(
        siteUrl=site_url,
        body=request
    ).execute()

    if 'rows' in response:
        data = []
        for row in response['rows']:
            data.append({
                'query': row['keys'][0],
                'page': row['keys'][1],
                'clicks': row['clicks'],
                'impressions': row['impressions'],
                'ctr': row['ctr'],
                'position': row['position']
            })
        
        df = pd.DataFrame(data)

        # ------------- Analisi ------------- 
        print("\n--- Analisi Prioritaria ---")

        # Top 5 Query per Click
        top_clicks_queries = df.groupby('query').agg({'clicks': 'sum', 'impressions': 'sum', 'ctr': 'mean', 'position': 'mean'}).sort_values(by='clicks', ascending=False).head(5)
        print("\nTop 5 Query per Clic:")
        print(top_clicks_queries.to_string(float_format="%.2f"))

        # Top 5 Query per Impression
        top_impressions_queries = df.groupby('query').agg({'clicks': 'sum', 'impressions': 'sum', 'ctr': 'mean', 'position': 'mean'}).sort_values(by='impressions', ascending=False).head(5)
        print("\nTop 5 Query per Impression:")
        print(top_impressions_queries.to_string(float_format="%.2f"))

        # Pagine con più click
        top_clicks_pages = df.groupby('page').agg({'clicks': 'sum', 'impressions': 'sum', 'ctr': 'mean', 'position': 'mean'}).sort_values(by='clicks', ascending=False).head(5)
        print("\nTop 5 Pagine per Clic:")
        print(top_clicks_pages.to_string(float_format="%.2f"))

        # Pagine con più impression
        top_impressions_pages = df.groupby('page').agg({'clicks': 'sum', 'impressions': 'sum', 'ctr': 'mean', 'position': 'mean'}).sort_values(by='impressions', ascending=False).head(5)
        print("\nTop 5 Pagine per Impression:")
        print(top_impressions_pages.to_string(float_format="%.2f"))


    else:
        print("Nessun dato di performance trovato per il periodo specificato.")

except Exception as e:
    print(f"Errore durante il recupero dei dati di performance: {e}")
