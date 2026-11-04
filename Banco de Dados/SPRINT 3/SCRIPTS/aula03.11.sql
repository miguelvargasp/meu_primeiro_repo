CREATE DATABASE sprint3;
USE sprint3;

CREATE TABLE curso(
idCurso int primary key auto_increment,
nome varchar(45),
tipo varchar(45),
constraint chkTipo check(tipo in('presencial', 'remoto')),
cargaHoraria int);

Insert into curso (nome,tipo) VALUES 
	('Inglês', 'Presencial'),
	('espanhol', 'Presencial');
    
SELECT * FROM curso;

CREATE TABLE aluno (
idAluno int primary key auto_increment,
nome VARCHAR(45),
email VARCHAR(45)
) auto_increment = 1000;

INSERT INTO aluno (nome) VALUES
	('Inácio'),
	('Idailto'),
	('Idalina');
    
-- RELACIONAMENTO N:N CRIA-SE A TABELA ASSOCIATIVA

CREATE TABLE matricula (
idMatricula int auto_increment,
fkCurso int,
constraint fkCursoMatricula foreign key (fkCurso)
	references curso(idCurso),
fkAluno int,
constraint fkAlunoMatricula foreign key (fkAluno)
	references aluno(idAluno),
constraint pkComposta primary key (idMatricula, fkCurso, fkAluno),
nota decimal(4,2)
);

INSERT INTO matricula VALUES 
	(default, 1, 1000, 6),
	(default, 2, 1001, 5),
	(default, 2, 1001, 6);
    
SELECT aluno.nome as NomeAluno, -- IMPLEMENTAR NO PROJETO 
	curso.nome as NomeCurso,
    nota, 
    CASE 
    WHEN nota >= 6 THEN 'Aprovado'
    ELSE 'Reprovado'
    END statuss
    FROM aluno JOIN matricula 
		ON fkAluno = idAluno
        JOIN curso
        ON fkCurso = IdCurso;
        

-- FUNÇÕES MATEMÁTICAS
-- MAX
SELECT MAX(nota) FROM matricula;

-- MIN()
SELECT MIN(nota) FROM matricula;

SELECT MAX(nota), MIN(nota) FROM matricula;

-- SUM()
SELECT SUM(nota) FROM matricula;

-- AVG()
SELECT AVG(nota) FROM matricula;

-- ROUND() >>>>>>>> NÂO É PARA UTILIZAR EM PREÇO
SELECT ROUND(AVG(nota),2) FROM matricula;

-- TRUNCATE()
SELECT TRUNCATE(AVG(nota),2) FROM matricula;

-- COUNT () - conta apenas campos com valor, se campo for nulo não conta
SELECT COUNT(nota) FROM matricula;

INSERT INTO matricula VALUES
	(default, 1, 1002, null);
    
SELECT * FROM matricula;

-- GROUP BY - FUNÇÃO DE AGReGAÇÃO 
SELECT AVG(nota), curso.nome FROM curso JOIN matricula
	ON idCurso = fkCurso
	GROUP BY curso.nome;

SELECT AVG(nota), aluno.nome FROM aluno JOIN matricula
	ON idAluno = fkAluno
	GROUP BY aluno.nome;
    
INSERT INTO matricula VALUES
	(default, 2, 1002, 9);

-- EXIBIR O ALUNO QUE TEM A MAIOR NOTA    
SELECT aluno.nome, nota FROM aluno JOIN matricula
	ON idAluno = fkAluno
    WHERE nota = (SELECT MAX(nota) FROM matricula);
    
-- EXIBIR O ALUNO QUE TEM A MAIOR MEDIA
SELECT aluno.nome, nota FROM aluno JOIN matricula
	ON idAluno = fkAluno
    WHERE nota = (SELECT AVG(nota) FROM matricula);







