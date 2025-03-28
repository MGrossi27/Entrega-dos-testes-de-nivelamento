import pdfplumber
import pandas as pd
import zipfile
import os

pdf_path = "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
csv_filename = "Rol_Procedimentos.csv"
zip_filename = "Teste_Michael.zip"

legenda = {
    "OD": "Odontológico",
    "AMB": "Ambulatorial"
}

dados = []

with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        tabela = page.extract_table()
        if tabela:
            dados.extend(tabela[1:])

colunas = tabela[0]
df = pd.DataFrame(dados, columns=colunas)
df.columns = [col.replace('\n', ' ').strip() for col in df.columns]
for col in df.columns:
    if df[col].dtype == object:
        df[col] = df[col].replace(legenda)

df.to_csv(csv_filename, index=False)

with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(csv_filename)

os.remove(csv_filename)

print(f"Arquivo {zip_filename} criado com sucesso.")