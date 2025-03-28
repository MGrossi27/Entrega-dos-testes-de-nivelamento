from flask import Flask, request, jsonify, Response
from flask_cors import CORS
import pandas as pd
import json

app = Flask(__name__)
CORS(app)

df = pd.read_csv('Relatorio_cadop.csv', delimiter=';', encoding='utf-8')

@app.route('/buscar', methods=['GET'])
def buscar_operadoras():
    termo = request.args.get('q', '').strip().lower()
    if not termo:
        return Response(
            json.dumps([], ensure_ascii=False),
            content_type='application/json; charset=utf-8'
        )

    resultados = df[df['Razao_Social'].str.lower().str.contains(termo) |
                    df['Nome_Fantasia'].str.lower().str.contains(termo)]

    resultados = resultados.fillna("") 

    return Response(
        json.dumps(resultados.to_dict(orient='records'), ensure_ascii=False),
        content_type='application/json; charset=utf-8'
    )

if __name__ == '__main__':
    app.run(debug=True)
