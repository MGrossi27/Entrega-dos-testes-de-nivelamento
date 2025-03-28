--sequencia para a criaçao das tabelas.
DROP TABLE IF EXISTS demonstracoes_contabeis;

CREATE TABLE demonstracoes_contabeis (
    data DATE,
    reg_ans INTEGER,
    cd_conta_contabil TEXT,
    descricao TEXT,
    vl_saldo_inicial TEXT,
    vl_saldo_final TEXT
);

ALTER TABLE demonstracoes_contabeis
ADD COLUMN vl_inicial_num NUMERIC,
ADD COLUMN vl_final_num NUMERIC;

DROP TABLE IF EXISTS operadoras;

CREATE TABLE operadoras (
    registro_ans INTEGER,
    cnpj TEXT,
    razao_social TEXT,
    nome_fantasia TEXT,
    modalidade TEXT,
    logradouro TEXT,
    numero TEXT,
    complemento TEXT,
    bairro TEXT,
    cidade TEXT,
    uf TEXT,
    cep TEXT,
    ddd TEXT,
    telefone TEXT,
    fax TEXT,
    endereco_eletronico TEXT,
    representante TEXT,
    cargo_representante TEXT,
    regiao_de_comercializacao TEXT,
    data_registro_ans DATE
);
--processo de COPY de informações dos arquivos fornecidos pelo documento no enunciado 
COPY operadoras(registro_ans, cnpj, razao_social, nome_fantasia, modalidade,
                logradouro, numero, complemento, bairro, cidade, uf, cep,
                ddd, telefone, fax, endereco_eletronico, representante,
                cargo_representante, regiao_de_comercializacao, data_registro_ans)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/Relatorio_cadop.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

-- Arquivos trimestrais com ENCODING UTF8
COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/1T2023.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/2t2023.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/3T2023.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/4T2023.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/1T2024.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/2T2024.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/3T2024.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

COPY demonstracoes_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'C:/Users/Michael/Desktop/3-Teste de banco de dados/4T2024.csv'
DELIMITER ';' CSV HEADER ENCODING 'UTF8';

-- Corrige a vírgula para ponto nos valores, tive problema com acentos por ter usado o LATIN1, mas depois disso corrigi usando o UTF-8
UPDATE demonstracoes_contabeis
SET 
    vl_inicial_num = REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC,
    vl_final_num = REPLACE(vl_saldo_final, ',', '.')::NUMERIC;

--Cod para confirmar a descrição correta fornecida no enunciado.
SELECT DISTINCT descricao
FROM demonstracoes_contabeis
WHERE descricao ILIKE '%EVENTOS%' 
  AND descricao ILIKE '%SINISTROS%'
  AND descricao ILIKE '%ASSISTÊNCIA%'
  AND descricao ILIKE '%HOSPITALAR%';

--Cod do top 10 empresas com maiores despesas, comparada lado a lado. (TRIMESTRE E ANO))
WITH
trimestre AS (
    SELECT
        d.reg_ans,
        SUM(d.vl_final_num) AS total_trimestre
    FROM demonstracoes_contabeis d
    WHERE d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
      AND d.data >= (SELECT MAX(data) - INTERVAL '3 months' FROM demonstracoes_contabeis)
    GROUP BY d.reg_ans
),
ano AS (
    SELECT
        d.reg_ans,
        SUM(d.vl_final_num) AS total_ano
    FROM demonstracoes_contabeis d
    WHERE d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
      AND d.data >= (SELECT MAX(data) - INTERVAL '12 months' FROM demonstracoes_contabeis)
    GROUP BY d.reg_ans
)
SELECT
    o.razao_social,
    a.total_ano,
    t.total_trimestre
FROM ano a
JOIN trimestre t ON a.reg_ans = t.reg_ans
JOIN operadoras o ON o.registro_ans = a.reg_ans
ORDER BY a.total_ano DESC
LIMIT 10;

--Cod do top 10 empresas com maiores despesas, dentro de 3 meses.
SELECT o.razao_social,
       d.reg_ans,
       SUM(d.vl_final_num) AS total_despesa
FROM demonstracoes_contabeis d
JOIN operadoras o ON o.registro_ans = d.reg_ans
WHERE d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
  AND d.data >= (
      SELECT MAX(data) - INTERVAL '3 months' FROM demonstracoes_contabeis
  )
GROUP BY o.razao_social, d.reg_ans
ORDER BY total_despesa DESC
LIMIT 10;

--Cod do top 10 empresas com maiores despesas, dentro de 1 ano.
SELECT o.razao_social,
       d.reg_ans,
       SUM(d.vl_final_num) AS total_despesa
FROM demonstracoes_contabeis d
JOIN operadoras o ON o.registro_ans = d.reg_ans
WHERE d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
  AND d.data >= (
      SELECT MAX(data) - INTERVAL '12 months' FROM demonstracoes_contabeis
  )
GROUP BY o.razao_social, d.reg_ans
ORDER BY total_despesa DESC
LIMIT 10;




