# Teste 2 - Conversão de PDF para CSV

📎 Também incluí um `.txt` com as mesmas instruções, para facilitar leitura offline ou por ferramentas que não renderizam markdown.

---

## Desafio
Um script que analisa o pdf ''anexo 1'', extrai as tabelas de todas as páginas e organiza os dados e faz a conversão do conteúdo para um arquivo CSV.

---

## O que foi usado aqui:

- `Python 3.11`
-  `VsCode` →  para aconstrução do codigo
- `pdfplumber` →  para ler textos e tabelas dentro de arquivos PDF.
- `pandas` → para organizar os dados em formato de tabela (como Excel/CSV).
- `zipfile / os` → compactar os dois arquivos baixados / organizar as pastas e tratar os nomes

---

## Observações

- O script analisa todas as páginas do PDF automaticamente.
- A substituição de siglas "OD" e "AMB" é feita com base na legenda encontrada no rodapé do documento.
- O CSV é excluído após ser compactado, deixando apenas o `.zip` final.

---

Feito por Michael Grossi Farias - estudante de Ciência da Computação - candidato a vaga de Engenharia de Software. 🎓
