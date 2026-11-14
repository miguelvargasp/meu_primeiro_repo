USE sprint1;

CREATE TABLE cadastro( 
id int primary key auto_increment,
nome varchar(50) not null, 
cpf char(11),
dtNasc date, 
alturan float,
salario decimal(10,2),
email varchar(60),
CONSTRAINT chkEmail check(email like'%@%')
) auto_increment = 2000;

INSERT INTO cadastro (nome, dtNasc, salario, email) VALUES
('Rick', '2000-01-01', 3000.99, 'rick@email.com'),
('Rock', '2002-01-01', 600.99, 'rock@email.com');

ALTER TABLE cadastro MODIFY COLUMN cpf char(11) unique,   -- É possível fazer várias alterações colocando virgula
	MODIFY COLUMN email varchar(60) not null;
    
DESCRIBE cadastro;

ALTER TABLE cadastro ADD CONSTRAINT chkSalario 
CHECK (salario >= 0);

ALTER TABLE cadastro ADD COLUMN dtCadastro DATETIME DEFAULT current_timestamp;

-- CURDATE () APENAS A DATA E A HORA FICA 00:00:00
UPDATE cadastro SET dtCadastro = curdate() 
WHERE id >= 2000;

-- NOW() DATA e HORA ATUALIZA
UPDATE cadastro SET dtCadastro = now() 
WHERE id >= 2000;

SELECT * FROM cadastro;

SELECT ifnull(cpf, 'Estrangeiro') as CPF,
	concat('Nome é ' , nome) as NOME,
    case
		WHEN salario > 1000 THEN 'TOP'
        ELSE 'Não top'
        END as SALARIO
        FROM cadastro;

SELECT concat('Cadastro realizado!', nome , ' tem o cpf ',  
      ifnull(cpf, 'Sem cpf'), ' e o salário é ',
      CASE
      WHEN salario > 1000 THEN 'Ganha bem.'
      ELSE 'Ganha mais ou menos.'
      END) AS FRASE_COMPLETA FROM cadastro;
      
SELECT dtNasc, 
	timestampdiff(YEAR, dtNasc, now()) as IDADE FROM cadastro;
    
UPDATE cadastro SET cpf = '01234567890', alturan = 1.67, 
	salario = NULL WHERE id = 2000; -- PODE SER IS NULL
    
    SELECT cpf FROM cadastro WHERE cpf is null; -- SELECT não pode ser =, tem que ser IS NULL
    
ALTER TABLE cadastro ADD COLUMN statusCadastro TINYINT , 
	ADD CONSTRAINT chkStatusCadastro
		CHECK(statusCadastro IN (0,1));
        




