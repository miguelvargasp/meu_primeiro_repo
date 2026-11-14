-- Isso é um comentário
/* 
Isso é um comentário
*/

-- Todo comando SQL é em inglês
-- Todo comando termina com ponto e vírgula (;) 

/*
Modelo da dados relacional são tabelas que se 
relacionam entre elas. Tabelas contem linhas e colunas
e cada linha tem cédulas com valores.
*/

-- SQL - Structure Query Language

-- CRIAR O BANCO DE DADOS 	
CREATE DATABASE sprint1;

-- SELECIONAR O BANCO DE DADOS
USE sprint1;

-- CRIAR A TABELA CHAMADA ALUNO	
CREATE TABLE aluno ( 
-- nomeDoCampo tipodoCampo
ra CHAR(8) PRIMARY KEY,     -- character
nome VARCHAR(20),
bairro VARCHAR(10),
falta INT
);

-- INT - NÚMERO INTEIRO


-- INSERIR OS DADOS
INSERT INTO aluno VALUES 
('01262019', 'Miguel', 'São SV',1);

-- INSERINDO MAIS DE UMA LINHA
INSERT INTO aluno VALUES
('01262998', 'Vivian', 'Sacomã', 1),
('01262997', 'Carlos', 'Sacomã', 1);

-- EXIBIR OS DADOS 
SELECT ra, nome, bairro, falta FROM aluno;
SELECT * FROM aluno;

-- EXIBIR APENAS O NOME DO ALUNO
SELECT nome FROM aluno;

-- EXIBIR OS ALUNOS O BAIRRO É SACOMÃ
SELECT nome FROM aluno
WHERE bairro = 'Sacomã';

-- EXIBIR OS ALUNOS ONDE O BAIRRO É DIFERENTE SACOMÃ
SELECT nome FROM aluno
WHERE bairro != 'Sacomã';

-- EXIBIR OS ALUNOS ONDE O BAIRRO COMEÇA COM A LETRA S 
SELECT * FROM aluno 
WHERE bairro LIKE 's%';

-- EXIBIR OS ALUNOS ONDE O BAIRRO TERMINA COM A LETRA A 
SELECT * FROM aluno
WHERE bairro LIKE '%a';

-- EXIBIR OS ALUNOS ONDE O BAIRRO CONTEM A LETRA O 
SELECT * FROM aluno 
WHERE bairro LIKE '%o%';

-- EXIBIR O BAIRRO EM ORDEM ALFABETICA
SELECT * FROM aluno 
WHERE bairro LIKE '%a%' ORDER BY bairro;

-- EXIBIR EM ORDEM CRESCENTE 

   


