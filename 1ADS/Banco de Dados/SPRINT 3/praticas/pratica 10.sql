create database pratica_10;
USE pratica_10;

CREATE TABLE genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(45)
);

CREATE TABLE livro (
    id_livro       INT AUTO_INCREMENT PRIMARY KEY,
    titulo         VARCHAR(45),
    ano_publicacao INT,
    num_paginas    INT,
    id_genero      INT,
    CONSTRAINT fk_livro_genero FOREIGN KEY (id_genero)
        REFERENCES genero (id_genero)
);

CREATE TABLE leitor (
    id_leitor INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(45),
    email     VARCHAR(45),
    cidade    VARCHAR(45)
);

CREATE TABLE clube (
    id_clube     INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(45),
    data_criacao DATE
);

CREATE TABLE participacao (
    id_leitor     INT,
    id_clube      INT,
    data_ingresso DATE,
    num_encontros INT DEFAULT 0,
    PRIMARY KEY (id_leitor, id_clube),
    CONSTRAINT fk_part_leitor FOREIGN KEY (id_leitor)
        REFERENCES leitor (id_leitor),
    CONSTRAINT fk_part_clube FOREIGN KEY (id_clube)
        REFERENCES clube (id_clube)
);

INSERT INTO genero (nome) VALUES
('Romance'),
('Ficção Científica'),
('Fantasia');

INSERT INTO livro (titulo, ano_publicacao, num_paginas, id_genero) VALUES
('Torto Arado',        2019, 264, 1),
('Dom Casmurro',       1899, 208, 1),
('Duna',               1965, 688, 2),
('A Máquina do Tempo', 1895, 144, 2),
('Planeta dos Sonhos', 2015, 310, 2),
('O Fim do Mundo',     2016, 190, 2),
('Circe',              2018, 400, 3),
('Chamas da Noite',    2021, 352, 3);

INSERT INTO leitor (nome, email, cidade) VALUES
('Ana Souza',      'ana.souza@email.com',      'São Paulo'),
('Bruno Lima',     'bruno.lima@email.com',     'Campinas'),
('Carla Mendes',   'carla.mendes@email.com',   'Santos'),
('Diego Alves',    'diego.alves@email.com',    'São Paulo'),
('Eduardo Rocha',  'eduardo.rocha@email.com',  'Sorocaba'),
('Fernanda Costa', 'fernanda.costa@email.com', 'Campinas');

INSERT INTO clube (nome, data_criacao) VALUES
('Clube dos Clássicos',        '2020-03-10'),
('Clube de Ficção Científica', '2021-06-15'),
('Clube Fantasia & Café',      '2022-09-01');

INSERT INTO participacao (id_leitor, id_clube, data_ingresso, num_encontros) VALUES
(1, 1, '2020-04-01', 10),
(2, 1, '2020-05-12', 7),
(3, 1, '2021-01-20', 8),
(1, 2, '2021-07-01', 12),
(3, 2, '2021-08-15', 5),
(4, 2, '2021-09-10', 9),
(5, 2, '2022-02-05', 4),
(2, 3, '2022-10-01', 6),
(4, 3, '2022-11-11', 3);

-- B
SELECT l.nome AS leitor,
       c.nome AS clube,
       p.data_ingresso
FROM leitor l
INNER JOIN participacao p ON p.id_leitor = l.id_leitor
INNER JOIN clube c        ON c.id_clube  = p.id_clube
ORDER BY l.nome, p.data_ingresso;

-- C 
SELECT li.titulo,
       li.ano_publicacao,
       li.num_paginas,
       g.nome AS genero
FROM livro li
INNER JOIN genero g ON g.id_genero = li.id_genero
WHERE li.ano_publicacao >= 2015
  AND li.titulo LIKE '%a%'
ORDER BY li.num_paginas;

-- D
SELECT COUNT(*)                  AS qtd_livros,
       MIN(num_paginas)          AS menor_num_paginas,
       MAX(num_paginas)          AS maior_num_paginas,
       ROUND(AVG(num_paginas),1) AS media_paginas
FROM livro;

-- E
SELECT c.nome AS clube,
       COUNT(p.id_leitor) AS qtd_leitores
FROM clube c
LEFT JOIN participacao p ON p.id_clube = c.id_clube
GROUP BY c.id_clube, c.nome;

-- F
SELECT l.nome AS leitor,
       COUNT(p.id_clube) AS qtd_clubes
FROM leitor l
LEFT JOIN participacao p ON p.id_leitor = l.id_leitor
GROUP BY l.id_leitor, l.nome
ORDER BY l.nome;

-- G
SELECT t.clube,
       t.qtd_leitores,
       t.media_encontros
FROM (
    SELECT c.nome AS clube,
           COUNT(p.id_leitor)                AS qtd_leitores,
           TRUNCATE(AVG(p.num_encontros), 1) AS media_encontros
    FROM clube c
    INNER JOIN participacao p ON p.id_clube = c.id_clube
    GROUP BY c.id_clube, c.nome
) AS t
WHERE t.qtd_leitores >= 3;

-- ################
-- ################ EXERCICIO 2
-- A
CREATE TABLE nivel_intensidade (
    id_nivel  INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45)
);

CREATE TABLE modalidade (
    id_modalidade INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(45),
    id_nivel      INT,
    CONSTRAINT fk_modalidade_nivel FOREIGN KEY (id_nivel)
        REFERENCES nivel_intensidade (id_nivel)
);

CREATE TABLE aluno (
    id_aluno        INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45),
    data_nascimento DATE,
    email           VARCHAR(45)
);

CREATE TABLE instrutor (
    id_instrutor INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(45),
    valor_aula   DECIMAL(8,2)
);

CREATE TABLE aula (
    id_aula         INT AUTO_INCREMENT PRIMARY KEY,
    id_instrutor    INT,
    id_modalidade   INT,
    dia_semana      VARCHAR(45),
    duracao_minutos INT,
    CONSTRAINT fk_aula_instrutor FOREIGN KEY (id_instrutor)
        REFERENCES instrutor (id_instrutor),
    CONSTRAINT fk_aula_modalidade FOREIGN KEY (id_modalidade)
        REFERENCES modalidade (id_modalidade)
);

-- Tabela (N:N)
CREATE TABLE matricula (
    id_aluno       INT,
    id_modalidade  INT,
    data_matricula DATE,
    PRIMARY KEY (id_aluno, id_modalidade),
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (id_aluno)
        REFERENCES aluno (id_aluno),
    CONSTRAINT fk_matricula_modalidade FOREIGN KEY (id_modalidade)
        REFERENCES modalidade (id_modalidade)
);

INSERT INTO nivel_intensidade (descricao) VALUES
('Baixa'),
('Moderada'),
('Alta');

INSERT INTO modalidade (nome, id_nivel) VALUES
('Yoga',     1),
('Pilates',  1),
('Zumba',    2),
('Spinning', 3),
('CrossFit', 3);

INSERT INTO aluno (nome, data_nascimento, email) VALUES
('Mateo Rodríguez',   '1998-03-14', 'mateo.rodriguez@email.com'),
('Valentina Gómez',   '2001-07-22', 'valentina.gomez@email.com'),
('Santiago Ferrari',  '1995-11-05', 'santiago.ferrari@email.com'),
('Isabella Romano',   '2000-01-30', 'isabella.romano@email.com'),
('Diego Hernández',   '1993-09-18', 'diego.hernandez@email.com'),
('Camila Esposito',   '1999-05-09', 'camila.esposito@email.com'),
('Lucas Moreno',      '2002-12-02', 'lucas.moreno@email.com'),
('Sofía Marino',      '1997-04-27', 'sofia.marino@email.com');

INSERT INTO instrutor (nome, valor_aula) VALUES
('Marco Bianchi',    45.00),
('Lucía Fernández',  50.00),
('Rafael Moretti',   60.00),
('Camila Ortega',    55.00);

INSERT INTO aula (id_instrutor, id_modalidade, dia_semana, duracao_minutos) VALUES
(1, 1, 'Segunda', 60),
(1, 1, 'Quarta',  60),
(1, 2, 'Terça',   50),
(2, 1, 'Sexta',   60),
(2, 3, 'Segunda', 45),
(3, 4, 'Terça',   45),
(3, 5, 'Quinta',  60),
(4, 3, 'Quarta',  50),
(4, 4, 'Sexta',   45),
(4, 5, 'Sábado',  60);

INSERT INTO matricula (id_aluno, id_modalidade, data_matricula) VALUES
(1, 1, '2026-01-10'),
(1, 2, '2026-01-12'),
(1, 3, '2026-02-01'),
(2, 1, '2026-01-15'),
(2, 3, '2026-02-05'),
(2, 4, '2026-03-01'),
(3, 1, '2026-01-20'),
(3, 3, '2026-02-10'),
(3, 5, '2026-03-15'),
(4, 1, '2026-02-12'),
(4, 2, '2026-02-20'),
(5, 1, '2026-03-02'),
(5, 4, '2026-03-10'),
(6, 3, '2026-04-01');

-- B 
ALTER TABLE modalidade
    ADD COLUMN qtd_max_alunos INT DEFAULT 20,
    ADD CONSTRAINT chk_qtd_max_alunos CHECK (qtd_max_alunos > 0);

UPDATE modalidade SET qtd_max_alunos = 15 WHERE id_modalidade = 1; 
UPDATE modalidade SET qtd_max_alunos = 30 WHERE id_modalidade = 3; 
UPDATE modalidade SET qtd_max_alunos = 10 WHERE id_modalidade = 5;

-- C 
SELECT m.nome AS modalidade,
       i.nome AS instrutor,
       a.dia_semana,
       a.duracao_minutos
	FROM aula a
	INNER JOIN modalidade m ON m.id_modalidade = a.id_modalidade
	INNER JOIN instrutor i  ON i.id_instrutor  = a.id_instrutor
		ORDER BY m.nome, a.dia_semana;
 -- D
 SELECT al.nome AS aluno,
       COUNT(ma.id_modalidade) AS qtd_modalidades
	FROM aluno al
	LEFT JOIN matricula ma ON ma.id_aluno = al.id_aluno
		GROUP BY al.id_aluno, al.nome
		ORDER BY al.nome;

-- E
SELECT i.nome AS instrutor,
       COUNT(DISTINCT a.id_modalidade)  AS qtd_modalidades,
       ROUND(AVG(a.duracao_minutos), 1) AS duracao_media
	FROM instrutor i
	LEFT JOIN aula a ON a.id_instrutor = i.id_instrutor
		GROUP BY i.id_instrutor, i.nome;
        
-- F
SELECT t.modalidade,
       t.qtd_alunos,
       t.qtd_instrutores
FROM (
    SELECT m.nome AS modalidade,
           COUNT(DISTINCT ma.id_aluno)    AS qtd_alunos,
           COUNT(DISTINCT a.id_instrutor) AS qtd_instrutores
		FROM modalidade m
		INNER JOIN matricula ma ON ma.id_modalidade = m.id_modalidade
		LEFT JOIN aula a        ON a.id_modalidade  = m.id_modalidade
			GROUP BY m.id_modalidade, m.nome
) AS t
WHERE t.qtd_alunos > 3;

-- G
SELECT i.nome AS instrutor,
       COUNT(a.id_aula)  AS qtd_aulas_semanais,
       IFNULL(SUM(i.valor_aula), 0) AS valor_total_semanal
FROM instrutor i
LEFT JOIN aula a ON a.id_instrutor = i.id_instrutor
GROUP BY i.id_instrutor, i.nome;

-- ##################### EXERCICIO 3
-- A
CREATE TABLE artista (
    id_artista    INT AUTO_INCREMENT PRIMARY KEY,
    nome_artistico VARCHAR(45),
    pais_origem   VARCHAR(45),
    ano_estreia   INT
);

CREATE TABLE palco (
    id_palco   INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(45),
    capacidade INT
);

-- Cada apresentação ocorre em um único palco (1:N)
CREATE TABLE apresentacao (
    id_apresentacao   INT AUTO_INCREMENT PRIMARY KEY,
    data_apresentacao DATE,
    horario_inicio    TIME,
    duracao_minutos   INT,
    id_palco          INT,
    CONSTRAINT fk_apresentacao_palco FOREIGN KEY (id_palco)
        REFERENCES palco (id_palco)
);

-- Tabela associativa artista x apresentação (N:N), com o cachê
CREATE TABLE participacao1 (
    id_apresentacao INT,
    id_artista      INT,
    valor_cache     DECIMAL(10,2),
    PRIMARY KEY (id_apresentacao, id_artista),
    CONSTRAINT fk_part_apresentacao FOREIGN KEY (id_apresentacao)
        REFERENCES apresentacao (id_apresentacao),
    CONSTRAINT fk_part_artista FOREIGN KEY (id_artista)
        REFERENCES artista (id_artista)
);

INSERT INTO artista (nome_artistico, pais_origem, ano_estreia) VALUES
('Luna Vega',    'Espanha',   2012),
('Marco Rossi',  'Itália',    2018),
('Banda Aurora', 'Brasil',    2015),
('DJ Kaleo',     'EUA',       2021),
('Sol Caribe',   'Colômbia',  2019),
('Trio Nova',    'Argentina', 2022),
('Elis Moura',   'Brasil',    2010),
('Os Tigres',    'México',    2005);

-- O palco 4 não terá apresentações
INSERT INTO palco (nome, capacidade) VALUES
('Palco Principal', 5000),
('Palco Sol',       2500),
('Palco Lua',       1200),
('Palco Jardim',     800);

INSERT INTO apresentacao (data_apresentacao, horario_inicio, duracao_minutos, id_palco) VALUES
('2026-12-04', '18:00:00',  60, 1),
('2026-12-04', '20:00:00',  90, 1),
('2026-12-05', '17:00:00',  45, 1),
('2026-12-05', '19:00:00',  75, 1),
('2026-12-06', '21:00:00', 120, 1),
('2026-12-04', '19:00:00',  60, 2),
('2026-12-04', '21:30:00',  90, 2),
('2026-12-05', '18:00:00',  60, 2),
('2026-12-05', '20:30:00',  80, 2),
('2026-12-06', '19:00:00',  70, 2),
('2026-12-05', '16:00:00',  50, 3),
('2026-12-06', '18:30:00',  60, 3);

INSERT INTO participacao1 (id_apresentacao, id_artista, valor_cache) VALUES
(1,  1, 2500.00),
(1,  2, 1800.00),
(2,  3, 3000.00),
(2,  4, 2200.00),
(2,  5, 1500.00),
(3,  7, 1200.00),
(4,  1, 2800.00),
(4,  8, 1000.00),
(5,  3, 3500.00),
(5,  2, 2000.00),
(5,  6, 1600.00),
(5,  7, 1400.00),
(6,  5, 1700.00),
(6,  6, 1500.00),
(7,  8,  900.00),
(7,  4, 2600.00),
(7,  7, 1500.00),
(8,  2, 2100.00),
(9,  1, 3200.00),
(9,  3, 2800.00),
(10, 5, 1900.00),
(10, 8, 1100.00),
(10, 6, 1300.00),
(11, 7, 1300.00),
(11, 2, 1900.00),
(12, 4, 2300.00);


-- #############
-- ############# EXERCICIO 4

-- A
CREATE TABLE area_especializacao (
    id_area   INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45)
);

CREATE TABLE titulacao (
    id_titulacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao    VARCHAR(45)
);

CREATE TABLE situacao (
    id_situacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao   VARCHAR(45)
);

CREATE TABLE pesquisador (
    id_pesquisador INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(45),
    id_area        INT,
    id_titulacao   INT,
    CONSTRAINT fk_pesquisador_area FOREIGN KEY (id_area)
        REFERENCES area_especializacao (id_area),
    CONSTRAINT fk_pesquisador_titulacao FOREIGN KEY (id_titulacao)
        REFERENCES titulacao (id_titulacao)
);

CREATE TABLE projeto (
    id_projeto         INT AUTO_INCREMENT PRIMARY KEY,
    titulo             VARCHAR(45),
    orcamento_previsto DECIMAL(12,2),
    data_inicio        DATE,
    id_situacao        INT,
    CONSTRAINT fk_projeto_situacao FOREIGN KEY (id_situacao)
        REFERENCES situacao (id_situacao)
);

-- Tabela associativa pesquisador x projeto (N:N)
CREATE TABLE participacao2 (
    id_projeto       INT,
    id_pesquisador   INT,
    horas_dedicadas  INT,
    valor_hora       DECIMAL(8,2),
    PRIMARY KEY (id_projeto, id_pesquisador),
    CONSTRAINT fk_part_projeto FOREIGN KEY (id_projeto)
        REFERENCES projeto (id_projeto),
    CONSTRAINT fk_part_pesquisador FOREIGN KEY (id_pesquisador)
        REFERENCES pesquisador (id_pesquisador)
);

INSERT INTO area_especializacao (descricao) VALUES
('Biologia'),
('Computação'),
('Química');

INSERT INTO titulacao (descricao) VALUES
('Mestre'),
('Doutor'),
('Pós-doutor');

INSERT INTO situacao (descricao) VALUES
('Planejado'),
('Em andamento'),
('Concluído');


INSERT INTO pesquisador (nome, id_area, id_titulacao) VALUES
('Helena Prado',      1, 2),
('Rafael Duarte',     2, 1),
('Juliana Reis',      3, 2),
('Carlos Menezes',    2, 3),
('Patrícia Lopes',    1, 1),
('Anderson Silva',    3, 3),
('Beatriz Nogueira',  2, 2),
('Tiago Farias',      1, 2);


INSERT INTO projeto (titulo, orcamento_previsto, data_inicio, id_situacao) VALUES
('Genoma de Plantas Nativas',          120000.00, '2025-03-01', 2),
('IA para Diagnóstico por Imagem',     200000.00, '2025-06-15', 2),
('Materiais Biodegradáveis',            80000.00, '2024-01-10', 3),
('Monitoramento Ambiental com Sensores', 50000.00, '2026-02-01', 2),
('Catalisadores Verdes',               150000.00, '2027-01-15', 1),
('Bioinformática de Microbiomas',       60000.00, '2023-05-20', 3);

INSERT INTO participacao2 (id_projeto, id_pesquisador, horas_dedicadas, valor_hora) VALUES
(1, 1, 400,  80.00),
(1, 5, 300,  60.00),
(1, 3, 200,  90.00),
(2, 2, 800, 100.00),
(2, 4, 600, 120.00),
(2, 1, 150,  80.00),
(3, 3, 500,  90.00),
(3, 6, 400, 110.00),
(4, 2, 300, 100.00),
(4, 6, 250, 110.00),
(6, 5, 350,  60.00),
(6, 1, 200,  80.00),
(6, 4, 100, 120.00);

-- B

ALTER TABLE projeto
    ADD COLUMN orcamento_maximo DECIMAL(12,2),
    ADD CONSTRAINT chk_orcamento_maximo CHECK (orcamento_maximo >= 0),
    ADD CONSTRAINT chk_orcamento_previsto CHECK (orcamento_previsto >= 0);

UPDATE projeto SET orcamento_maximo = 130000.00 WHERE id_projeto = 1;
UPDATE projeto SET orcamento_maximo = 220000.00 WHERE id_projeto = 2;
UPDATE projeto SET orcamento_maximo = 90000.00  WHERE id_projeto = 3;
UPDATE projeto SET orcamento_maximo = 60000.00  WHERE id_projeto = 4;
UPDATE projeto SET orcamento_maximo = 160000.00 WHERE id_projeto = 5;
UPDATE projeto SET orcamento_maximo = 70000.00  WHERE id_projeto = 6;


-- C

SELECT pr.titulo                               AS projeto,
       pe.nome                                 AS pesquisador,
       ar.descricao                            AS area,
       pa.horas_dedicadas,
       pa.horas_dedicadas * pa.valor_hora      AS custo_individual
	FROM participacao2 AS pa
	INNER JOIN projeto pr             ON pr.id_projeto = pa.id_projeto
	INNER JOIN situacao s             ON s.id_situacao = pr.id_situacao
	INNER JOIN pesquisador pe         ON pe.id_pesquisador = pa.id_pesquisador
	INNER JOIN area_especializacao ar ON ar.id_area        = pe.id_area
		WHERE s.descricao = 'Em andamento'
		ORDER BY pr.titulo, pe.nome;
        
-- D
SELECT pr.titulo AS projeto,
       COUNT(pa.id_pesquisador)                              AS qtd_pesquisadores,
       IFNULL(SUM(pa.horas_dedicadas), 0)                    AS total_horas,
       IFNULL(SUM(pa.horas_dedicadas * pa.valor_hora), 0)    AS custo_total
FROM projeto pr
LEFT JOIN participacao2 pa ON pa.id_projeto = pr.id_projeto
GROUP BY pr.id_projeto, pr.titulo;


-- E
SELECT ar.descricao AS area,
       COUNT(DISTINCT pe.id_pesquisador)  AS qtd_pesquisadores,
       COUNT(DISTINCT pa.id_projeto)      AS qtd_projetos,
       ROUND(AVG(pa.horas_dedicadas), 2)  AS media_horas_participacao
	FROM area_especializacao ar
	LEFT JOIN pesquisador pe   ON pe.id_area        = ar.id_area
	LEFT JOIN participacao2 pa  ON pa.id_pesquisador = pe.id_pesquisador
		GROUP BY ar.id_area, ar.descricao;

-- F
SELECT t.titulo,
       t.orcamento_previsto,
       t.custo_total,
       ROUND(t.custo_total / t.orcamento_previsto * 100, 2) AS percentual_utilizado
FROM (
    SELECT pr.titulo,
           pr.orcamento_previsto,
           SUM(pa.horas_dedicadas * pa.valor_hora) AS custo_total
		FROM projeto pr
		INNER JOIN participacao2 pa ON pa.id_projeto = pr.id_projeto
			GROUP BY pr.id_projeto, pr.titulo, pr.orcamento_previsto
) AS t
WHERE t.custo_total > t.orcamento_previsto * 0.70;

-- G
SELECT pr.titulo,
       s.descricao AS situacao,
       pr.orcamento_previsto,
       IFNULL(SUM(pa.horas_dedicadas * pa.valor_hora), 0) AS custo_total,
       CASE
           WHEN IFNULL(SUM(pa.horas_dedicadas * pa.valor_hora), 0) = 0
               THEN 'Sem custo'
           WHEN SUM(pa.horas_dedicadas * pa.valor_hora) > pr.orcamento_previsto
               THEN 'Acima do orçamento'
           ELSE 'Dentro do orçamento'
		END AS classificacao
	FROM projeto pr
	INNER JOIN situacao s      ON s.id_situacao = pr.id_situacao
	LEFT JOIN participacao2 pa  ON pa.id_projeto = pr.id_projeto
		GROUP BY pr.id_projeto, pr.titulo, s.descricao, pr.orcamento_previsto;


-- ##############
-- ############## EXERCICIO 5
-- A
CREATE TABLE area_conhecimento (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nome    VARCHAR(45)
);

CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45)
);

CREATE TABLE estudante (
    id_estudante INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(45),
    email        VARCHAR(45),
    cidade       VARCHAR(45)
);


CREATE TABLE curso (
    id_curso      INT AUTO_INCREMENT PRIMARY KEY,
    titulo        VARCHAR(45),
    carga_horaria INT,
    id_area       INT,
    CONSTRAINT fk_curso_area FOREIGN KEY (id_area)
        REFERENCES area_conhecimento (id_area)
);

-- Relacionamento 1:N (uma especialidade reúne vários instrutores)
CREATE TABLE instrutor1 (
    id_instrutor     INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45),
    id_especialidade INT,
    CONSTRAINT fk_instrutor_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id_especialidade)
);

-- Tabela associativa curso x instrutor (N:N), com a remuneração
CREATE TABLE atuacao (
    id_curso           INT,
    id_instrutor       INT,
    valor_remuneracao  DECIMAL(10,2),
    PRIMARY KEY (id_curso, id_instrutor),
    CONSTRAINT fk_atuacao_curso FOREIGN KEY (id_curso)
        REFERENCES curso (id_curso),
    CONSTRAINT fk_atuacao_instrutor FOREIGN KEY (id_instrutor)
        REFERENCES instrutor (id_instrutor)
);

-- Tabela associativa estudante x curso (N:N)
CREATE TABLE inscricao (
    id_estudante          INT,
    id_curso              INT,
    data_inscricao        DATE,
    nota_final            DECIMAL(4,2),
    percentual_frequencia DECIMAL(5,2),
    PRIMARY KEY (id_estudante, id_curso),
    CONSTRAINT fk_inscricao_estudante FOREIGN KEY (id_estudante)
        REFERENCES estudante (id_estudante),
    CONSTRAINT fk_inscricao_curso FOREIGN KEY (id_curso)
        REFERENCES curso (id_curso)
);

INSERT INTO area_conhecimento (nome) VALUES
('Tecnologia'),
('Saúde'),
('Negócios');

INSERT INTO especialidade (nome) VALUES
('Programação'),
('Gestão'),
('Saúde e Bem-estar');

INSERT INTO estudante (nome, email, cidade) VALUES
('Ana Paula Lima',     'ana.lima@email.com',       'São Paulo'),
('Bruno Carvalho',     'bruno.carvalho@email.com', 'Campinas'),
('Camila Ribeiro',     'camila.ribeiro@email.com', 'Santos'),
('Daniel Souza',       'daniel.souza@email.com',   'São Paulo'),
('Elisa Martins',      'elisa.martins@email.com',  'Sorocaba'),
('Felipe Gomes',       'felipe.gomes@email.com',   'Campinas'),
('Gabriela Nunes',     'gabriela.nunes@email.com', 'Santos'),
('Henrique Barros',    'henrique.barros@email.com','São Paulo'),
('Isabela Freitas',    'isabela.freitas@email.com','Osasco'),
('João Pedro Rocha',   'joao.rocha@email.com',     'Campinas');


INSERT INTO curso (titulo, carga_horaria, id_area) VALUES
('Python Básico',        80, 1),
('Banco de Dados',       60, 1),
('Primeiros Socorros',   40, 2),
('Nutrição Esportiva',   50, 2),
('Gestão de Projetos',   70, 3),
('Marketing Digital',    45, 3);


INSERT INTO instrutor1 (nome, id_especialidade) VALUES
('Fernando Alves',  1),
('Mariana Costa',   2),
('Ricardo Pinto',   1),
('Juliana Torres',  3);

INSERT INTO atuacao (id_curso, id_instrutor, valor_remuneracao) VALUES
(1, 1, 1500.00),
(1, 3, 1400.00),
(2, 1, 1200.00),
(3, 2, 1000.00),
(4, 3,  950.00),
(5, 2, 1100.00);


INSERT INTO inscricao (id_estudante, id_curso, data_inscricao, nota_final, percentual_frequencia) VALUES
(1,  1, '2026-02-01', 8.50, 90.00),
(2,  1, '2026-02-03', 6.00, 80.00),
(3,  1, '2026-02-05', 5.00, 85.00),
(4,  1, '2026-02-10', 7.50, 70.00),
(5,  1, '2026-02-12', 9.00, 95.00),
(1,  2, '2026-03-01', 7.00, 80.00),
(6,  2, '2026-03-02', 4.50, 60.00),
(7,  2, '2026-03-05', 6.50, 75.00),
(8,  2, '2026-03-07', 8.00, 92.00),
(2,  3, '2026-03-10', 9.50, 98.00),
(9,  3, '2026-03-12', 5.50, 80.00),
(10, 3, '2026-03-15', NULL, NULL),
(3,  4, '2026-04-01', 6.00, 74.00),
(4,  4, '2026-04-02', 7.00, 88.00);

-- B
SELECT e.nome AS estudante,
       c.titulo AS curso,
       i.nota_final,
       i.percentual_frequencia
FROM inscricao i
INNER JOIN estudante e         ON e.id_estudante = i.id_estudante
INNER JOIN curso c             ON c.id_curso     = i.id_curso
INNER JOIN area_conhecimento a ON a.id_area      = c.id_area
WHERE a.nome = 'Tecnologia'
ORDER BY c.titulo, e.nome;

-- C
SELECT c.titulo AS curso,
       COUNT(i.id_estudante)          AS qtd_inscritos,
       MIN(i.nota_final)              AS menor_nota,
       MAX(i.nota_final)              AS maior_nota,
       TRUNCATE(AVG(i.nota_final), 1) AS media_notas
FROM curso c
LEFT JOIN inscricao i ON i.id_curso = c.id_curso
GROUP BY c.id_curso, c.titulo;

-- D 
SELECT t.titulo,
       t.qtd_estudantes
FROM (
    SELECT c.titulo,
           COUNT(i.id_estudante) AS qtd_estudantes
    FROM curso c
    INNER JOIN inscricao i ON i.id_curso = c.id_curso
    WHERE i.nota_final >= 6
      AND i.percentual_frequencia >= 75
		GROUP BY c.id_curso, c.titulo
) AS t
WHERE t.qtd_estudantes >= 3;

-- E
SELECT t.instrutor,
       t.especialidade,
       t.qtd_cursos,
       t.total_remuneracao
FROM (
    SELECT ins.nome AS instrutor,
           esp.nome AS especialidade,
           COUNT(DISTINCT at.id_curso) AS qtd_cursos,
           SUM(at.valor_remuneracao)   AS total_remuneracao
    FROM instrutor1 ins
    INNER JOIN especialidade esp ON esp.id_especialidade = ins.id_especialidade
    INNER JOIN atuacao at        ON at.id_instrutor      = ins.id_instrutor
		GROUP BY ins.id_instrutor, ins.nome, esp.nome
) 	AS t
	WHERE t.qtd_cursos > 1;
    
-- F
SELECT CASE
           WHEN i.nota_final >= 6 AND i.percentual_frequencia >= 75
               THEN 'Aprovado'
           WHEN i.percentual_frequencia < 75
               THEN 'Reprovado por frequência'
           ELSE 'Reprovado por nota'
       END AS resultado,
       COUNT(*) AS qtd_inscricoes
	FROM inscricao i
	WHERE i.nota_final IS NOT NULL
	AND i.percentual_frequencia IS NOT NULL
		GROUP BY resultado;
        
-- G
SELECT a.nome AS area,
       COUNT(DISTINCT c.id_curso)      AS qtd_cursos,
       COUNT(DISTINCT i.id_estudante)  AS qtd_estudantes,
       ROUND(AVG(i.nota_final), 2)     AS media_notas,
       IFNULL(ROUND(
           SUM(CASE WHEN i.nota_final >= 6 AND i.percentual_frequencia >= 75
                    THEN 1 ELSE 0 END) * 100
           / COUNT(CASE WHEN i.nota_final IS NOT NULL
                         AND i.percentual_frequencia IS NOT NULL
                        THEN 1 END)
       , 2), 0) AS percentual_aprovacao
FROM area_conhecimento a
LEFT JOIN curso c     ON c.id_area  = a.id_area
LEFT JOIN inscricao i ON i.id_curso = c.id_curso
GROUP BY a.id_area, a.nome;

-- ##########################
-- ########################## EXERCICIO 6
-- A
CREATE TABLE especie (
    id_especie INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(45)
);

CREATE TABLE especialidade1 (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45)
);

CREATE TABLE situacao1 (
    id_situacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao   VARCHAR(45)
);

CREATE TABLE tutor (
    id_tutor INT AUTO_INCREMENT PRIMARY KEY,
    nome     VARCHAR(45),
    telefone VARCHAR(45),
    cidade   VARCHAR(45)
);

-- Cada animal pertence a um único tutor e a uma única espécie
CREATE TABLE animal (
    id_animal       INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45),
    peso            DECIMAL(5,2),
    data_nascimento DATE,
    id_tutor        INT,
    id_especie      INT,
    CONSTRAINT fk_animal_tutor FOREIGN KEY (id_tutor)
        REFERENCES tutor (id_tutor),
    CONSTRAINT fk_animal_especie FOREIGN KEY (id_especie)
        REFERENCES especie (id_especie)
);

CREATE TABLE veterinario (
    id_veterinario   INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45),
    id_especialidade INT,
    CONSTRAINT fk_veterinario_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id_especialidade)
);

CREATE TABLE atendimento (
    id_atendimento   INT AUTO_INCREMENT PRIMARY KEY,
    data_atendimento DATE,
    id_situacao      INT,
    id_animal        INT,
    id_veterinario   INT,
    CONSTRAINT fk_atendimento_situacao FOREIGN KEY (id_situacao)
        REFERENCES situacao (id_situacao),
    CONSTRAINT fk_atendimento_animal FOREIGN KEY (id_animal)
        REFERENCES animal (id_animal),
    CONSTRAINT fk_atendimento_veterinario FOREIGN KEY (id_veterinario)
        REFERENCES veterinario (id_veterinario)
);

CREATE TABLE procedimento (
    id_procedimento INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45)
);

-- Tabela associativa atendimento x procedimento (N:N)
CREATE TABLE atendimento_procedimento (
    id_atendimento  INT,
    id_procedimento INT,
    valor_unitario  DECIMAL(10,2),
    quantidade      INT,
    PRIMARY KEY (id_atendimento, id_procedimento),
    CONSTRAINT fk_ap_atendimento FOREIGN KEY (id_atendimento)
        REFERENCES atendimento (id_atendimento),
    CONSTRAINT fk_ap_procedimento FOREIGN KEY (id_procedimento)
        REFERENCES procedimento (id_procedimento)
);

INSERT INTO especie (nome) VALUES
('Cachorro'),
('Gato'),
('Coelho');

INSERT INTO especialidade (nome) VALUES
('Clínica Geral'),
('Dermatologia'),
('Cardiologia');

INSERT INTO situacao1 (descricao) VALUES
('Agendado'),
('Realizado'),
('Cancelado');

INSERT INTO tutor (nome, telefone, cidade) VALUES
('Marcelo Antunes',  '(11) 98888-1111', 'São Paulo'),
('Patrícia Gomes',   '(19) 97777-2222', 'Campinas'),
('Roberto Lima',     '(13) 96666-3333', 'Santos'),
('Sandra Oliveira',  '(11) 95555-4444', 'São Paulo'),
('Thiago Ramos',     '(15) 94444-5555', 'Sorocaba'),
('Vanessa Costa',    '(19) 93333-6666', 'Campinas');


INSERT INTO animal (nome, peso, data_nascimento, id_tutor, id_especie) VALUES
('Rex',      28.50, '2019-04-10', 1, 1),
('Mel',      12.30, '2020-08-22', 1, 1),
('Mimi',      4.20, '2021-01-15', 2, 2),
('Thor',     35.00, '2018-11-03', 3, 1),
('Luna',      3.80, '2022-05-30', 3, 2),
('Bolinha',   2.10, '2023-02-14', 6, 3),
('Nina',     10.70, '2020-09-09', 4, 1),
('Fred',      5.00, '2019-12-01', 4, 2),
('Pipoca',    1.90, '2022-07-18', 5, 3),
('Max',      22.40, '2021-03-25', 5, 1);


INSERT INTO veterinario (nome, id_especialidade) VALUES
('André Pires',      1),
('Beatriz Campos',   2),
('Caio Medeiros',    3),
('Daniela Freitas',  1);

INSERT INTO procedimento (nome) VALUES
('Consulta'),
('Exame de sangue'),
('Vacinação'),
('Exame de imagem'),
('Limpeza dentária'),
('Curativo');

INSERT INTO atendimento (data_atendimento, id_situacao, id_animal, id_veterinario) VALUES
('2026-03-02', 2, 1, 1),
('2026-03-05', 2, 1, 2),
('2026-03-10', 2, 2, 1),
('2026-03-12', 2, 3, 1),
('2026-03-15', 2, 4, 3),
('2026-03-18', 2, 4, 1),
('2026-03-20', 2, 5, 2),
('2026-03-22', 2, 6, 1),
('2026-03-25', 2, 7, 3),
('2026-03-28', 2, 3, 2),
('2026-04-02', 3, 9, 1),
('2026-04-05', 1, 2, 3),
('2026-04-08', 1, 9, 2),
('2026-04-10', 2, 7, 1),
('2026-04-12', 3, 5, 4);


INSERT INTO atendimento_procedimento (id_atendimento, id_procedimento, valor_unitario, quantidade) VALUES
(1,  1, 120.00, 1),
(1,  3,  80.00, 1),
(2,  1, 150.00, 1),
(2,  2,  90.00, 2),
(3,  1, 120.00, 1),
(4,  1, 120.00, 1),
(4,  2,  90.00, 1),
(4,  3,  80.00, 2),
(5,  1, 200.00, 1),
(5,  4, 250.00, 1),
(6,  5, 300.00, 1),
(7,  1, 150.00, 1),
(7,  6,  50.00, 3),
(8,  3,  80.00, 1),
(9,  1, 200.00, 1),
(9,  4, 250.00, 2),
(10, 2,  90.00, 1),
(10, 6,  50.00, 2),
(11, 1, 120.00, 1),
(12, 4, 250.00, 1),
(13, 1, 150.00, 1),
(15, 1, 120.00, 1);

-- B 
SELECT a.nome  AS animal,
       t.nome  AS tutor,
       e.nome  AS especie,
       COUNT(CASE WHEN s.descricao = 'Realizado'
                  THEN atd.id_atendimento END) AS qtd_atendimentos_realizados
FROM animal a
INNER JOIN tutor t    ON t.id_tutor    = a.id_tutor
INNER JOIN especie e  ON e.id_especie  = a.id_especie
LEFT JOIN atendimento atd ON atd.id_animal  = a.id_animal
LEFT JOIN situacao s      ON s.id_situacao  = atd.id_situacao
GROUP BY a.id_animal, a.nome, t.nome, e.nome
ORDER BY a.nome;

-- C
SELECT v.nome  AS veterinario,
       esp.nome AS especialidade,
       COUNT(DISTINCT CASE WHEN s.descricao = 'Realizado'
                           THEN atd.id_animal END) AS qtd_animais_atendidos
FROM veterinario v
INNER JOIN especialidade esp ON esp.id_especialidade = v.id_especialidade
LEFT JOIN atendimento atd    ON atd.id_veterinario   = v.id_veterinario
LEFT JOIN situacao s         ON s.id_situacao        = atd.id_situacao
GROUP BY v.id_veterinario, v.nome, esp.nome;

-- D
SELECT p.nome AS procedimento,
       SUM(ap.quantidade)                      AS qtd_execucoes,
       SUM(ap.valor_unitario * ap.quantidade)  AS valor_total
FROM procedimento p
INNER JOIN atendimento_procedimento ap ON ap.id_procedimento = p.id_procedimento
INNER JOIN atendimento atd             ON atd.id_atendimento = ap.id_atendimento
INNER JOIN situacao1 s                  ON s.id_situacao      = atd.id_situacao
WHERE p.nome LIKE '%exame%'
  AND s.descricao = 'Realizado'
GROUP BY p.id_procedimento, p.nome;

-- E
SELECT atd.id_atendimento,
       atd.data_atendimento,
       COUNT(DISTINCT ap.id_procedimento)                   AS qtd_procedimentos,
       IFNULL(SUM(ap.quantidade), 0)                        AS qtd_execucoes,
       IFNULL(SUM(ap.valor_unitario * ap.quantidade), 0)    AS valor_total
FROM atendimento atd
INNER JOIN situacao1 s ON s.id_situacao = atd.id_situacao
LEFT JOIN atendimento_procedimento ap ON ap.id_atendimento = atd.id_atendimento
WHERE s.descricao = 'Realizado'
GROUP BY atd.id_atendimento, atd.data_atendimento
ORDER BY atd.id_atendimento;

-- F
SELECT x.veterinario,
       x.qtd_atendimentos,
       ROUND(x.media_arrecadacao, 2) AS media_arrecadacao
FROM (
    SELECT v.nome AS veterinario,
           COUNT(t.id_atendimento) AS qtd_atendimentos,
           AVG(t.total)            AS media_arrecadacao
    FROM veterinario v
    INNER JOIN (
        SELECT atd.id_atendimento,
               atd.id_veterinario,
               IFNULL(SUM(ap.valor_unitario * ap.quantidade), 0) AS total
        FROM atendimento atd
        INNER JOIN situacao1 s ON s.id_situacao = atd.id_situacao
        LEFT JOIN atendimento_procedimento ap ON ap.id_atendimento = atd.id_atendimento
        WHERE s.descricao = 'Realizado'
        GROUP BY atd.id_atendimento, atd.id_veterinario
    ) AS t ON t.id_veterinario = v.id_veterinario
    GROUP BY v.id_veterinario, v.nome
) AS x
WHERE x.qtd_atendimentos >= 3
  AND x.media_arrecadacao > 200;
  
-- G
SELECT tu.nome AS tutor,
       COUNT(DISTINCT a.id_animal)       AS qtd_animais,
       COUNT(DISTINCT x.id_atendimento)  AS qtd_atendimentos_realizados,
       IFNULL(SUM(x.total), 0)           AS total_gasto,
       CASE
           WHEN IFNULL(SUM(x.total), 0) = 0   THEN 'Sem gastos'
           WHEN SUM(x.total) <= 500           THEN 'Até R$ 500'
           ELSE 'Acima de R$ 500'
       END AS classificacao
FROM tutor tu
LEFT JOIN animal a ON a.id_tutor = tu.id_tutor
LEFT JOIN (
    SELECT atd.id_atendimento,
           atd.id_animal,
           IFNULL(SUM(ap.valor_unitario * ap.quantidade), 0) AS total
    FROM atendimento atd
    INNER JOIN situacao1 s ON s.id_situacao = atd.id_situacao
    LEFT JOIN atendimento_procedimento ap ON ap.id_atendimento = atd.id_atendimento
    WHERE s.descricao = 'Realizado'
    GROUP BY atd.id_atendimento, atd.id_animal
) AS x ON x.id_animal = a.id_animal
GROUP BY tu.id_tutor, tu.nome;

-- #############################
-- ############################# EXERCICIO 7
CREATE TABLE tipo_participante (
    id_tipo   INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45)
);

CREATE TABLE tema (
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    nome    VARCHAR(45)
);

CREATE TABLE evento (
    id_evento     INT AUTO_INCREMENT PRIMARY KEY,
    titulo        VARCHAR(45),
    data_evento   DATE,
    duracao_horas INT
);


CREATE TABLE participante (
    id_participante INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45),
    email           VARCHAR(45),
    id_tipo         INT,
    CONSTRAINT fk_participante_tipo FOREIGN KEY (id_tipo)
        REFERENCES tipo_participante (id_tipo)
);

-- Tabela associativa participante x evento (N:N)
CREATE TABLE participacao_1 (
    id_evento           INT,
    id_participante     INT,
    percentual_presenca DECIMAL(5,2),
    nota                DECIMAL(4,2),
    PRIMARY KEY (id_evento, id_participante),
    CONSTRAINT fk_part_evento FOREIGN KEY (id_evento)
        REFERENCES evento (id_evento),
    CONSTRAINT fk_part_participante FOREIGN KEY (id_participante)
        REFERENCES participante (id_participante)
);

-- Tabela associativa evento x tema (N:N)
CREATE TABLE evento_tema (
    id_evento INT,
    id_tema   INT,
    PRIMARY KEY (id_evento, id_tema),
    CONSTRAINT fk_et_evento FOREIGN KEY (id_evento)
        REFERENCES evento (id_evento),
    CONSTRAINT fk_et_tema FOREIGN KEY (id_tema)
        REFERENCES tema (id_tema)
); 

INSERT INTO tipo_participante (descricao) VALUES
('Aluno'),
('Professor'),
('Convidado'),
('Visitante');

-- O tema 5 (Empreendedorismo) não será associado a eventos
INSERT INTO tema (nome) VALUES
('Ciência de Dados'),
('Banco de Dados'),
('Inteligência Artificial'),
('Sustentabilidade'),
('Empreendedorismo');

INSERT INTO evento (titulo, data_evento, duracao_horas) VALUES
('Semana de Ciência de Dados',  '2026-03-10',  8),
('Workshop de Banco de Dados',  '2026-03-17',  4),
('Congresso de IA',             '2026-04-05', 12),
('Fórum de Sustentabilidade',   '2026-04-20',  6),
('Hackathon Universitário',     '2026-05-08', 24),
('Palestra de Carreira',        '2026-05-15',  2),
('Simpósio de Pesquisa',        '2026-06-02', 10),
('Oficina de Inovação',         '2026-06-20',  3);

INSERT INTO participante (nome, email, id_tipo) VALUES
('Ana Beatriz Lima',    'ana.lima@univ.edu',       1),
('Bruno Teixeira',      'bruno.teixeira@univ.edu', 1),
('Carla Mendonça',      'carla.mendonca@univ.edu', 1),
('Daniel Ferraz',       'daniel.ferraz@univ.edu',  1),
('Eduarda Pires',       'eduarda.pires@univ.edu',  1),
('Fábio Santana',       'fabio.santana@univ.edu',  1),
('Gustavo Ribeiro',     'gustavo.ribeiro@univ.edu',1),
('Prof. Helena Duarte', 'helena.duarte@univ.edu',  2),
('Prof. Igor Almeida',  'igor.almeida@univ.edu',   2),
('Prof. Joana Campos',  'joana.campos@univ.edu',   2),
('Karina Vieira',       'karina.vieira@email.com', 3),
('Leandro Cruz',        'leandro.cruz@email.com',  3);

INSERT INTO evento_tema (id_evento, id_tema) VALUES
(1, 1), (1, 3),
(2, 2),
(3, 1), (3, 3),
(4, 4),
(5, 1), (5, 2), (5, 3),
(6, 4),
(7, 3), (7, 4),
(8, 3);

INSERT INTO participacao_1 (id_evento, id_participante, percentual_presenca, nota) VALUES
(1,  1, 100.00,  9.00),
(1,  2,  90.00,  8.50),
(1,  3,  80.00,  9.50),
(1,  8, 100.00,  8.00),
(1, 11,  70.00,  NULL),
(1,  4,   0.00,  NULL),
(2,  1,  85.00,  7.00),
(2,  5,  95.00,  8.00),
(2,  9, 100.00,  NULL),
(2,  6,  60.00,  6.50),
(3,  2, 100.00,  9.00),
(3,  3,  95.00,  8.50),
(3,  8,  90.00,  9.50),
(3, 10, 100.00,  8.00),
(3, 12,  80.00,  8.50),
(4,  4,  75.00,  7.50),
(4,  6,  50.00,  NULL),
(4,  9, 100.00,  8.00),
(5,  1, 100.00, 10.00),
(5,  2, 100.00,  9.00),
(5,  5,  90.00,  8.50),
(5,  7,  85.00,  9.00),
(5,  8,   0.00,  NULL),
(5, 11,  60.00,  7.00),
(5,  3, 100.00,  8.00),
(6,  4, 100.00,  NULL),
(6,  7,  80.00,  NULL),
(6, 12,  90.00,  NULL),
(7,  8, 100.00,  7.50),
(7,  9,  95.00,  8.00),
(7, 10,  90.00,  7.00),
(7, 11, 100.00,  8.50),
(7, 12,  85.00,  7.00),
(8,  5, 100.00,  9.50),
(8,  6,   0.00,  NULL);

-- B
SELECT e.titulo AS evento,
       COUNT(p.id_participante) AS qtd_participantes
FROM evento e
LEFT JOIN participacao_1 p ON p.id_evento = e.id_evento
WHERE e.id_evento IN (
    SELECT et.id_evento
    FROM evento_tema et
    INNER JOIN tema t ON t.id_tema = et.id_tema
    WHERE t.nome LIKE '%Dados%'
)
GROUP BY e.id_evento, e.titulo;

-- C
SELECT e.titulo AS evento,
       COUNT(p.id_participante) AS total_participantes,
       COUNT(p.nota)            AS qtd_avaliacoes,
       ROUND(AVG(p.nota), 2)    AS media_notas
FROM evento e
LEFT JOIN participacao_1 p ON p.id_evento = e.id_evento
GROUP BY e.id_evento, e.titulo;

-- D
SELECT t.nome AS tema,
       COUNT(DISTINCT p.id_participante) AS qtd_participantes
FROM tema t
LEFT JOIN evento_tema et ON et.id_tema = t.id_tema
LEFT JOIN participacao_1 p ON p.id_evento = et.id_evento
                        AND p.percentual_presenca >= 75
GROUP BY t.id_tema, t.nome;

-- E
SELECT x.titulo,
       x.qtd_participantes,
       ROUND(x.media_notas, 2) AS media_notas,
       x.menor_presenca,
       x.maior_presenca
FROM (
    SELECT e.titulo,
           COUNT(p.id_participante)    AS qtd_participantes,
           AVG(p.nota)                 AS media_notas,
           MIN(p.percentual_presenca)  AS menor_presenca,
           MAX(p.percentual_presenca)  AS maior_presenca
    FROM evento e
    INNER JOIN participacao_1 p ON p.id_evento = e.id_evento
    GROUP BY e.id_evento, e.titulo
) AS x
WHERE x.qtd_participantes >= 5
  AND x.media_notas > 8;  
  
-- F
SELECT tp.descricao AS tipo,
       COUNT(DISTINCT p.id_participante)   AS qtd_pessoas_inscritas,
       ROUND(AVG(p.percentual_presenca),2) AS media_presenca,
       COUNT(p.nota)                       AS qtd_avaliacoes
FROM tipo_participante tp
LEFT JOIN participante pa ON pa.id_tipo         = tp.id_tipo
LEFT JOIN participacao_1 p  ON p.id_participante  = pa.id_participante
GROUP BY tp.id_tipo, tp.descricao;

-- G
SELECT t.nome AS tema,
       COUNT(DISTINCT et.id_evento)       AS qtd_eventos,
       COUNT(DISTINCT p.id_participante)  AS qtd_participantes,
       ROUND(AVG(p.nota), 2)              AS media_avaliacoes
FROM tema t
LEFT JOIN evento_tema et ON et.id_tema   = t.id_tema
LEFT JOIN participacao_1 p ON p.id_evento  = et.id_evento
GROUP BY t.id_tema, t.nome;


-- ########################################################
-- ############### EXERCICIO 8
-- A
CREATE TABLE regiao (
    id_regiao INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(45)
);

CREATE TABLE situacao_projeto (
    id_situacao_projeto INT AUTO_INCREMENT PRIMARY KEY,
    descricao           VARCHAR(45)
);

CREATE TABLE area_atuacao (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nome    VARCHAR(45)
);

CREATE TABLE setor_atuacao (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    nome     VARCHAR(45)
);


CREATE TABLE projeto1 (
    id_projeto          INT AUTO_INCREMENT PRIMARY KEY,
    nome                VARCHAR(45),
    orcamento           DECIMAL(12,2),
    id_regiao           INT,
    id_situacao_projeto INT,
    CONSTRAINT fk_projeto_regiao FOREIGN KEY (id_regiao)
        REFERENCES regiao (id_regiao),
    CONSTRAINT fk_projeto_situacao FOREIGN KEY (id_situacao_projeto)
        REFERENCES situacao_projeto (id_situacao_projeto)
);


CREATE TABLE voluntario (
    id_voluntario INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(45),
    cidade        VARCHAR(45),
    id_area       INT,
    CONSTRAINT fk_voluntario_area FOREIGN KEY (id_area)
        REFERENCES area_atuacao (id_area)
);


CREATE TABLE instituicao (
    id_instituicao INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(45),
    id_setor       INT,
    CONSTRAINT fk_instituicao_setor FOREIGN KEY (id_setor)
        REFERENCES setor_atuacao (id_setor)
);

-- Tabela associativa voluntário x projeto (N:N)
CREATE TABLE participacao (
    id_projeto        INT,
    id_voluntario     INT,
    horas_trabalhadas INT,
    data_ingresso     DATE,
    PRIMARY KEY (id_projeto, id_voluntario),
    CONSTRAINT fk_part_projeto FOREIGN KEY (id_projeto)
        REFERENCES projeto (id_projeto),
    CONSTRAINT fk_part_voluntario FOREIGN KEY (id_voluntario)
        REFERENCES voluntario (id_voluntario)
);

-- Tabela associativa instituição x projeto (N:N)
CREATE TABLE apoio (
    id_instituicao     INT,
    id_projeto         INT,
    valor_contribuicao DECIMAL(12,2),
    data_contribuicao  DATE,
    PRIMARY KEY (id_instituicao, id_projeto),
    CONSTRAINT fk_apoio_instituicao FOREIGN KEY (id_instituicao)
        REFERENCES instituicao (id_instituicao),
    CONSTRAINT fk_apoio_projeto FOREIGN KEY (id_projeto)
        REFERENCES projeto (id_projeto)
);

INSERT INTO regiao (nome) VALUES
('Sul'),
('Sudeste'),
('Norte'),
('Nordeste'),
('Centro-Oeste');

INSERT INTO situacao_projeto (descricao) VALUES
('Planejado'),
('Ativo'),
('Finalizado');

INSERT INTO area_atuacao (nome) VALUES
('Educação Ambiental'),
('Pesquisa'),
('Restauração');

INSERT INTO setor_atuacao (nome) VALUES
('Empresarial'),
('Governamental'),
('Terceiro Setor');

-- Os projetos 6 e 8 não terão apoio financeiro nem voluntários
INSERT INTO projeto (nome, orcamento, id_regiao, id_situacao_projeto) VALUES
('Rios Limpos',                    100000.00, 1, 2),
('Mata Viva',                      150000.00, 2, 2),
('Restauração do Cerrado',          80000.00, 5, 2),
('Proteção das Tartarugas',         60000.00, 4, 3),
('Floresta Amazônica Sustentável', 200000.00, 3, 2),
('Corredor Ecológico',             120000.00, 2, 1),
('Educação nas Escolas',            40000.00, 1, 3),
('Manguezais Vivos',                90000.00, 4, 1);

-- Igor Mendes (9) e Júlia Prado (10) não têm participações
INSERT INTO voluntario (nome, cidade, id_area) VALUES
('Ana Clara Souza',  'Porto Alegre',   1),
('Bruno Carvalho',   'Curitiba',       2),
('Carolina Dias',    'Salvador',       3),
('Diego Fernandes',  'Manaus',         2),
('Eduardo Pinto',    'São Paulo',      3),
('Fernanda Lopes',   'Belém',          1),
('Gabriel Matos',    'Goiânia',        3),
('Helena Barbosa',   'Recife',         1),
('Igor Mendes',      'Campinas',       2),
('Júlia Prado',      'Florianópolis',  1);

INSERT INTO instituicao (nome, id_setor) VALUES
('Banco Verde',                 1),
('Secretaria do Meio Ambiente', 2),
('ONG Planeta Azul',            3),
('Energia Limpa S.A.',          1),
('Fundação Floresta',           3);

INSERT INTO participacao (id_projeto, id_voluntario, horas_trabalhadas, data_ingresso) VALUES
(1, 1,  40, '2026-01-10'),
(1, 2,  30, '2026-01-15'),
(1, 3,  50, '2026-02-01'),
(2, 1,  60, '2026-02-10'),
(2, 4,  80, '2026-02-12'),
(2, 5,  40, '2026-02-20'),
(2, 6,  20, '2026-03-01'),
(3, 2,  25, '2026-03-05'),
(3, 7,  35, '2026-03-10'),
(4, 3,  70, '2025-05-02'),
(4, 8,  50, '2025-05-15'),
(5, 4, 100, '2026-01-20'),
(5, 5,  90, '2026-01-25'),
(5, 6, 110, '2026-02-02'),
(5, 7,  80, '2026-02-08'),
(5, 8,  60, '2026-02-15'),
(7, 1,  20, '2025-08-10'),
(7, 8,  30, '2025-08-12');

INSERT INTO apoio (id_instituicao, id_projeto, valor_contribuicao, data_contribuicao) VALUES
(1, 1, 30000.00, '2026-01-05'),
(3, 1, 20000.00, '2026-01-20'),
(1, 2, 50000.00, '2026-02-01'),
(2, 2, 60000.00, '2026-02-05'),
(4, 2, 45000.00, '2026-02-18'),
(2, 3, 40000.00, '2026-03-01'),
(3, 4, 60000.00, '2025-04-20'),
(2, 5, 80000.00, '2026-01-10'),
(4, 5, 60000.00, '2026-01-30'),
(5, 5, 50000.00, '2026-02-20'),
(3, 7, 15000.00, '2025-07-30');

-- B
ALTER TABLE projeto
    ADD COLUMN meta_horas INT DEFAULT 100,
    ADD CONSTRAINT chk_meta_horas CHECK (meta_horas >= 0);

UPDATE projeto SET meta_horas = 150 WHERE id_projeto = 1;
UPDATE projeto SET meta_horas = 180 WHERE id_projeto = 2;
UPDATE projeto SET meta_horas = 80  WHERE id_projeto = 3;
UPDATE projeto SET meta_horas = 500 WHERE id_projeto = 5;
UPDATE projeto SET meta_horas = 60  WHERE id_projeto = 7;

-- C
SELECT p.nome AS projeto,
       r.nome AS regiao,
       COUNT(pa.id_voluntario)              AS qtd_voluntarios,
       IFNULL(SUM(pa.horas_trabalhadas), 0) AS total_horas
FROM projeto p
INNER JOIN regiao r            ON r.id_regiao            = p.id_regiao
INNER JOIN situacao_projeto sp ON sp.id_situacao_projeto = p.id_situacao_projeto
LEFT JOIN participacao pa      ON pa.id_projeto          = p.id_projeto
WHERE sp.descricao = 'Ativo'
  AND r.nome LIKE '%s%'
GROUP BY p.id_projeto, p.nome, r.nome;

-- D
SELECT t.instituicao,
       t.setor,
       t.qtd_projetos,
       t.total_contribuido,
       t.media_por_projeto
FROM (
    SELECT i.nome  AS instituicao,
           st.nome AS setor,
           COUNT(DISTINCT a.id_projeto)                                    AS qtd_projetos,
           SUM(a.valor_contribuicao)                                       AS total_contribuido,
           ROUND(SUM(a.valor_contribuicao) / COUNT(DISTINCT a.id_projeto), 2) AS media_por_projeto
    FROM instituicao i
    INNER JOIN setor_atuacao st ON st.id_setor      = i.id_setor
    INNER JOIN apoio a          ON a.id_instituicao = i.id_instituicao
    GROUP BY i.id_instituicao, i.nome, st.nome
) AS t
WHERE t.qtd_projetos >= 2;

-- E
SELECT p.nome AS projeto,
       p.orcamento,
       IFNULL(SUM(a.valor_contribuicao), 0) AS total_recebido,
       ROUND(IFNULL(SUM(a.valor_contribuicao), 0) / p.orcamento * 100, 2) AS percentual_cobertura
FROM projeto p
LEFT JOIN apoio a ON a.id_projeto = p.id_projeto
GROUP BY p.id_projeto, p.nome, p.orcamento;

-- F
SELECT t.projeto,
       t.meta_horas,
       t.total_horas,
       t.meta_horas - t.total_horas                       AS diferenca_horas,
       ROUND(t.total_horas / t.meta_horas * 100, 2)       AS percentual_meta_atingido
FROM (
    SELECT p.nome AS projeto,
           p.meta_horas,
           IFNULL(SUM(pa.horas_trabalhadas), 0) AS total_horas
    FROM projeto p
    LEFT JOIN participacao pa ON pa.id_projeto = p.id_projeto
    GROUP BY p.id_projeto, p.nome, p.meta_horas
) AS t
WHERE t.total_horas < t.meta_horas;

-- G 
SELECT p.nome AS projeto,
       sp.descricao AS situacao,
       IFNULL(v.qtd_voluntarios, 0)   AS qtd_voluntarios,
       IFNULL(v.total_horas, 0)       AS total_horas,
       IFNULL(ap.qtd_instituicoes, 0) AS qtd_instituicoes,
       IFNULL(ap.total_recebido, 0)   AS total_recebido,
       CASE
           WHEN IFNULL(ap.total_recebido, 0) = 0 THEN 'Sem apoio'
           WHEN ap.total_recebido < p.orcamento  THEN 'Apoio parcial'
           ELSE 'Orçamento coberto'
       END AS classificacao
FROM projeto p
INNER JOIN situacao_projeto sp ON sp.id_situacao_projeto = p.id_situacao_projeto
LEFT JOIN (
    SELECT id_projeto,
           COUNT(id_voluntario)   AS qtd_voluntarios,
           SUM(horas_trabalhadas) AS total_horas
    FROM participacao
    GROUP BY id_projeto
) AS v ON v.id_projeto = p.id_projeto
LEFT JOIN (
    SELECT id_projeto,
           COUNT(id_instituicao)   AS qtd_instituicoes,
           SUM(valor_contribuicao) AS total_recebido
    FROM apoio
    GROUP BY id_projeto
) AS ap ON ap.id_projeto = p.id_projeto;

CREATE TABLE genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(45)
);

CREATE TABLE situacao_desenvolvimento (
    id_situacao INT AUTO_INCREMENT PRIMARY KEY,
    descricao   VARCHAR(45)
);

CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45)
);

CREATE TABLE nivel_experiencia (
    id_nivel  INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45)
);

-- Cada jogo pertence a um gênero e a uma situação (1:N)
CREATE TABLE jogo (
    id_jogo     INT AUTO_INCREMENT PRIMARY KEY,
    titulo      VARCHAR(45),
    orcamento   DECIMAL(12,2),
    id_genero   INT,
    id_situacao INT,
    CONSTRAINT fk_jogo_genero FOREIGN KEY (id_genero)
        REFERENCES genero (id_genero),
    CONSTRAINT fk_jogo_situacao FOREIGN KEY (id_situacao)
        REFERENCES situacao_desenvolvimento (id_situacao)
);

-- Cada desenvolvedor possui uma especialidade (1:N)
CREATE TABLE desenvolvedor (
    id_desenvolvedor INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45),
    valor_hora       DECIMAL(8,2),
    id_especialidade INT,
    CONSTRAINT fk_dev_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id_especialidade)
);

-- Cada testador possui um nível de experiência (1:N)
CREATE TABLE testador (
    id_testador INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(45),
    id_nivel    INT,
    CONSTRAINT fk_testador_nivel FOREIGN KEY (id_nivel)
        REFERENCES nivel_experiencia (id_nivel)
);

-- Tabela associativa desenvolvedor x jogo (N:N)
CREATE TABLE participacao (
    id_jogo           INT,
    id_desenvolvedor  INT,
    horas_trabalhadas INT,
    PRIMARY KEY (id_jogo, id_desenvolvedor),
    CONSTRAINT fk_part_jogo FOREIGN KEY (id_jogo)
        REFERENCES jogo (id_jogo),
    CONSTRAINT fk_part_dev FOREIGN KEY (id_desenvolvedor)
        REFERENCES desenvolvedor (id_desenvolvedor)
);

-- Tabela associativa testador x jogo (N:N).
-- A chave primária composta garante no máximo uma avaliação por testador em cada jogo.
CREATE TABLE avaliacao (
    id_jogo         INT,
    id_testador     INT,
    nota            DECIMAL(4,2),
    qtd_problemas   INT,
    data_avaliacao  DATE,
    PRIMARY KEY (id_jogo, id_testador),
    CONSTRAINT chk_nota CHECK (nota BETWEEN 0 AND 10),
    CONSTRAINT fk_aval_jogo FOREIGN KEY (id_jogo)
        REFERENCES jogo (id_jogo),
    CONSTRAINT fk_aval_testador FOREIGN KEY (id_testador)
        REFERENCES testador (id_testador)
);

INSERT INTO genero (nome) VALUES
('Ação'),
('RPG'),
('Puzzle'),
('Estratégia');

INSERT INTO situacao_desenvolvimento (descricao) VALUES
('Planejamento'),
('Desenvolvimento'),
('Lançado');

INSERT INTO especialidade (nome) VALUES
('Programação'),
('Arte'),
('Design de Som');

INSERT INTO nivel_experiencia (descricao) VALUES
('Iniciante'),
('Intermediário'),
('Avançado');

-- Os jogos 5 e 6 não terão avaliações
INSERT INTO jogo (titulo, orcamento, id_genero, id_situacao) VALUES
('Reino de Cinzas',      150000.00, 2, 3),
('Corrida Neon',          80000.00, 1, 3),
('Labirinto Lunar',       40000.00, 3, 3),
('Guardiões do Abismo',  200000.00, 1, 2),
('Império Estelar',      120000.00, 4, 2),
('Cidade dos Sonhos',     60000.00, 3, 1);

-- Pedro Alves (7) e Fernanda Dias (8) não participam de jogos
INSERT INTO desenvolvedor (nome, valor_hora, id_especialidade) VALUES
('Alejandro Ramírez', 80.00, 1),
('Valentina Conti',   70.00, 2),
('Javier Moretti',    90.00, 1),
('Gabriela Torres',   60.00, 3),
('Mateo Greco',       75.00, 2),
('Camila Vargas',     85.00, 1),
('Andrés Ricci',      65.00, 3),
('Lucía Castillo',    95.00, 1);

INSERT INTO testador (nome, id_nivel) VALUES
('Ana Torres',     3),
('Bruno Villamarín',   2),
('Clara Mendez',     3),
('David Pina',     1),
('Emília Benitez',  1),
('Fábio Lescano',    2),
('Gilda Ramos',   3);

-- O jogo 6 não tem participações
INSERT INTO participacao (id_jogo, id_desenvolvedor, horas_trabalhadas) VALUES
(1, 1, 500),
(1, 2, 400),
(1, 3, 300),
(1, 4, 200),
(2, 1, 300),
(2, 5, 350),
(2, 6, 400),
(3, 2, 200),
(3, 4, 150),
(4, 3, 800),
(4, 6, 700),
(4, 1, 600),
(4, 5, 500),
(4, 2, 300),
(5, 6, 200),
(5, 4, 100);

INSERT INTO avaliacao (id_jogo, id_testador, nota, qtd_problemas, data_avaliacao) VALUES
(1, 1,  8.50,  5, '2026-02-10'),
(1, 2,  9.00,  3, '2026-02-12'),
(1, 3,  7.50,  8, '2026-02-15'),
(1, 4,  8.00,  4, '2026-02-18'),
(2, 1,  6.50, 12, '2026-03-05'),
(2, 2,  7.00,  9, '2026-03-07'),
(2, 5,  5.50, 15, '2026-03-10'),
(3, 3,  9.50,  1, '2026-03-20'),
(3, 6,  8.50,  2, '2026-03-22'),
(4, 1,  4.00, 20, '2026-04-02'),
(4, 2,  5.50, 14, '2026-04-04'),
(4, 3,  6.00, 11, '2026-04-06'),
(4, 6,  3.50, 25, '2026-04-08'),
(4, 7,  5.00, 17, '2026-04-10');

-- B
SELECT d.nome  AS desenvolvedor,
       e.nome  AS especialidade,
       j.titulo AS jogo,
       p.horas_trabalhadas,
       p.horas_trabalhadas * d.valor_hora AS custo_participacao
FROM participacao p
INNER JOIN jogo j                        ON j.id_jogo          = p.id_jogo
INNER JOIN situacao_desenvolvimento sd   ON sd.id_situacao     = j.id_situacao
INNER JOIN desenvolvedor d               ON d.id_desenvolvedor = p.id_desenvolvedor
INNER JOIN especialidade e               ON e.id_especialidade = d.id_especialidade
WHERE sd.descricao = 'Lançado'
ORDER BY j.titulo, d.nome;

-- C
SELECT j.titulo AS jogo,
       COUNT(p.id_desenvolvedor)                           AS qtd_desenvolvedores,
       IFNULL(SUM(p.horas_trabalhadas), 0)                 AS total_horas,
       IFNULL(SUM(p.horas_trabalhadas * d.valor_hora), 0)  AS custo_total
FROM jogo j
LEFT JOIN participacao p   ON p.id_jogo          = j.id_jogo
LEFT JOIN desenvolvedor d  ON d.id_desenvolvedor = p.id_desenvolvedor
GROUP BY j.id_jogo, j.titulo;

-- D
SELECT t.titulo,
       t.qtd_avaliacoes,
       ROUND(t.media_notas, 2) AS media_notas,
       t.total_problemas
FROM (
    SELECT j.titulo,
           COUNT(a.id_testador) AS qtd_avaliacoes,
           AVG(a.nota)          AS media_notas,
           SUM(a.qtd_problemas) AS total_problemas
    FROM jogo j
    INNER JOIN avaliacao a ON a.id_jogo = j.id_jogo
    GROUP BY j.id_jogo, j.titulo
) AS t
WHERE t.qtd_avaliacoes >= 3;

-- E
SELECT g.nome AS genero,
       COUNT(DISTINCT j.id_jogo)  AS qtd_jogos,
       COUNT(DISTINCT a.id_jogo)  AS qtd_jogos_avaliados,
       ROUND(AVG(a.nota), 2)      AS media_notas
FROM genero g
LEFT JOIN jogo j       ON j.id_genero = g.id_genero
LEFT JOIN avaliacao a  ON a.id_jogo   = j.id_jogo
GROUP BY g.id_genero, g.nome;

-- F
SELECT t.titulo,
       t.orcamento,
       t.custo_total,
       ROUND((t.custo_total - t.orcamento) / t.orcamento * 100, 2) AS percentual_excedido
FROM (
    SELECT j.titulo,
           j.orcamento,
           SUM(p.horas_trabalhadas * d.valor_hora) AS custo_total
    FROM jogo j
    INNER JOIN participacao p  ON p.id_jogo          = j.id_jogo
    INNER JOIN desenvolvedor d ON d.id_desenvolvedor = p.id_desenvolvedor
    GROUP BY j.id_jogo, j.titulo, j.orcamento
) AS t
WHERE t.custo_total > t.orcamento;

-- G
SELECT j.titulo,
       g.nome       AS genero,
       sd.descricao AS situacao,
       IFNULL(c.custo_total, 0)         AS custo_total,
       IFNULL(c.qtd_desenvolvedores, 0) AS qtd_desenvolvedores,
       IFNULL(a.qtd_avaliacoes, 0)      AS qtd_avaliacoes,
       ROUND(a.media_notas, 2)          AS media_notas,
       IFNULL(a.total_problemas, 0)     AS total_problemas,
       CASE
           WHEN a.qtd_avaliacoes IS NULL THEN 'Sem avaliação'
           WHEN a.media_notas < 6        THEN 'Avaliação baixa'
           WHEN a.media_notas < 8        THEN 'Avaliação regular'
           ELSE 'Avaliação alta'
       END AS classificacao
FROM jogo j
INNER JOIN genero g                      ON g.id_genero  = j.id_genero
INNER JOIN situacao_desenvolvimento sd   ON sd.id_situacao = j.id_situacao
LEFT JOIN (
    SELECT p.id_jogo,
           COUNT(p.id_desenvolvedor)                AS qtd_desenvolvedores,
           SUM(p.horas_trabalhadas * d.valor_hora)  AS custo_total
    FROM participacao p
    INNER JOIN desenvolvedor d ON d.id_desenvolvedor = p.id_desenvolvedor
    GROUP BY p.id_jogo
) AS c ON c.id_jogo = j.id_jogo
LEFT JOIN (
    SELECT id_jogo,
           COUNT(id_testador)  AS qtd_avaliacoes,
           AVG(nota)           AS media_notas,
           SUM(qtd_problemas)  AS total_problemas
    FROM avaliacao
    GROUP BY id_jogo
) AS a ON a.id_jogo = j.id_jogo;

-- ################### EXERCIIO 10
CREATE TABLE area_conhecimento (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nome    VARCHAR(45)
);

-- Cada programa pertence a uma área de conhecimento (1:N)
CREATE TABLE programa (
    id_programa    INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(45),
    carga_horaria  INT,
    id_area        INT,
    CONSTRAINT fk_programa_area FOREIGN KEY (id_area)
        REFERENCES area_conhecimento (id_area)
);

-- Autorrelacionamento: o supervisor também é um instrutor.
-- Uma única coluna garante no máximo um supervisor por instrutor.
CREATE TABLE instrutor (
    id_instrutor  INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(45),
    valor_hora    DECIMAL(8,2),
    id_supervisor INT,
    CONSTRAINT fk_instrutor_supervisor FOREIGN KEY (id_supervisor)
        REFERENCES instrutor (id_instrutor)
);

CREATE TABLE patrocinador (
    id_patrocinador INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(45)
);

-- Tabela associativa instrutor x programa (N:N)
CREATE TABLE atuacao (
    id_programa       INT,
    id_instrutor      INT,
    horas_ministradas INT,
    nota_desempenho   DECIMAL(4,2),
    PRIMARY KEY (id_programa, id_instrutor),
    CONSTRAINT chk_nota_desempenho CHECK (nota_desempenho BETWEEN 0 AND 10),
    CONSTRAINT fk_atuacao_programa FOREIGN KEY (id_programa)
        REFERENCES programa (id_programa),
    CONSTRAINT fk_atuacao_instrutor FOREIGN KEY (id_instrutor)
        REFERENCES instrutor (id_instrutor)
);

-- Tabela associativa programa x patrocinador (N:N)
CREATE TABLE patrocinio (
    id_programa     INT,
    id_patrocinador INT,
    valor_destinado DECIMAL(12,2),
    PRIMARY KEY (id_programa, id_patrocinador),
    CONSTRAINT fk_patrocinio_programa FOREIGN KEY (id_programa)
        REFERENCES programa (id_programa),
    CONSTRAINT fk_patrocinio_patrocinador FOREIGN KEY (id_patrocinador)
        REFERENCES patrocinador (id_patrocinador)
);

INSERT INTO area_conhecimento (nome) VALUES
('Tecnologia'),
('Gestão'),
('Indústria');

-- Alejandro (1) e Valentina (2) não têm supervisor.
-- Javier (3) é subordinado de Alejandro e supervisor de Lucía (8),
-- que não atua em nenhum programa.
INSERT INTO instrutor (nome, valor_hora, id_supervisor) VALUES
('Alejandro Ferrari',  100.00, NULL),
('Valentina Rossi',    120.00, NULL),
('Javier Moreno',       80.00, 1),
('Graziela Conti',      90.00, 1),
('Fabián Ramírez',       70.00, 1),
('Camila Bianchi',      85.00, 2),
('Andrés Herrera',      75.00, 2),
('Lucía Esposito',      95.00, 3);

INSERT INTO programa (nome, carga_horaria, id_area) VALUES
('Programação Web',     80, 1),
('Excel Avançado',      40, 2),
('Soldagem Industrial', 60, 3),
('Gestão de Projetos',  50, 2),
('Python para Dados',   70, 1),
('Eletricista Predial', 100, 3);

INSERT INTO patrocinador (nome) VALUES
('Fundação Andes'),
('Banco Meridional'),
('Indústrias Moretti'),
('Instituto Sol');

INSERT INTO atuacao (id_programa, id_instrutor, horas_ministradas, nota_desempenho) VALUES
(1, 3, 40, 8.50),
(1, 4, 30, 9.00),
(1, 5, 20, 7.50),
(2, 6, 25, 8.00),
(2, 7, 20, 6.50),
(3, 5, 30, 7.00),
(3, 6, 20, 9.50),
(4, 1, 30, 9.00),
(4, 2, 15, 8.50),
(5, 4, 40, 8.00),
(5, 3, 30, 7.50),
(5, 7, 10, 6.00),
(6, 2, 20, 9.00);

-- O programa 6 não tem patrocinadores
INSERT INTO patrocinio (id_programa, id_patrocinador, valor_destinado) VALUES
(1, 1, 4000.00),
(1, 2, 2000.00),
(2, 3, 5000.00),
(3, 4, 3000.00),
(4, 1, 2000.00),
(4, 2, 3000.00),
(5, 2, 4000.00),
(5, 3, 2500.00);

SELECT i.nome AS instrutor,
       s.nome AS supervisor
FROM instrutor i
LEFT JOIN instrutor s ON s.id_instrutor = i.id_supervisor
ORDER BY i.id_instrutor;

SELECT sup.nome AS supervisor,
       COUNT(DISTINCT sub.id_instrutor)                         AS qtd_supervisionados,
       IFNULL(SUM(a.horas_ministradas), 0)                      AS total_horas,
       IFNULL(SUM(a.horas_ministradas * sub.valor_hora), 0)     AS custo_total
FROM instrutor sup
INNER JOIN instrutor sub ON sub.id_supervisor = sup.id_instrutor
LEFT JOIN atuacao a      ON a.id_instrutor    = sub.id_instrutor
GROUP BY sup.id_instrutor, sup.nome;

SELECT t.programa,
       t.carga_horaria,
       t.total_horas,
       t.total_horas - t.carga_horaria AS diferenca
FROM (
    SELECT p.nome AS programa,
           p.carga_horaria,
           SUM(a.horas_ministradas) AS total_horas
    FROM programa p
    INNER JOIN atuacao a ON a.id_programa = p.id_programa
    GROUP BY p.id_programa, p.nome, p.carga_horaria
) AS t
WHERE t.total_horas > t.carga_horaria;

SELECT p.nome AS programa,
       ar.nome AS area,
       COUNT(a.id_instrutor)                                AS qtd_instrutores,
       ROUND(AVG(a.nota_desempenho), 2)                     AS media_notas,
       IFNULL(SUM(a.horas_ministradas * i.valor_hora), 0)   AS custo_total
FROM programa p
INNER JOIN area_conhecimento ar ON ar.id_area      = p.id_area
LEFT JOIN atuacao a             ON a.id_programa   = p.id_programa
LEFT JOIN instrutor i           ON i.id_instrutor  = a.id_instrutor
GROUP BY p.id_programa, p.nome, ar.nome;

SELECT t.programa,
       t.total_patrocinio,
       t.custo_total,
       ROUND(t.custo_total - t.total_patrocinio, 2) AS diferenca
FROM (
    SELECT p.nome AS programa,
           IFNULL(pt.total, 0) AS total_patrocinio,
           IFNULL(c.custo, 0)  AS custo_total
    FROM programa p
    LEFT JOIN (
        SELECT id_programa,
               SUM(valor_destinado) AS total
        FROM patrocinio
        GROUP BY id_programa
    ) AS pt ON pt.id_programa = p.id_programa
    LEFT JOIN (
        SELECT a.id_programa,
               SUM(a.horas_ministradas * i.valor_hora) AS custo
        FROM atuacao a
        INNER JOIN instrutor i ON i.id_instrutor = a.id_instrutor
        GROUP BY a.id_programa
    ) AS c ON c.id_programa = p.id_programa
) AS t
WHERE t.total_patrocinio < t.custo_total;

SELECT sup.nome AS supervisor,
       COUNT(DISTINCT sub.id_instrutor)                         AS qtd_supervisionados,
       COUNT(DISTINCT a.id_programa)                            AS qtd_programas,
       IFNULL(SUM(a.horas_ministradas * sub.valor_hora), 0)     AS custo_total,
       ROUND(AVG(a.nota_desempenho), 2)                         AS media_desempenho
FROM instrutor sup
INNER JOIN instrutor sub ON sub.id_supervisor = sup.id_instrutor
LEFT JOIN atuacao a      ON a.id_instrutor    = sub.id_instrutor
GROUP BY sup.id_instrutor, sup.nome;


-- #########################################################
-- #######################################EXERCICIO 11

CREATE TABLE situacao_projeto (
    id_situacao_projeto INT AUTO_INCREMENT PRIMARY KEY,
    descricao           VARCHAR(45)
);

CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45)
);

CREATE TABLE categoria_equipamento (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(45)
);


CREATE TABLE projeto (
    id_projeto          INT AUTO_INCREMENT PRIMARY KEY,
    nome                VARCHAR(45),
    orcamento           DECIMAL(12,2),
    data_inicio         DATE,
    id_situacao_projeto INT,
    CONSTRAINT fk_projeto_situacao FOREIGN KEY (id_situacao_projeto)
        REFERENCES situacao_projeto (id_situacao_projeto)
);


CREATE TABLE profissional (
    id_profissional  INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45),
    valor_hora       DECIMAL(8,2),
    id_especialidade INT,
    CONSTRAINT fk_profissional_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id_especialidade)
);


CREATE TABLE equipamento (
    id_equipamento INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(45),
    custo_hora     DECIMAL(8,2),
    id_categoria   INT,
    CONSTRAINT fk_equipamento_categoria FOREIGN KEY (id_categoria)
        REFERENCES categoria_equipamento (id_categoria)
);

-- Tabela associativa profissional x projeto (N:N)
CREATE TABLE participacao (
    id_projeto       INT,
    id_profissional  INT,
    horas_dedicadas  INT,
    PRIMARY KEY (id_projeto, id_profissional),
    CONSTRAINT fk_part_projeto FOREIGN KEY (id_projeto)
        REFERENCES projeto (id_projeto),
    CONSTRAINT fk_part_profissional FOREIGN KEY (id_profissional)
        REFERENCES profissional (id_profissional)
);

-- Tabela associativa equipamento x projeto (N:N)
CREATE TABLE utilizacao (
    id_projeto      INT,
    id_equipamento  INT,
    horas_uso       INT,
    qtd_sessoes     INT,
    PRIMARY KEY (id_projeto, id_equipamento),
    CONSTRAINT fk_util_projeto FOREIGN KEY (id_projeto)
        REFERENCES projeto (id_projeto),
    CONSTRAINT fk_util_equipamento FOREIGN KEY (id_equipamento)
        REFERENCES equipamento (id_equipamento)
);

INSERT INTO situacao_projeto (descricao) VALUES
('Planejado'),
('Em andamento'),
('Concluído');

INSERT INTO especialidade (nome) VALUES
('Medicina'),
('Enfermagem'),
('Biomedicina');

INSERT INTO categoria_equipamento (nome) VALUES
('Diagnóstico por Imagem'),
('Laboratório'),
('Monitoramento');



INSERT INTO projeto (nome, orcamento, data_inicio, id_situacao_projeto) VALUES
('Pesquisa Cardiovascular',  100000.00, '2026-01-10', 2),
('Estudo de Diabetes',        60000.00, '2026-02-15', 2),
('Pesquisa Oncológica',      150000.00, '2025-06-01', 2),
('Vacina Experimental',       80000.00, '2025-03-20', 3),
('Telemedicina Rural',         8000.00, '2026-04-01', 1),
('Pesquisa em Neurologia',   120000.00, '2026-03-05', 2),
('Terapia Genética',         200000.00, '2027-01-10', 1);


INSERT INTO profissional (nome, valor_hora, id_especialidade) VALUES
('Santiago Ricci',    150.00, 1),
('Valeria Marcone',   140.00, 1),
('Mateo Gutiérrez',    60.00, 2),
('Isabella Romano',    55.00, 2),
('Diego Fernández',    90.00, 3),
('Camila Bellini',     85.00, 3),
('Lucas Herrera',     160.00, 1),
('Sofía Navarro',      58.00, 2),
('Emilio Conti',       95.00, 3),
('Daniela Castro',    145.00, 1);


INSERT INTO equipamento (nome, custo_hora, id_categoria) VALUES
('Ressonância Magnética',    200.00, 1),
('Tomógrafo',                180.00, 1),
('Centrífuga',                20.00, 2),
('Microscópio Eletrônico',    50.00, 2),
('Monitor Multiparamétrico',  15.00, 3),
('Ultrassom Portátil',        40.00, 1),
('Sequenciador de DNA',      120.00, 2),
('Eletrocardiógrafo',         25.00, 3);

INSERT INTO participacao (id_projeto, id_profissional, horas_dedicadas) VALUES
(1, 1, 100),
(1, 3, 200),
(1, 5,  80),
(2, 2, 120),
(2, 4, 150),
(2, 6,  60),
(3, 1, 150),
(3, 7, 100),
(3, 3, 100),
(3, 5, 120),
(3, 8,  80),
(4, 2,  80),
(4, 6, 100),
(4, 4,  50),
(5, 8, 100),
(5, 3,  50),
(6, 7,  60),
(6, 5,  40);

INSERT INTO utilizacao (id_projeto, id_equipamento, horas_uso, qtd_sessoes) VALUES
(1, 1,  10,  5),
(1, 3,  30, 10),
(1, 5, 100, 20),
(2, 3,  20,  8),
(2, 4,  15,  5),
(3, 1,   8,  4),
(3, 2,   6,  3),
(3, 4,  10,  4),
(3, 6,  12,  6),
(4, 3,  25, 12),
(4, 5,  60, 15),
(4, 6,   5,  2),
(6, 2,   5,  2),
(6, 4,   8,  3);


SELECT p.nome AS projeto,
       COUNT(pa.id_profissional)                              AS qtd_profissionais,
       IFNULL(SUM(pa.horas_dedicadas * pr.valor_hora), 0)     AS custo_profissionais
	FROM projeto p
	LEFT JOIN participacao pa  ON pa.id_projeto      = p.id_projeto
	LEFT JOIN profissional pr  ON pr.id_profissional = pa.id_profissional
		WHERE p.nome LIKE '%Pesquisa%'
		GROUP BY p.id_projeto, p.nome;


SELECT c.nome AS categoria,
       COUNT(DISTINCT e.id_equipamento)                    AS qtd_equipamentos,
       COUNT(DISTINCT u.id_projeto)                        AS qtd_projetos,
       IFNULL(SUM(u.horas_uso * e.custo_hora), 0)          AS custo_total_utilizacao
	FROM categoria_equipamento c
	LEFT JOIN equipamento e ON e.id_categoria   = c.id_categoria
	LEFT JOIN utilizacao u  ON u.id_equipamento = e.id_equipamento
		GROUP BY c.id_categoria, c.nome;


SELECT t.projeto,
       t.qtd_equipamentos,
       t.custo_equipamentos
FROM (
    SELECT p.nome AS projeto,
           COUNT(DISTINCT u.id_equipamento)     AS qtd_equipamentos,
           SUM(u.horas_uso * e.custo_hora)      AS custo_equipamentos
    FROM projeto p
    INNER JOIN utilizacao u  ON u.id_projeto     = p.id_projeto
    INNER JOIN equipamento e ON e.id_equipamento = u.id_equipamento
    GROUP BY p.id_projeto, p.nome
) 	AS t
	WHERE t.qtd_equipamentos >= 3
	AND t.custo_equipamentos > 2000;
  
  
SELECT es.nome AS especialidade,
       COUNT(DISTINCT pa.id_profissional)  AS qtd_profissionais_atuantes,
       IFNULL(SUM(pa.horas_dedicadas), 0)  AS total_horas,
       ROUND(SUM(pa.horas_dedicadas * pr.valor_hora) / SUM(pa.horas_dedicadas), 2) AS custo_medio_hora
	FROM especialidade es
	LEFT JOIN profissional pr ON pr.id_especialidade = es.id_especialidade
	LEFT JOIN participacao pa ON pa.id_profissional  = pr.id_profissional
		GROUP BY es.id_especialidade, es.nome;

SELECT t.projeto,
       t.situacao,
       t.custo_profissionais,
       t.custo_equipamentos,
       t.custo_profissionais + t.custo_equipamentos AS custo_geral,
       t.orcamento - (t.custo_profissionais + t.custo_equipamentos) AS orcamento_disponivel,
       ROUND((t.custo_profissionais + t.custo_equipamentos) / t.orcamento * 100, 2) AS percentual_utilizado
FROM (
    SELECT p.id_projeto,
           p.nome AS projeto,
           sp.descricao AS situacao,
           p.orcamento,
           IFNULL(pf.custo, 0) AS custo_profissionais,
           IFNULL(eq.custo, 0) AS custo_equipamentos
    FROM projeto p
    INNER JOIN situacao_projeto sp ON sp.id_situacao_projeto = p.id_situacao_projeto
    LEFT JOIN (
        SELECT pa.id_projeto,
               SUM(pa.horas_dedicadas * pr.valor_hora) AS custo
        FROM participacao pa
        INNER JOIN profissional pr ON pr.id_profissional = pa.id_profissional
        GROUP BY pa.id_projeto
    ) AS pf ON pf.id_projeto = p.id_projeto
    LEFT JOIN (
        SELECT u.id_projeto,
               SUM(u.horas_uso * e.custo_hora) AS custo
        FROM utilizacao u
        INNER JOIN equipamento e ON e.id_equipamento = u.id_equipamento
        GROUP BY u.id_projeto
    ) AS eq ON eq.id_projeto = p.id_projeto
) AS t
ORDER BY t.id_projeto;

SELECT t.projeto,
       t.qtd_profissionais,
       t.qtd_equipamentos,
       t.custo_profissionais,
       t.custo_equipamentos,
       t.total_sessoes,
       ROUND((t.custo_profissionais + t.custo_equipamentos) / t.orcamento * 100, 2) AS percentual_utilizado,
       CASE
           WHEN t.custo_profissionais + t.custo_equipamentos = 0           THEN 'Sem custo'
           WHEN t.custo_profissionais + t.custo_equipamentos > t.orcamento THEN 'Acima do orçamento'
           ELSE 'Dentro do orçamento'
       END AS classificacao
FROM (
    SELECT p.nome AS projeto,
           p.orcamento,
           IFNULL(pf.qtd, 0)    AS qtd_profissionais,
           IFNULL(eq.qtd, 0)    AS qtd_equipamentos,
           IFNULL(pf.custo, 0)  AS custo_profissionais,
           IFNULL(eq.custo, 0)  AS custo_equipamentos,
           IFNULL(eq.sessoes, 0) AS total_sessoes
    FROM projeto p
    LEFT JOIN (
        SELECT pa.id_projeto,
               COUNT(pa.id_profissional)               AS qtd,
               SUM(pa.horas_dedicadas * pr.valor_hora) AS custo
        FROM participacao pa
        INNER JOIN profissional pr ON pr.id_profissional = pa.id_profissional
        GROUP BY pa.id_projeto
    ) AS pf ON pf.id_projeto = p.id_projeto
    LEFT JOIN (
        SELECT u.id_projeto,
               COUNT(u.id_equipamento)         AS qtd,
               SUM(u.horas_uso * e.custo_hora) AS custo,
               SUM(u.qtd_sessoes)              AS sessoes
        FROM utilizacao u
        INNER JOIN equipamento e ON e.id_equipamento = u.id_equipamento
        GROUP BY u.id_projeto
    ) AS eq ON eq.id_projeto = p.id_projeto
) AS t
ORDER BY percentual_utilizado DESC;


-- #########################################################
-- #######################################EXERCICIO 12

CREATE TABLE pais (
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    nome    VARCHAR(45)
);

CREATE TABLE situacao_missao (
    id_situacao_missao INT AUTO_INCREMENT PRIMARY KEY,
    descricao          VARCHAR(45)
);

CREATE TABLE especialidade (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45)
);

CREATE TABLE area_atuacao (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nome    VARCHAR(45)
);


CREATE TABLE missao (
    id_missao          INT AUTO_INCREMENT PRIMARY KEY,
    nome               VARCHAR(45),
    orcamento_previsto DECIMAL(12,2),
    id_pais            INT,
    id_situacao_missao INT,
    CONSTRAINT fk_missao_pais FOREIGN KEY (id_pais)
        REFERENCES pais (id_pais),
    CONSTRAINT fk_missao_situacao FOREIGN KEY (id_situacao_missao)
        REFERENCES situacao_missao (id_situacao_missao)
);


CREATE TABLE profissional (
    id_profissional  INT AUTO_INCREMENT PRIMARY KEY,
    nome             VARCHAR(45),
    custo_hora       DECIMAL(8,2),
    id_especialidade INT,
    id_coordenador   INT,
    CONSTRAINT fk_prof_especialidade FOREIGN KEY (id_especialidade)
        REFERENCES especialidade (id_especialidade),
    CONSTRAINT fk_prof_coordenador FOREIGN KEY (id_coordenador)
        REFERENCES profissional (id_profissional)
);


CREATE TABLE organizacao (
    id_organizacao INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(45),
    id_pais        INT,
    CONSTRAINT fk_org_pais FOREIGN KEY (id_pais)
        REFERENCES pais (id_pais)
);

-- Tabela associativa profissional x missão (N:N)
CREATE TABLE participacao (
    id_missao         INT,
    id_profissional   INT,
    horas_trabalhadas INT,
    nota_desempenho   DECIMAL(4,2),
    PRIMARY KEY (id_missao, id_profissional),
    CONSTRAINT chk_nota_desempenho CHECK (nota_desempenho BETWEEN 0 AND 10),
    CONSTRAINT fk_part_missao FOREIGN KEY (id_missao)
        REFERENCES missao (id_missao),
    CONSTRAINT fk_part_profissional FOREIGN KEY (id_profissional)
        REFERENCES profissional (id_profissional)
);

-- Tabela associativa organização x missão (N:N)
CREATE TABLE financiamento (
    id_organizacao    INT,
    id_missao         INT,
    valor_repassado   DECIMAL(12,2),
    data_contribuicao DATE,
    PRIMARY KEY (id_organizacao, id_missao),
    CONSTRAINT fk_fin_organizacao FOREIGN KEY (id_organizacao)
        REFERENCES organizacao (id_organizacao),
    CONSTRAINT fk_fin_missao FOREIGN KEY (id_missao)
        REFERENCES missao (id_missao)
);

-- Tabela associativa missão x área (N:N)
CREATE TABLE missao_area (
    id_missao INT,
    id_area   INT,
    PRIMARY KEY (id_missao, id_area),
    CONSTRAINT fk_ma_missao FOREIGN KEY (id_missao)
        REFERENCES missao (id_missao),
    CONSTRAINT fk_ma_area FOREIGN KEY (id_area)
        REFERENCES area_atuacao (id_area)
);

INSERT INTO pais (nome) VALUES
('Haiti'),
('Quênia'),
('Peru'),
('Líbano'),
('Moçambique'),
('Itália'),
('Espanha'),
('Suíça');

INSERT INTO situacao_missao (descricao) VALUES
('Planejada'),
('Em andamento'),
('Concluída');

INSERT INTO especialidade (nome) VALUES
('Médico'),
('Engenharia'),
('Educação'),
('Logística');

INSERT INTO area_atuacao (nome) VALUES
('Saúde'),
('Educação'),
('Infraestrutura'),
('Alimentação'),
('Saneamento');


INSERT INTO missao (nome, orcamento_previsto, id_pais, id_situacao_missao) VALUES
('Água para Todos',             120000.00, 2, 3),
('Clínicas Móveis',             200000.00, 1, 3),
('Escolas Rurais',               90000.00, 3, 3),
('Reconstrução Pós-Terremoto',  300000.00, 1, 2),
('Segurança Alimentar',         150000.00, 5, 2),
('Apoio a Refugiados',          180000.00, 4, 2),
('Hospital de Campanha',        250000.00, 3, 1),
('Educação Digital',             70000.00, 2, 1);


INSERT INTO profissional (nome, custo_hora, id_especialidade, id_coordenador) VALUES
('Alejandro Moretti',   100.00, 1, NULL),
('Valentina Ricci',      90.00, 2, NULL),
('Javier Sánchez',       80.00, 1, 1),
('Gabriela Conti',       70.00, 3, 1),
('Mateo Fernández',      60.00, 4, 1),
('Camila Greco',         85.00, 2, 2),
('Andrés Navarro',       75.00, 3, 2),
('Lucía Bianchi',        65.00, 4, 3),
('Sebastián Ortega',     95.00, 1, 2),
('Paola Esposito',       55.00, 3, NULL),
('Diego Salvatore',      78.00, 2, NULL),
('Isabel Moreno',        68.00, 4, 1);

INSERT INTO organizacao (nome, id_pais) VALUES
('Fundación Esperanza', 7),
('Aiuto Globale',       6),
('Cruz Solidaria',      8),
('Banco Andino',        3),
('Fondazione Luce',     6),
('Ayuda Mundial',       7);

INSERT INTO participacao (id_missao, id_profissional, horas_trabalhadas, nota_desempenho) VALUES
(1, 3,  60, 8.50),
(1, 4,  50, 9.00),
(1, 6,  80, 7.50),
(2, 1,  70, 9.50),
(2, 3,  90, 8.00),
(2, 9,  60, 7.00),
(2, 5,  40, 6.50),
(3, 4, 100, 9.00),
(3, 7,  80, 8.50),
(3, 12, 50, 7.50),
(4, 2, 120, 8.00),
(4, 6, 100, 8.50),
(4, 5,  80, 7.00),
(4, 1,  50, 9.00),
(4, 12, 60, 6.00),
(5, 5,  90, 8.00),
(5, 12, 70, 7.50),
(5, 7,  40, 9.00),
(6, 2,  80, 7.50),
(6, 9,  60, 8.00),
(6, 3,  50, 6.50);

INSERT INTO financiamento (id_organizacao, id_missao, valor_repassado, data_contribuicao) VALUES
(1, 1, 40000.00, '2025-02-10'),
(2, 1, 50000.00, '2025-02-20'),
(3, 1, 30000.00, '2025-03-01'),
(1, 2, 80000.00, '2025-04-05'),
(2, 2, 70000.00, '2025-04-12'),
(4, 2, 60000.00, '2025-04-20'),
(4, 3, 30000.00, '2025-06-01'),
(5, 3, 40000.00, '2025-06-10'),
(1, 4, 90000.00, '2026-01-15'),
(3, 4, 70000.00, '2026-01-20'),
(5, 4, 60000.00, '2026-02-01'),
(2, 4, 50000.00, '2026-02-10'),
(2, 5, 60000.00, '2026-02-15'),
(6, 5, 40000.00, '2026-02-20'),
(3, 6, 10000.00, '2026-03-01'),
(6, 7, 30000.00, '2026-04-01');

INSERT INTO missao_area (id_missao, id_area) VALUES
(1, 5), (1, 1),
(2, 1),
(3, 2), (3, 3),
(4, 3), (4, 5), (4, 1),
(5, 4), (5, 5),
(6, 1), (6, 2), (6, 4),
(7, 1), (7, 3),
(8, 2);


SELECT p.nome AS profissional,
       e.nome AS especialidade,
       c.nome AS coordenador,
       COUNT(pc.id_missao)               AS qtd_missoes_concluidas,
       ROUND(AVG(pc.nota_desempenho), 2) AS media_desempenho
FROM profissional p
INNER JOIN especialidade e ON e.id_especialidade = p.id_especialidade
LEFT JOIN profissional c   ON c.id_profissional  = p.id_coordenador
LEFT JOIN (
    SELECT pa.id_profissional,
           pa.id_missao,
           pa.nota_desempenho
    FROM participacao pa
    INNER JOIN missao m           ON m.id_missao           = pa.id_missao
    INNER JOIN situacao_missao s  ON s.id_situacao_missao  = m.id_situacao_missao
    WHERE s.descricao = 'Concluída'
) AS pc ON pc.id_profissional = p.id_profissional
GROUP BY p.id_profissional, p.nome, e.nome, c.nome
ORDER BY p.id_profissional;


SELECT a.nome AS area,
       COUNT(DISTINCT mc.id_missao)          AS qtd_missoes_concluidas,
       COUNT(DISTINCT pa.id_profissional)    AS qtd_profissionais,
       IFNULL(SUM(pa.horas_trabalhadas), 0)  AS total_horas
	FROM area_atuacao a
	LEFT JOIN missao_area ma ON ma.id_area = a.id_area
	LEFT JOIN (
		SELECT m.id_missao
		FROM missao m
		INNER JOIN situacao_missao s ON s.id_situacao_missao = m.id_situacao_missao
		WHERE s.descricao = 'Concluída'
	) AS mc ON mc.id_missao = ma.id_missao
		LEFT JOIN participacao pa ON pa.id_missao = mc.id_missao
			GROUP BY a.id_area, a.nome;



SELECT t.organizacao,
       t.qtd_missoes,
       t.total_repassado,
       t.maior_contribuicao,
       t.media_contribuicao
	FROM (
		SELECT o.nome AS organizacao,
			   COUNT(DISTINCT f.id_missao)    AS qtd_missoes,
			   SUM(f.valor_repassado)         AS total_repassado,
			   MAX(f.valor_repassado)         AS maior_contribuicao,
			   ROUND(AVG(f.valor_repassado), 2) AS media_contribuicao
		FROM organizacao o
		INNER JOIN financiamento f ON f.id_organizacao = o.id_organizacao
		GROUP BY o.id_organizacao, o.nome
	) 	AS t
		WHERE t.qtd_missoes >= 3;
        
        
SELECT m.nome AS missao,
       IFNULL(pf.qtd_profissionais, 0) AS qtd_profissionais,
       IFNULL(pf.total_horas, 0)       AS total_horas,
       IFNULL(pf.custo_pessoal, 0)     AS custo_pessoal,
       IFNULL(fn.qtd_organizacoes, 0)  AS qtd_organizacoes,
       IFNULL(fn.total_recebido, 0)    AS total_recebido,
       IFNULL(fn.total_recebido, 0) - IFNULL(pf.custo_pessoal, 0) AS diferenca
	FROM missao m
	LEFT JOIN (
		SELECT pa.id_missao,
			   COUNT(pa.id_profissional)                AS qtd_profissionais,
			   SUM(pa.horas_trabalhadas)                AS total_horas,
			   SUM(pa.horas_trabalhadas * p.custo_hora) AS custo_pessoal
		FROM participacao pa
		INNER JOIN profissional p ON p.id_profissional = pa.id_profissional
		GROUP BY pa.id_missao
	) AS pf ON pf.id_missao = m.id_missao
	LEFT JOIN (
		SELECT id_missao,
			   COUNT(id_organizacao) AS qtd_organizacoes,
			   SUM(valor_repassado)  AS total_recebido
		FROM financiamento
		GROUP BY id_missao
	) AS fn ON fn.id_missao = m.id_missao
		ORDER BY m.id_missao;



SELECT c.nome AS coordenador,
       COUNT(DISTINCT s.id_profissional)                         AS qtd_coordenados,
       COUNT(DISTINCT pa.id_missao)                              AS qtd_missoes,
       IFNULL(SUM(pa.horas_trabalhadas * s.custo_hora), 0)       AS custo_total,
       ROUND(AVG(pa.nota_desempenho), 2)                         AS media_desempenho
	FROM profissional c
	INNER JOIN profissional s ON s.id_coordenador   = c.id_profissional
	LEFT JOIN participacao pa ON pa.id_profissional = s.id_profissional
		GROUP BY c.id_profissional, c.nome;
        


SELECT m.nome AS missao,
       pa.nome AS pais,
       sm.descricao AS situacao,
       IFNULL(ar.qtd_areas, 0)          AS qtd_areas,
       IFNULL(pf.qtd_profissionais, 0)  AS qtd_profissionais,
       IFNULL(fn.qtd_organizacoes, 0)   AS qtd_organizacoes,
       IFNULL(pf.total_horas, 0)        AS total_horas,
       IFNULL(pf.custo_pessoal, 0)      AS custo_pessoal,
       IFNULL(fn.total_recebido, 0)     AS total_recebido,
       ROUND(IFNULL(fn.total_recebido, 0) / m.orcamento_previsto * 100, 2) AS percentual_cobertura,
       ROUND(pf.media_notas, 2)         AS media_desempenho,
       CASE
           WHEN IFNULL(fn.total_recebido, 0) = 0
               THEN 'Sem financiamento'
           WHEN fn.total_recebido < IFNULL(pf.custo_pessoal, 0)
               THEN 'Financiamento insuficiente'
           ELSE 'Financiamento suficiente'
       END AS classificacao_financeira
	FROM missao m
	INNER JOIN pais pa             ON pa.id_pais             = m.id_pais
	INNER JOIN situacao_missao sm  ON sm.id_situacao_missao  = m.id_situacao_missao
	LEFT JOIN (
		SELECT id_missao,
			   COUNT(id_area) AS qtd_areas
		FROM missao_area
		GROUP BY id_missao
	) AS ar ON ar.id_missao = m.id_missao
	LEFT JOIN (
		SELECT p.id_missao,
			   COUNT(p.id_profissional)                  AS qtd_profissionais,
			   SUM(p.horas_trabalhadas)                  AS total_horas,
			   SUM(p.horas_trabalhadas * pr.custo_hora)  AS custo_pessoal,
			   AVG(p.nota_desempenho)                    AS media_notas
		FROM participacao p
		INNER JOIN profissional pr ON pr.id_profissional = p.id_profissional
		GROUP BY p.id_missao
	) AS pf ON pf.id_missao = m.id_missao
	LEFT JOIN (
		SELECT id_missao,
			   COUNT(id_organizacao) AS qtd_organizacoes,
			   SUM(valor_repassado)  AS total_recebido
		FROM financiamento
		GROUP BY id_missao
	) AS fn ON fn.id_missao = m.id_missao
		ORDER BY m.id_missao;
