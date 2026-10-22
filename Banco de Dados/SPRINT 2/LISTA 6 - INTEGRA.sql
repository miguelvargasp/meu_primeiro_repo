USE sprint2;
CREATE TABLE animal(
id INT PRIMARY KEY,
nome VARCHAR(45),
especie VARCHAR(45),
raca VARCHAR(45),
idade VARCHAR(2)
);


CREATE TABLE ficha_medica(
id INT PRIMARY KEY,
data_ultima_consulta DATE,
peso DECIMAL(5,2),
vacina_em_dia CHAR(1),
observacao VARCHAR(100),
fkanimal INT,
CONSTRAINT fkfichaanimal FOREIGN KEY (fkanimal) REFERENCES animal(id)
);

INSERT INTO animal VALUES
	(1, 'Lola', 'gato', 'sirmanês', '2'),
	(2, 'Mickey', 'cão', 'Husky', '6'),
	(3, 'Pipo', 'gato', 'SRD', '4'),
	(4, 'Tata', 'gato', 'SRD', '1'),
	(5, 'Toto', 'cão', 'Husky', '8');
    
INSERT INTO  ficha_medica VALUES
	(1, '2026-08-12', 3, 'S', 'normal', 1),
	(2, '2026-08-21', 7, 'S', 'normal', 2),
	(3, '2026-08-25', 4, 'S', 'normal', 3),
	(4, '2026-08-27', 3, 'N', 'estável', 4);
    
    SELECT * FROM animal;
    
    SELECT * FROM ficha_medica;
    
    SELECT nome, especie FROM animal;
    
    SELECT * FROM ficha_medica WHERE vacina_em_dia = 'N';
    
    SELECT * FROM animal WHERE especie = 'cão';
    
    SELECT nome AS Pet,
		especie AS Tipo
		FROM animal;
        
	SELECT peso AS Peso_kg,
		data_ultima_consulta AS Última_Consulta
        FROM ficha_medica;
        
	SELECT nome, especie, idade * 7 AS 'Idade Humana Aproximada' FROM animal;
    
    SELECT nome AS 'Nome do Pet',
		raca AS 'Raca/Tipo' FROM animal;
        
	SELECT nome,
    CASE
        WHEN idade < 2 THEN 'Filhote'
        WHEN idade BETWEEN 2 AND 7 THEN 'ADULTO'
        ELSE 'Idoso'
        END AS fase_vida
		FROM animal;
        
SELECT a.nome,
    CASE
        WHEN f.vacina_em_dia = 'S' THEN 'Vacinado'
        ELSE 'Pendente'
		END AS vacinacao
		FROM animal AS a
		JOIN ficha_medica AS f ON a.id = f.fkanimal;

SELECT peso,
    CASE
        WHEN peso < 5 THEN 'Pequeno'
        WHEN peso BETWEEN 5 AND 20 THEN 'Médio'
        ELSE 'Grande'
		END AS porte
FROM ficha_medica;

SELECT nome,
	CASE 
		WHEN especie = 'cão' THEN 'Canino'
		WHEN especie = 'gato' THEN 'Felino'
        ELSE 'Outro'
        END AS especie_tipo
        FROM animal;
        
SELECT a.nome ,
	IFNULL(f.observacao, 'Nenhuma observação') AS observacao
    FROM animal AS a 
    JOIN ficha_medica AS f ON a.id = f.fkanimal;
    
SELECT a.nome,
    IFNULL(f.data_ultima_consulta, 'SEM FICHA') AS data_ultima_consulta
FROM animal AS a
LEFT JOIN ficha_medica AS f ON a.id = f.fkanimal;

SELECT a.nome, f.peso, f.data_ultima_consulta
FROM animal AS a
INNER JOIN ficha_medica AS f ON a.id = f.fkanimal;

SELECT CONCAT(a.nome, ' - ', a.especie, ' - ', f.peso, ' kg') AS Resumo
FROM animal AS a
INNER JOIN ficha_medica AS f ON a.id = f.fkanimal;

SELECT nome,
	IFNULL(raca, 'Raca não informada ') AS raça
    FROM animal;

		
-- ######################### EXERCICIO 2

CREATE TABLE farmacia1 (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE
);

CREATE TABLE endereco1(
    id INT PRIMARY KEY,
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(60) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    fk_farmacia INT NOT NULL UNIQUE,
    CONSTRAINT fk_endereco_farmacia FOREIGN KEY (fk_farmacia) REFERENCES farmacia1(id)
);

CREATE TABLE farmaceutico1 (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crf VARCHAR(20) NOT NULL,
    turno VARCHAR(10) NOT NULL CHECK (turno IN ('Manhã', 'Tarde', 'Noite')),
    fk_farmacia INT NOT NULL,
    CONSTRAINT fk_farmaceutico_farmacia FOREIGN KEY (fk_farmacia) REFERENCES farmacia1(id)
);

INSERT INTO farmacia1 (id, nome, cnpj) VALUES
(1, 'Farmácia Popular', '11.111.111/0001-11'),
(2, 'Drogaria Saúde Total', '22.222.222/0001-22'),
(3, 'Farmácia Bem Estar', '33.333.333/0001-33');

INSERT INTO endereco1 (id, rua, numero, bairro, cidade, fk_farmacia) VALUES
(1, 'Rua das Flores', '100', 'Centro', 'São Paulo', 1),
(2, 'Avenida Brasil', '250', 'Jardim América', 'São Paulo', 2);

INSERT INTO farmaceutico1 (id, nome, crf, turno, fk_farmacia) VALUES
(1, 'Ana Sanchez', 'CRF-SP 12345', 'Manhã', 1),
(2, 'Bruno Zeballos', 'CRF-SP 23456', 'Tarde', 1),
(3, 'Carla Mendez', 'CRF-SP 34567', 'Noite', 2),
(4, 'Diego Alvarez', 'CRF-SP 45678', 'Manhã', 2),
(5, 'Elisa Costas', 'CRF-SP 56789', 'Tarde', 3);

SELECT * FROM farmacia1;

SELECT * FROM endereco1;

SELECT * FROM farmaceutico1;

SELECT nome, cnpj FROM farmacia1;

SELECT * FROM farmaceutico1 WHERE turno = 'Noite';

SELECT * FROM endereco1 ORDER BY cidade ASC;

SELECT nome, crf FROM farmaceutico1;

SELECT nome AS 'Estabelecimento', cnpj AS 'Documento'
FROM farmacia1;

SELECT nome AS 'Profissional', turno AS 'Horario de Trabalho'
FROM farmaceutico1;

SELECT rua AS 'Logradouro', numero AS 'Num.'
FROM endereco1;

SELECT CONCAT(rua, ', ', numero) AS 'Endereço Completo'
FROM endereco1;

SELECT nome,
    CASE
        WHEN turno = 'Manhã' THEN '06h-12h'
        WHEN turno = 'Tarde' THEN '12h-18h'
        ELSE '18h-00h'
		END AS periodo
		FROM farmaceutico1;

SELECT nome,
    CASE
        WHEN cnpj LIKE '1%' THEN 'Matriz'
        ELSE 'Filial'
		END AS tipo_cnpj
		FROM farmacia1;

SELECT bairro,
    CASE
        WHEN bairro = 'Centro' THEN 'Zona Central'
        WHEN bairro = 'Jardim América' THEN 'Zona Oeste'
        ELSE 'Outra'
		END AS zona
		FROM endereco1;

SELECT nome,
    CASE
        WHEN turno = 'Noite' THEN 'Adicional Noturno'
        ELSE 'Normal'
		END AS carga_horaria
		FROM farmaceutico1;

SELECT f.nome,
    IFNULL(e.rua, 'SEM ENDERECO') AS rua
FROM farmacia1 AS f
LEFT JOIN endereco1 AS e ON f.id = e.fk_farmacia;

SELECT fm.nome, fm.crf, f.nome AS nome_farmacia
FROM farmaceutico1 AS fm
INNER JOIN farmacia1 AS f ON fm.fk_farmacia = f.id;

SELECT f.nome AS nome_farmacia, e.cidade AS nome_cidade, fm.nome AS nome_farmaceutico
FROM farmacia1 AS f
JOIN endereco1 AS e ON f.id = e.fk_farmacia
JOIN farmaceutico1 AS fm ON f.id = fm.fk_farmacia;

SELECT CONCAT(fm.nome, ' - ', fm.crf, ' - ', f.nome) AS info
FROM farmaceutico1 AS fm
INNER JOIN farmacia1 AS f ON fm.fk_farmacia = f.id;

SELECT id, bairro,
    IFNULL(bairro, 'Bairro não informado') AS bairro
	FROM endereco1;
    
-- ##################### EXERCICIO 3;    

CREATE TABLE artista (
    id INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    genero_musical VARCHAR(45),
    pais VARCHAR(45),
    ativo CHAR(1)
);

CREATE TABLE musica1 (
    id INT PRIMARY KEY,
    titulo VARCHAR(45) NOT NULL,
    duracao_segundos INT,
    ano_lancamento INT,
    fk_artista INT,
    CONSTRAINT fk_musica_artista FOREIGN KEY (fk_artista) REFERENCES artista(id)
);


INSERT INTO artista (id, nome, genero_musical, pais, ativo) VALUES
(1, 'Ne-Yo', 'R&B', 'EUA', 'S'),
(2, 'The Beatles', 'Rock', NULL, 'N'),
(3, 'Michael Jackson', 'Pop', 'EUA', 'N');

INSERT INTO musica1 (id, titulo, duracao_segundos, ano_lancamento, fk_artista) VALUES
(1, 'Miss Independent', 232, 2006, 1),
(2, 'Hey Jude', 431, 1968, 2),
(3, 'Let It Be', 243, 1970, 2),
(4, 'Beat It', 258, 1982, 3),
(5, 'Faixa Desconhecida', 180, 2023, NULL);

SELECT * FROM artista;
SELECT * FROM musica1;

SELECT titulo, duracao_segundos FROM musica1;

SELECT * FROM musica1
	WHERE ano_lancamento > 2020;
    
SELECT * FROM musica1 ORDER BY titulo ASC;

SELECT * FROM musica1
	WHERE duracao_segundos > 200;
    
SELECT titulo AS 'Nome da Musica',
	ano_lancamento AS 'Ano'
    FROM musica1;
    
SELECT nome AS 'Cantor/Banda',
	genero_musical AS Estilo
    FROM artista;
    
SELECT duracao_segundos/60 AS 'Duração(min)' FROM musica1;

SELECT titulo as 'Faixa',
	ano_lancamento AS 'Lancamento'
    FROM musica1;
    
SELECT titulo,
    CASE
        WHEN ano_lancamento < 2000 THEN 'Clássico'
        WHEN ano_lancamento BETWEEN 2000 AND 2015 THEN 'Moderno'
        ELSE 'Atual'
		END AS era
		FROM musica1;

SELECT nome,
    CASE
        WHEN ativo = 'S' THEN 'Em atividade'
        ELSE 'Inativo'
		END AS 'status'
		FROM artista;

SELECT titulo,
    CASE
        WHEN duracao_segundos < 180 THEN 'Curta'
        WHEN duracao_segundos BETWEEN 180 AND 300 THEN 'Normal'
        ELSE 'Longa'
		END AS 'tamanho'
		FROM musica1;

SELECT nome,
	CASE
		WHEN pais = 'Brasil' THEN 'Nacional'
        ELSE 'Internacional'
		END AS 'origem'
		FROM artista;

SELECT nome,
    IFNULL(pais, 'Pais desconhecido') AS pais
	FROM artista;

SELECT m.titulo,
    IFNULL(a.nome, 'ARTISTA DESCONHECIDO') AS nome_artista
	FROM musica1 AS m
	LEFT JOIN artista AS a ON m.fk_artista = a.id;

SELECT m.titulo, m.ano_lancamento, a.nome AS nome_artista
	FROM musica1 AS m
	INNER JOIN artista AS a ON m.fk_artista = a.id;

SELECT CONCAT(m.titulo, ' - ', a.nome, ' - ',  m.ano_lancamento) AS catalogo
	FROM musica1 AS m
	INNER JOIN artista AS a ON a.id = m.fk_artista;
    
SELECT a.nome AS nome_artista, m.titulo
	FROM musica1 AS m
	RIGHT JOIN artista AS a ON m.fk_artista = a.id;
	
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICIO 4 

CREATE TABLE cliente (
    id INT PRIMARY KEY,
    nome VARCHAR(45),
    telefone VARCHAR(45),
    email VARCHAR(45)
);

CREATE TABLE veiculo (
    id INT PRIMARY KEY,
    placa VARCHAR(10),
    marca VARCHAR(50),
    modelo VARCHAR(50),
    ano INT,
    fk_cliente INT,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (fk_cliente) REFERENCES cliente(id)
);

INSERT INTO cliente (id, nome, telefone, email) VALUES
(1, 'Marcos Costa', '(11) 91234-5678', 'marcos@email.com'),
(2, 'Juliana Perez', '(11) 99876-5432', NULL),
(3, 'Rafael Fernandez', '(21) 98765-4321', 'rafael@email.com');

INSERT INTO veiculo (id, placa, marca, modelo, ano, fk_cliente) VALUES
(1, 'ABC1D23', 'Fiat', 'Uno', 2012, 1),
(2, 'DEF4E56', 'Fiat', 'Palio', 2018, 2),
(3, 'GHI7F89', 'Chevrolet', 'Onix', 2021, 3),
(4, 'JKL0G12', 'Volkswagen', 'Gol', 2004, 1),
(5, 'MNO3H45', 'Ford', 'Ka', 2023, NULL);

SELECT * FROM cliente;

SELECT * FROM veiculo;

SELECT placa, marca, modelo from veiculo;

SELECT * FROM veiculo WHERE marca = 'Fiat';

SELECT * FROM veiculo ORDER BY ano DESC;

SELECT * FROM veiculo WHERE ano < 2015;

SELECT placa AS 'Placa do Veículo', modelo AS 'Modelo do Carro'
FROM veiculo;

SELECT nome AS 'Proprietario', telefone AS 'Contato'
FROM cliente;

SELECT ano, (YEAR(CURDATE()) - ano) AS 'Idade do Veículo'
FROM veiculo;

SELECT CONCAT(marca, ' ', modelo) as 'Veículo Completo'
FROM veiculo;

SELECT placa,
    CASE
        WHEN ano >= 2020 THEN 'Novo'
        WHEN ano BETWEEN 2010 AND 2019 THEN 'Seminovo'
        ELSE 'Antigo'
		END AS classificacao
		FROM veiculo;

SELECT modelo,
    CASE
        WHEN marca IN ('Fiat', 'Chevrolet', 'Volkswagen') THEN 'Nacional'
        ELSE 'Importado'
		END AS tipo_marca
		FROM veiculo;

SELECT nome,
    CASE
        WHEN email IS NOT NULL THEN 'Sim'
        ELSE 'Não'
		END AS possui_email
		FROM cliente;

SELECT placa,
    CASE
        WHEN ano BETWEEN 2000 AND 2009 THEN 'Anos 2000'
        WHEN ano BETWEEN 2010 AND 2019 THEN 'Anos 2010'
        ELSE 'Anos 2020'
		END AS decada
		FROM veiculo;

SELECT nome,
    IFNULL(email, 'Email não cadastrado') AS email
	FROM cliente;

SELECT v.placa,
	IFNULL(c.nome, 'SEM DONO') AS nome_cliente
	FROM veiculo AS v
	LEFT JOIN cliente AS c ON v.fk_cliente = c.id;

SELECT v.placa, v.modelo, c.nome AS nome_proprietario
FROM veiculo AS v
INNER JOIN cliente AS c ON v.fk_cliente = c.id;

SELECT CONCAT(v.placa, ' - ', v.modelo, ' - ', c.nome) AS registro
FROM veiculo AS v
INNER JOIN cliente AS c ON v.fk_cliente = c.id;

SELECT c.nome AS nome_cliente, v.placa
FROM veiculo AS v
RIGHT JOIN cliente AS c ON v.fk_cliente = c.id;

-- ############################# EXERCICIO 5
CREATE TABLE equipe (
    id INT PRIMARY KEY,
    nome VARCHAR(45),
    regiao VARCHAR(45) CHECK (regiao IN ('Americas', 'Europa', 'Asia')),
    ranking INT
);

CREATE TABLE jogador_cs (
    id INT PRIMARY KEY,
    nickname VARCHAR(45) NOT NULL,
    nome_real VARCHAR(45),
    funcao VARCHAR(45) NOT NULL CHECK (funcao IN ('Rifler', 'AWPer', 'Entry', 'IGL', 'Suporte')),
    fk_equipe INT,
    CONSTRAINT fk_jogador_equipe FOREIGN KEY (fk_equipe) REFERENCES equipe(id)
);

INSERT INTO equipe (id, nome, regiao, ranking) VALUES
(1, 'FURIA', 'Americas', 8),
(2, 'Vitality', 'Europa', 1),
(3, 'Dragons', 'Americas', NULL);

INSERT INTO jogador_cs (id, nickname, nome_real, funcao, fk_equipe) VALUES
(1, 'KSCERATO', 'Kaike Cerato', 'Rifler', 1),
(2, 'yuurih', 'Yuri Santos', 'Rifler', 1),
(3, 'ZywOo', 'Mathieu Herbaut', 'AWPer', 2),
(4, 'apEX', 'Dan Madesclaire', 'IGL', 2),
(5, 'FalleN', 'Gabriel Toledo', 'Suporte', NULL);

SELECT * FROM equipe;

SELECT * FROM jogador_cs;

SELECT nickname, funcao FROM jogador_cs;

SELECT * FROM jogador_cs WHERE funcao = 'AWPer';

SELECT * FROM equipe ORDER BY ranking ASC;

SELECT * FROM jogador_cs WHERE nickname LIKE 'f%';

SELECT nickname AS 'Nick', nome_real AS 'Nome Verdadeiro'
FROM jogador_cs;

SELECT nome AS 'Time', regiao AS 'Região Competitiva'
FROM equipe;

SELECT ranking AS 'Posição no Ranking Mundial'
FROM equipe;

SELECT CONCAT(nickname, ' - ', funcao) AS 'Jogador e Função'
FROM jogador_cs;

SELECT nome,
    CASE
        WHEN ranking <= 5 THEN 'Tier 1'
        WHEN ranking BETWEEN 6 AND 20 THEN 'Tier 2'
        ELSE 'Tier 3'
		END AS nivel
		FROM equipe;

SELECT nickname,
    CASE
        WHEN funcao IN ('Rifler', 'Entry') THEN 'Agressivo'
        WHEN funcao = 'AWPer' THEN 'Sniper'
        ELSE 'Tático'
		END AS tipo_funcao
		FROM jogador_cs;

SELECT nome,
    CASE
        WHEN regiao = 'Americas' THEN 'Ocidente'
        ELSE 'Oriente'
		END AS continente
		FROM equipe;

SELECT nickname,
    CASE
        WHEN funcao = 'IGL' THEN 'Sim - In-Game Leader'
        ELSE 'Não'
		END AS lider
		FROM jogador_cs;

SELECT nome,
    IFNULL(ranking, 'Sem ranking') AS ranking
	FROM equipe;
    
SELECT j.nickname,
    IFNULL(e.nome, 'FREE AGENT') AS nome_equipe
	FROM jogador_cs AS j
	LEFT JOIN equipe AS e ON j.fk_equipe = e.id;

SELECT j.nickname, j.funcao, e.nome AS nome_equipe
	FROM jogador_cs AS j
	INNER JOIN equipe AS e ON j.fk_equipe = e.id;
    
SELECT CONCAT(j.nickname, ' - ', j.funcao, ' - ', e.nome) AS perfil
	FROM jogador_cs AS j
	INNER JOIN equipe AS e ON j.fk_equipe = e.id;
    
SELECT e.nome AS nome_equipe, j.nickname
	FROM jogador_cs AS j
	RIGHT JOIN equipe AS e ON j.fk_equipe = e.id;

-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXERCICIO 6

CREATE TABLE marcat(	
id INT PRIMARY KEY,
nome VARCHAR(45),






