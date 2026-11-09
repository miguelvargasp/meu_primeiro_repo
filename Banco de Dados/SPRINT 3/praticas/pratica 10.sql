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