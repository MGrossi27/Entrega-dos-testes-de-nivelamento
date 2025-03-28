# Teste 1 – Web Scraping 

📎 Também incluí um `.txt` com as mesmas instruções, para facilitar leitura offline ou por ferramentas que não renderizam markdown.

## Sobre o que é esse teste.

Um script que acessa o site da ANS, procura pelos arquivos "Anexo I" e "Anexo II", faz o download automático deles e depois junta os dois em um arquivo compactado.


## O que foi usado aqui:

- `Python 3.11`
-  `VsCode` →  para aconstrução do codigo
- `requests` → pra fazer a requisição HTTP
- `BeautifulSoup` → pra vasculhar a estrutura HTML da página
- `urllib.request` → pra fazer o download direto dos arquivos PDF
- `zipfile` → pra compactar os dois arquivos baixados
- `os` e `re` → pra organizar as pastas e tratar os nomes

## Observações finais:

- O código tá simples, mas funcional.
- Não tem tratamento muito avançado de erros, mas tentei manter claro e sem complicação.
- Tomei a liberdade de implementar uma função que assim que baixado, os arquivos são colocados em uma pasta e após isso são zipados, para deixar com uma organização melhorada.
---

Feito por Michael Grossi Farias - estudante de Ciência da Computação - candidato a vaga de Engenharia de Software. 🎓
