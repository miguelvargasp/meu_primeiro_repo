CREATE DATABASE game_store;

USE game_store;

CREATE TABLE jogo (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30),
diretor VARCHAR(30),
genero VARCHAR(30),
dataLaunch DATE,
nota DECIMAL,
qtd	INT,
CONSTRAINT chknota CHECK (nota BETWEEN 0 AND 10)
) AUTO_INCREMENT = 1;

INSERT INTO jogo VALUES
	(default, 'Grand Theft Auto', 'Rockstar', 'mundoaberto', '2013-07-13', 10, 13000000);
    
INSERT INTO jogo VALUES     
    (default, 'Super Mario Galaxy', 'Nintendo', 'aventura', '2007-11-01', 9, 6100000),
    (default, 'The Legend of Zelda', 'Nintendo','aventura', '1998-11-21', 10, 1300000),
	(default, 'Red Dead Redemption', 'Rockstar', 'aventura', '2018-10-26', 9, 17000000),
    (default, 'BioShock', '2K Games', 'FPS', '2007-08-21', 8, 1300000);
    
    SELECT * FROM jogo;

ALTER TABLE jogo ADD COLUMN tipomidia VARCHAR(7)
CONSTRAINT chkmidia CHECK (tipomidia IN ('fisica', 'digital'));

UPDATE jogo SET tipomidia = 'fisica'
WHERE id = 1; 

UPDATE jogo SET tipomidia = 'fisica'
WHERE id = 2; 

UPDATE jogo SET tipomidia = 'fisica'
WHERE id = 3; 

UPDATE jogo SET tipomidia = 'digital'
WHERE id = 4; 

UPDATE jogo SET tipomidia = 'fisica'
WHERE id = 5; 

SELECT * FROM jogo;

SELECT * FROM JOGO WHERE YEAR(datalaunch) > 2015;

SELECT * FROM jogo 
WHERE nome LIKE '%a%' AND tipomidia = 'fisica';

SELECT * FROM jogo 
WHERE not diretor LIKE '%e%';

ALTER TABLE jogo ADD CONSTRAINT chknotavalor CHECK (nota >= 0 AND nota <=10);

SELECT * FROM jogo
WHERE genero = 'aventura' AND qtd > 0;

DELETE FROM jogo WHERE qtd < 1;

ALTER TABLE jogo RENAME COLUMN diretor TO criador;
SELECT * FROM jogo;




       