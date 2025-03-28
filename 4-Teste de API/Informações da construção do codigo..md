# Teste 4 – API + Frontend Vue.js

📎 Também incluí um `.txt` com as mesmas instruções, para facilitar leitura offline ou por ferramentas que não renderizam markdown.

---

## Sobre o que é esse teste.

.Crie um servidor com uma rota que realize uma busca textual na lista de cadastros de operadoras
e retorne os registros mais relevantes.

---

## Como funciona

###  Backend (`app.py`)
- Lê o arquivo `Relatorio_cadop.csv`
- Rota `/buscar` recebe um parâmetro `q` por GET
- Retorna os registros mais relevantes em formato JSON
- `pandas`→ No código, ele carrega o Relatorio_cadop.csv e aplica o filtro da busca
- `flask`→ é o cérebro da API que responde às buscas
- `flask_cors` → Com ele, A API pode ser usada pelo frontend local


### Frontend (`App.vue`)
- Campo de busca com `v-model`→ Isso faz com que a busca funcione com o que for digitado
- Botão ''buscar'' envia a consulta à API
- Tabela mostra os resultados formatados
- Estilo escuro e minimalista somente para o teste.
- A Organização da pasta `src/` foi simplificada, removendo arquivos padrões (`HelloWorld.vue`, `vue.svg`)
- Tudo centralizado no `App.vue` para facilitar entendimento

---
###  Teste no navegador:
Acesse: http://localhost:5173  
Pesquise por: `Bradesco`, `Amil`, etc.

---

##  Teste via Postman

Coleção exportada: `Teste API Operadoras.postman_collection.json`

Faça uma requisição GET:
```
http://localhost:5000/buscar?q=amil
```
 **Importante:**  
Por questões de tamanho, o arquivo `Relatorio_cadop.csv` **não está incluso no repositório**.  
Para rodar corretamente, baixe o arquivo atualizado diretamente da ANS:

🔗 https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/
---


Feito por Michael Grossi Farias - estudante de Ciência da Computação - candidato a vaga de Engenharia de Software. 🎓
