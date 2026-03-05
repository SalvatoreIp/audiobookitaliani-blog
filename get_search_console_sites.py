
import os
from googleapiclient.discovery import build
from google.oauth2 import service_account

# Percorso del file JSON delle credenziali
CREDENTIALS_FILE = 'credentials.json'

# Costruisci l'oggetto del servizio Search Console
credentials = service_account.Credentials.from_service_account_file(
    CREDENTIALS_FILE,
    scopes=['https://www.googleapis.com/auth/webmasters.readonly'])

service = build('webmasters', 'v3', credentials=credentials)

# Recupera l'elenco delle proprietà
try:
    site_list = service.sites().list().execute()
    print("Proprietà Search Console accessibili:")
    if 'siteEntry' in site_list:
        for site in site_list['siteEntry']:
            print(f"- {site['siteUrl']}")
    else:
        print("Nessuna proprietà trovata o accessibile.")
except Exception as e:
    print(f"Errore durante il recupero delle proprietà: {e}")
