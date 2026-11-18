-- =====================================================================
-- CLÍNICA MÉDICA - Script completo (MySQL 8 / Workbench)
-- Modelo: Paciente, Medico, LocalConsulta e  Consulta
-- Conteúdo:
--   1. Criação do banco e das tabelas (conforme o DER)
--   2. Inserts
--   3. Consultas com JOIN / LEFT JOIN / RIGHT JOIN
--   4. Funções de agregação, GROUP BY e HAVING
--   5. Funções matemáticas e de texto/data
--   6. Subqueries
--   7. Views
-- =====================================================================


-- =====================================================================
-- 1. CRIAÇÃO DO BANCO E DAS TABELAS
-- =====================================================================
DROP DATABASE IF EXISTS clinica;
CREATE DATABASE clinica;
USE clinica;

CREATE TABLE paciente (
  idPaciente     INT PRIMARY KEY AUTO_INCREMENT,
  nome           VARCHAR(45) NOT NULL,
  genero         CHAR(1)     NOT NULL, -- 'F', 'M' ou 'O'
  dataNascimento DATE        NOT NULL
) auto_increment = 1000;

CREATE TABLE medico (
  idMedico      INT PRIMARY KEY AUTO_INCREMENT,
  nome          VARCHAR(45) NOT NULL,
  especialidade VARCHAR(45) NOT NULL,
  crm           VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE localConsulta (
  idLocalConsulta INT PRIMARY KEY AUTO_INCREMENT,
  sala            VARCHAR(45) NOT NULL,
  apelido         VARCHAR(45) NOT NULL,
  andar           VARCHAR(45) NOT NULL
);

-- Tabela associativa N:M (Paciente x Medico) com atributos próprios.
CREATE TABLE consulta (
  idConsulta      INT AUTO_INCREMENT,
  fkPaciente      INT,
  fkMedico        INT,
  fkLocalConsulta INT,
  dataHora        DATETIME,
  preco           DECIMAL(10,2),
  CONSTRAINT fkComposta PRIMARY KEY (idConsulta, fkPaciente, fkMedico),
  CONSTRAINT fk_consulta_paciente FOREIGN KEY (fkPaciente)
    REFERENCES paciente (idPaciente),
  CONSTRAINT fk_consulta_medico FOREIGN KEY (fkMedico)
    REFERENCES medico (idMedico),
  CONSTRAINT fk_consulta_local FOREIGN KEY (fkLocalConsulta)
    REFERENCES localConsulta (idLocalConsulta)
);


-- =====================================================================
-- 2. INSERTS
-- (Lucas Ferreira não tem consultas, o Dr. Tiago não atendeu ninguém e a
--  Sala 301 nunca foi usada: perfeito para testar LEFT/RIGHT JOIN.)
-- =====================================================================
INSERT INTO paciente (nome, genero, dataNascimento) VALUES
('Mariana Alves',          'F', '1988-03-12'),
('Carlos Eduardo Pinto',   'M', '1975-11-30'),
('Juliana Costa',          'F', '2001-07-08'),
('Roberto Santos',         'M', '1962-01-25'),
('Fernanda Lima',          'F', '1995-09-17'),
('Paulo Henrique Rocha',   'M', '2010-05-03'),
('Beatriz Moura',          'F', '1983-12-21'),
('Lucas Ferreira',         'M', '1999-04-14');

SELECT * FROM paciente;

INSERT INTO medico (nome, especialidade, crm) VALUES
('Dr. André Barros',      'Cardiologia',   'CRM/SP 123456'),
('Dra. Helena Duarte',    'Dermatologia',  'CRM/SP 234567'),
('Dr. Ricardo Menezes',   'Ortopedia',     'CRM/SP 345678'),
('Dra. Patrícia Gomes',   'Pediatria',     'CRM/SP 456789'),
('Dr. Tiago Nogueira',    'Cardiologia',   'CRM/RJ 567890');

INSERT INTO localConsulta (sala, apelido, andar) VALUES
('Sala 101', 'Consultório Azul',  '1º andar'),
('Sala 102', 'Consultório Verde', '1º andar'),
('Sala 201', 'Consultório Sol',   '2º andar'),
('Sala 301', 'Consultório Lua',   '3º andar');

INSERT INTO consulta (fkPaciente, fkMedico, fkLocalConsulta, dataHora, preco) VALUES
(1000, 1, 1, '2025-03-03 09:00:00', 350.00),
(1000, 2, 2, '2025-03-10 10:30:00', 280.00),
(1001, 1, 1, '2025-03-03 10:00:00', 350.00),
(1001, 3, 3, '2025-03-12 14:00:00', 400.00),
(1002, 2, 2, '2025-03-10 11:30:00', 280.00),
(1002, 2, 2, '2025-04-14 15:00:00', 250.00),
(1003, 1, 1, '2025-03-17 08:30:00', 350.00),
(1003, 1, 1, '2025-04-21 08:30:00', 320.00),
(1003, 3, 3, '2025-04-22 16:00:00', 400.00),
(1004, 2, 2, '2025-04-14 16:00:00', 280.00),
(1004, 4, 2, '2025-05-05 09:15:00', 220.00),
(1005, 4, 2, '2025-05-05 10:00:00', 220.00),
(1005, 4, 2, '2025-06-09 10:00:00', 190.00),
(1006, 3, 3, '2025-05-12 13:30:00', 420.00),
(1006, 1, 1, '2025-06-02 09:45:00', 360.50),
(1001, 1, 1, '2025-06-16 10:15:00', 355.75),
(1000, 1, 1, '2025-06-23 09:00:00', 350.00),
(1004, 2, 2, '2025-07-07 14:20:00', 275.90);


-- =====================================================================
-- 3. JOINs
-- =====================================================================

-- 3.1 INNER JOIN: agenda completa com nome de paciente, médico e local
SELECT c.idConsulta,
       DATE_FORMAT(c.dataHora, '%d/%m/%Y %H:%i') AS data_consulta,
       p.nome          AS paciente,
       m.nome          AS medico,
       m.especialidade,
       l.apelido       AS local_consulta,
       c.preco
FROM consulta c
INNER JOIN paciente       p ON p.idPaciente      = c.fkPaciente
INNER JOIN medico         m ON m.idMedico        = c.fkMedico
INNER JOIN localConsulta  l ON l.idLocalConsulta = c.fkLocalConsulta
ORDER BY c.dataHora;

-- 3.2 LEFT JOIN: pacientes que nunca fizeram consulta
SELECT p.idPaciente, p.nome
FROM paciente p
LEFT JOIN consulta c ON c.fkPaciente = p.idPaciente
WHERE c.idConsulta IS NULL;

-- 3.3 RIGHT JOIN: médicos que nunca atenderam (tabela da direita preservada)
SELECT m.idMedico, m.nome, m.especialidade
FROM consulta c
RIGHT JOIN Medico m ON m.idMedico = c.fkMedico
WHERE c.idConsulta IS NULL;

-- 3.4 LEFT JOIN: locais de consulta nunca utilizados
SELECT l.sala, l.apelido, l.andar
FROM localConsulta l
LEFT JOIN consulta c ON c.fkLocalConsulta = l.idLocalConsulta
WHERE c.idConsulta IS NULL;

-- =====================================================================
-- 4. AGREGAÇÃO E FUNÇÕES MTMs: COUNT, SUM, AVG, MAX, MIN, GROUP BY, HAVING
-- =====================================================================

-- 4.1 Visão geral da clínica
SELECT COUNT(*)                AS total_consultas,
       SUM(preco)              AS faturamento_total,
       ROUND(AVG(preco), 2)    AS ticket_medio,
       MAX(preco)              AS consulta_mais_cara,
       MIN(preco)              AS consulta_mais_barata
FROM consulta;

-- 4.2 Faturamento por especialidade
SELECT m.especialidade,
       COUNT(*)             AS qtd_consultas,
       SUM(c.preco)         AS faturamento,
       ROUND(AVG(c.preco), 2) AS ticket_medio
FROM consulta c
INNER JOIN medico m ON m.idMedico = c.fkMedico
GROUP BY m.especialidade
ORDER BY faturamento DESC;

-- 4.3 HAVING: pacientes com 2 ou mais consultas E gasto total acima de R$ 600
SELECT p.nome,
       COUNT(*)     AS qtd_consultas,
       SUM(c.preco) AS total_gasto
FROM paciente p
INNER JOIN consulta c ON c.fkPaciente = p.idPaciente
GROUP BY p.idPaciente, p.nome
HAVING COUNT(*) >= 2 AND SUM(c.preco) > 600
ORDER BY total_gasto DESC;

-- 4.4 Consultas e faturamento por mês
SELECT DATE_FORMAT(dataHora, '%Y-%m') AS mes,
       COUNT(*)   AS qtd_consultas,
       SUM(preco) AS faturamento
FROM consulta
GROUP BY DATE_FORMAT(dataHora, '%Y-%m')
ORDER BY mes;

-- 4.5 Ocupação por local (somente locais com mais de 3 consultas)
SELECT l.sala, l.apelido, COUNT(*) AS qtd_consultas
FROM LocalConsulta l
INNER JOIN consulta c ON c.fkLocalConsulta = l.idLocalConsulta
GROUP BY l.idLocalConsulta, l.sala, l.apelido
HAVING COUNT(*) > 3
ORDER BY qtd_consultas DESC;

-- =====================================================================
-- 5. FUNÇÕES MATEMÁTICAS, TEXTO E DATA
-- =====================================================================

-- 5.1 ROUND x TRUNCATE x CEIL x FLOOR sobre o ticket médio de cada médico
SELECT m.nome,
       AVG(c.preco)              AS media_bruta,
       ROUND(AVG(c.preco), 2)    AS media_round,
       TRUNCATE(AVG(c.preco), 2) AS media_truncate,
       CEIL(AVG(c.preco))        AS media_ceil,
       FLOOR(AVG(c.preco))       AS media_floor
FROM consulta c
INNER JOIN medico m ON m.idMedico = c.fkMedico
GROUP BY m.idMedico, m.nome;

-- 5.2 Desconto de 10% (convênio) e diferença para a média geral (ABS)
SELECT c.idConsulta,
       c.preco,
       ROUND(c.preco * 0.90, 2) AS preco_com_desconto,
       ROUND(ABS(c.preco - (SELECT AVG(preco) FROM Paciente_has_Medico)), 2) AS dist_da_media
FROM consulta c
ORDER BY dist_da_media DESC;

-- 5.3 SUBSTRING no CRM: separa a UF e o número (posição inicial = 1 no MySQL)
SELECT nome,
       crm,
       SUBSTRING(crm, 5, 2) AS uf,
       SUBSTRING(crm, 8)    AS numero_crm
FROM medico;

-- 5.4 Idade do paciente (função de data) e faixa etária com CASE
SELECT nome,
       dataNascimento,
       TIMESTAMPDIFF(YEAR, dataNascimento, CURDATE()) AS idade,
       CASE
         WHEN TIMESTAMPDIFF(YEAR, dataNascimento, CURDATE()) < 18 THEN 'Criança/Adolescente'
         WHEN TIMESTAMPDIFF(YEAR, dataNascimento, CURDATE()) < 60 THEN 'Adulto'
         ELSE 'Idoso'
       END AS faixa_etaria
FROM paciente
ORDER BY idade DESC;

-- 5.5 Consultas em horário de manhã ou tarde (HOUR) e dia da semana (DAYNAME)
SELECT idConsulta,
       dataHora,
       DAYNAME(dataHora) AS dia_semana,
       IF(HOUR(dataHora) < 12, 'Manhã', 'Tarde') AS periodo
FROM consulta
ORDER BY dataHora;


-- =====================================================================
-- 6. SUBQUERIES
-- =====================================================================

-- 6.1 Escalar: consultas com preço acima da média geral
SELECT idConsulta, fkPaciente, fkMedico, preco
FROM consulta
WHERE preco > (SELECT AVG(preco) FROM consulta)
ORDER BY preco DESC;

-- 6.2 IN: pacientes que já consultaram com algum cardiologista
SELECT nome
FROM paciente
WHERE idPaciente IN (
  SELECT c.fkPaciente
  FROM consulta c
  INNER JOIN medico m ON m.idMedico = c.fkMedico
  WHERE m.especialidade = 'Cardiologia'
);

-- 6.3 NOT EXISTS: médicos que nunca atenderam ninguém
SELECT m.nome, m.especialidade
FROM medico m
WHERE NOT EXISTS (
  SELECT 1 FROM consulta c WHERE c.fkMedico = m.idMedico
);

-- 6.4 Correlacionada: a consulta mais cara de cada médico
SELECT c.fkMedico, c.idConsulta, c.preco
FROM consulta c
WHERE c.preco = (
  SELECT MAX(c2.preco)
  FROM consulta c2
  WHERE c2.fkMedico = c.fkMedico
)
ORDER BY c.fkMedico;

-- 6.5 Subquery no FROM (tabela derivada) + subquery no WHERE:
--     pacientes cujo gasto total supera a média de gasto por paciente
SELECT t.nome, t.total_gasto
FROM (
  SELECT p.nome, SUM(c.preco) AS total_gasto
  FROM paciente p
  INNER JOIN consulta c ON c.fkPaciente = p.idPaciente
  GROUP BY p.idPaciente, p.nome
) AS t
WHERE t.total_gasto > (
  SELECT AVG(x.total)
  FROM (
    SELECT SUM(preco) AS total
    FROM consulta
    GROUP BY fkPaciente
  ) AS x
)
ORDER BY t.total_gasto DESC;

-- 6.6 Subquery no SELECT: quantas consultas cada médico fez (inclusive zero)
SELECT m.nome,
       (SELECT COUNT(*) FROM consulta c WHERE c.fkMedico = m.idMedico) AS qtd_consultas
FROM medico m
ORDER BY qtd_consultas DESC;


-- =====================================================================
-- 7. VIEWS
-- =====================================================================

-- 7.1 Agenda detalhada (esconde os 3 JOINs de quem for consultar)
CREATE VIEW vw_consultas_detalhadas AS
SELECT c.idConsulta,
       c.dataHora,
       p.nome          AS paciente,
       m.nome          AS medico,
       m.especialidade,
       l.sala,
       l.apelido       AS local_consulta,
       c.preco
FROM consulta c
INNER JOIN paciente      p ON p.idPaciente      = c.fkPaciente
INNER JOIN medico        m ON m.idMedico        = c.fkMedico
INNER JOIN localConsulta l ON l.idLocalConsulta = c.fkLocalConsulta;

SELECT * FROM vw_consultas_detalhadas;

SELECT medico, especialidade FROM vw_consultas_detalhadas;

-- 7.2 Desempenho por médico (LEFT JOIN: médicos sem consulta aparecem com zero)
CREATE OR REPLACE VIEW vw_faturamento_medico AS
SELECT m.idMedico,
       m.nome AS medico,
       m.especialidade,
       COUNT(c.idConsulta)                  AS qtd_consultas,
       IFNULL(SUM(c.preco), 0)              AS faturamento,
       IFNULL(ROUND(AVG(c.preco), 2), 0)    AS ticket_medio
FROM medico m
LEFT JOIN consulta c ON c.fkMedico = m.idMedico
GROUP BY m.idMedico, m.nome, m.especialidade;

-- 7.3 Resumo por paciente (idade, total de consultas, gasto e última consulta)
CREATE OR REPLACE VIEW vw_resumo_paciente AS
SELECT p.idPaciente,
       p.nome,
       TIMESTAMPDIFF(YEAR, p.dataNascimento, CURDATE()) AS idade,
       COUNT(c.idConsulta)                              AS qtd_consultas,
       IFNULL(SUM(c.preco), 0)                          AS total_gasto,
       MAX(c.dataHora)                                  AS ultima_consulta
FROM paciente p
LEFT JOIN consulta c ON c.fkPaciente = p.idPaciente
GROUP BY p.idPaciente, p.nome, p.dataNascimento;

-- Usando as views como se fossem tabelas
SELECT * FROM vw_consultas_detalhadas
WHERE especialidade = 'Cardiologia'
ORDER BY dataHora;

SELECT * FROM vw_faturamento_medico
ORDER BY faturamento DESC;

SELECT nome, idade, qtd_consultas, total_gasto
FROM vw_resumo_paciente
WHERE qtd_consultas = 0 OR total_gasto > 800;

-- View + subquery: médicos acima do faturamento médio entre todos os médicos
SELECT medico, faturamento
FROM vw_faturamento_medico
WHERE faturamento > (SELECT AVG(faturamento) FROM vw_faturamento_medico);

-- Para consultar as views existentes:  SHOW FULL TABLES WHERE Table_type = 'VIEW';
-- Para apagar uma view:                DROP VIEW IF EXISTS vw_resumo_paciente;