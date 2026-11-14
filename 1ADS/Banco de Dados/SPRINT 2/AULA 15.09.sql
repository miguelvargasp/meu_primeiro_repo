-- SPRINT 1 - MODELAGEM DE DADOS
-- AULA 6 - MODELAGEM DE DADOS

CREATE DATABASE sprint2;
USE sprint2;

-- Criar a tabela responsável, pois ela não tem FK
CREATE TABLE responsavel(
idResponsavel INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
salario DECIMAL(10,2)
) AUTO_INCREMENT = 5000;

INSERT INTO responsavel VALUES
(default, 'Jow', 1.88),
(default, 'Jerry', 1.48),
(default, 'Jan', 1.98);

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
CNPJ CHAR(15) UNIQUE,
fkResponsavel INT NOT NULL UNIQUE, -- sempre tem que ser not null e unique
CONSTRAINT fkEmpresaResponsa 
	FOREIGN KEY(fkResponsavel)
		REFERENCES responsavel(idResponsavel)
);

INSERT INTO empresa VALUES
(default , 'C6 Bank', null, 5000),
(default , 'Safra', null, 5001),
(default , 'Stefanini', null, 5002);

-- NOSSO PRIMEIRO JOIN
-- Junção, ASSOCIAÇÃ
SELECT * FROM responsavel
	JOIN empresa ON fkResponsavel = idResponsavel; -- NÃO EXISTE JOIN SEM ON!!!!!!!!!!!!!!!!!!!!!!
    
SELECT responsavel.nome AS Responsa,
	empresa.nome as NomeEmpresa
    FROM empresa JOIN responsavel 
		ON idResponsavel= fkResponsavel;
        
-- OUTRO SELECT em aula (perdi)
        
CREATE TABLE aluno(
ra CHAR(8) primary key,
nome varchar(45),
bairro varchar(25),
fkEmpresa int not null
);

ALTER TABLE aluno ADD CONSTRAINT fkEmpresaAluno
	FOREIGN KEY (fkEmpresa)
    REFERENCES empresa(idEmpresa);
    
    
INSERT INTO aluno VALUES 
	('01262999', 'Jonas', 'Paraíso', 1),
	('01262998', 'Janaína', 'Perdizes', 1),
	('01262997', 'Jeremías', null, 2),
	('01262996', 'Januário', null, 3);
    
SELECT * FROM empresa	
    JOIN aluno ON fkEmpresa = idEmpresa;
    
    SELECT empresa.nome as Empresa, 
		aluno.nome as Aluno,
        responsavel.nome as Responsavel
        From empresa JOIN responsavel
			ON idResponsavel = fkResponsavel
            JOIN aluno 
            ON idEmpresa = fkEmpresa;      

SELECT responsavel.nome AS Responsa,
	empresa.nome as NomeEmpresa
    FROM empresa JOIN responsavel
		ON idResponsavel =  fkResponsavel
        WHERE empresa.nome = 'C6 Bank';
          