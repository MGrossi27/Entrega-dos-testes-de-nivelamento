import requests 
from bs4 import BeautifulSoup
import os
import urllib.request
from zipfile import ZipFile

url = 'https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos'
os.makedirs("anexos", exist_ok=True)

response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

pdf_links = []
for link in soup.find_all('a', href=True):
    href = link['href']
    text = link.get_text().lower()
    if ('anexo i' in text or 'anexo ii' in text) and href.endswith('.pdf'):
        full_url = href if href.startswith('http') else f"https://www.gov.br{href}"
        pdf_links.append(full_url)

if len(pdf_links) < 2:
    print("Atenção: nem todos os anexos foram encontrados.")
else:
    print("Links encontrados com sucesso.")

pdf_paths = []
for pdf_url in pdf_links:
    try:
        filename = os.path.join("anexos", pdf_url.split('/')[-1])
        urllib.request.urlretrieve(pdf_url, filename)
        pdf_paths.append(filename)
        print(f"Download concluído: {filename}")
    except Exception as e:
        print(f"Erro ao baixar {pdf_url}: {e}")

if pdf_paths:
    try:
        with ZipFile('anexos.zip', 'w') as zipf:
            for file in pdf_paths:
                zipf.write(file)
        print("Compactação finalizada com sucesso.")
    except Exception as e:
        print(f"Erro ao compactar os arquivos: {e}")
else:
    print("Nenhum PDF foi baixado. Nenhum arquivo compactado.")
