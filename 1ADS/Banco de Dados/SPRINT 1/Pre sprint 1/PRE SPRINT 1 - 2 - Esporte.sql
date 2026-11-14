CREATE DATABASE olimpiadas;

CREATE TABLE esporte (
id INT PRIMARY KEY auto_increment,
nome VARCHAR(40),
categoria VARCHAR(20),
CONSTRAINT chkcat CHECK (categoria IN ('individual', 'coletivo')),
estreia date,
paisorigem VARCHAR(30)
) auto_increment = 1 ;

INSERT INTO esporte VALUES 
(default, 'volei', 'coletivo', '1964-01-01', 'EUA'),
(default, 'tenis', 'individual', '1896-01-01', 'Inglaterra') , 
(default, 'hockey', 'coletivo', '1908-01-01', 'Inglaterra'),
(default, 'rugby', 'coletivo', '1900-01-01', 'Inglaterra'),
(default, 'natação', 'individual', '1896-01-01', 'Inglaterra');

ALTER TABLE esporte ADD COLUMN popularidade INT;

ALTER TABLE esporte ADD CONSTRAINT chkpop CHECK (popularidade >= 0 AND popularidade <= 10);

UPDATE esporte SET popularidade = 8
	WHERE id = 1;
    
UPDATE esporte SET popularidade = 10
	WHERE id = 2;    

UPDATE esporte SET popularidade = 7
	WHERE id = 3;
    
UPDATE esporte SET popularidade = 8
	WHERE id = 4;
    
UPDATE esporte SET popularidade = 8
	WHERE id = 5;    
    
SELECT * FROM esporte ORDER BY popularidade;

UPDATE esporte SET estreia = '1986-04-06'
WHERE id = 2;

UPDATE esporte SET estreia = '1986-04-06'
WHERE id = 5;

ALTER TABLE esporte ADD CONSTRAINT chkestreia CHECK (estreia >= '1896-04-06');

ALTER TABLE esporte DROP CONSTRAINT chkcat;

DESCRIBE esporte;

ALTER TABLE esporte ADD COLUMN numjogadores INT;

UPDATE esporte SET numjogadores = 7
	WHERE id = 1;    

UPDATE esporte SET numjogadores = 1
	WHERE id = 2;
    
UPDATE esporte SET numjogadores = 11
	WHERE id = 3;
    
UPDATE esporte SET numjogadores = 15
	WHERE id = 4;
    
UPDATE esporte SET numjogadores = 1
	WHERE id = 5;
    
SELECT * FROM esporte 
WHERE numjogadores >= 4 AND numjogadores <= 11;

DELETE FROM esporte WHERE id = 1;

DELETE FROM esporte WHERE id = 3;

DELETE FROM esporte WHERE id = 5;