USE sprint2; -- EXEMPLO FAMILIA
CREATE TABLE pessoaf(
idPessoa int PRIMARY KEY auto_increment,
nome varchar(45), -- + sobrenome = atriubuto composto
sobrenome varchar(45),
datNascimento date, -- idade = atrobuto derivado
cep char(9), 
numEnd varchar(45),
copmlemento varchar(45), -- + cep + numEnd = atributo completo
emailPessoal varchar(45),
emailInstitucional varchar(45),
fkPai int,
 constraint fkFilhodoPai foreign key (fkPai)
	references pessoa(idPessoa),
fkMae int,
constraint fkFilhodaMae foreign key (fkMae)
	references pessoa(idPessoa)
    );

INSERT INTO pessoaf (nome, sobrenome, datNascimento, fkPai, fkMae) VALUES
		('Vivian', 'Silva', '1983-10-13', null, null),
		('Jadir Luiz', 'Silva', '1954-10-10', null, null),
		('Elisabete', 'Silva', '1957-05-05', null, null);
        
	SELECT * FROM pessoaf;
    
UPDATE pessoaf SET fkPai = 2, fkMae = 3
	WHERE idPessoa = 1;
    
SELECT filho.nome AS Filho,
	pai.nome AS Pai,
    mae.nome AS Mae
    FROM pessoaf AS filho LEFT JOIN pessoaf AS pai
		ON filho.fkPai = pai.idPessoa
    JOIN pessoaf AS mae
		ON filho.fkMae = mae.idPessoa;
        
INSERT INTO pessoaf (nome, sobrenome, datNascimento, fkPai, fkMae) VALUES
		('Elizabeth', 'Silva', null, null, null),
		('Orlando', 'Silva', null, null, null);

UPDATE pessoaf SET fkPai = 5, fkMae = 4
	WHERE idPessoa = 2;
    
SELECT filho.nome AS Filho,
	pai.nome AS Pai,
    mae.nome AS Mae,
    vozinho.nome AS Avô,
    vozinha.nome AS Avó
    FROM pessoaf AS filho 
	JOIN pessoaf AS pai
		ON filho.fkPai = pai.idPessoa 
    JOIN pessoaf AS mae
		ON filho.fkMae = mae.idPessoa
	JOIN pessoaf AS vozinho
		ON pai.fkPai = vozinho.idPessoa
	JOIN pessoaf AS vozinha
		ON pai.fkMae = vozinha.idPessoa;
        

        
SELECT DISTINCT sobrenome FROM pessoaf; -- Selecionar os sobrenomes diferentes
SELECT DISTINCT nome FROM pessoaf; -- Selecionar os nomes diferentes

SELECT nome FROM pessoaf LIMIT 3; -- Limitar linhas / ORDER BY para selecionar 3 ultimas ou 3 primeiras

SELECT timestampdiff(YEAR, datNascimento, now()) IDADE FROM pessoaf;




        
        