CREATE DATABASE desenho;

CREATE TABLE desenhoanimado(
id INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR(50),
datalan DATE,
nomeemissora VARCHAR(50),
classificacao VARCHAR(2),
statuss VARCHAR(15),
nota INT,
CONSTRAINT chknota CHECK (nota >= 1 AND nota <= 5)
) auto_increment = 10 ;

SELECT * FROM desenhoanimado ; 

INSERT INTO desenhoanimado VALUES
(default, 'Ben 10', '2005-12-27', 'Cartoon Network', 'L', 'finalizado', 4),
(default, 'As Trapalhadas de Flapjack', '2008-06-05', 'Cartoon Network', '10', 'finalizado', 3),
(default, 'O Espetacular Homem-Aranha', '2008-03-08', 'Cartoon Network', '10' , 'cancelado', 5),
(default, 'Kick Buttowski', '2010-02-13', 'Disney XD', 'L', 'finalizado', 4),
(default, 'Batman Cruzado Encapuzado', '2024-08-01', 'Prime Video', '12', 'exibindo', 4);

SELECT * FROM desenhoanimado;

SELECT * FROM desenhoanimado
	WHERE classificacao <= 14;
    
SELECT * FROM desenhoanimado
	WHERE nomeemissora = 'Cartoon Network';

ALTER TABLE desenhoanimado ADD CONSTRAINT chkstat CHECK (statuss IN ('finalizado', 'exibindo', 'cancelado'));

UPDATE desenhoanimado set statuss = 'finalizado'
WHERE id = 12;

UPDATE desenhoanimado set statuss = 'finalizado'
WHERE id = 14;

DELETE FROM desenhoanimado WHERE id = 12;

SELECT * FROM desenhoanimado 
WHERE titulo LIKE 'B%';

ALTER TABLE desenhoanimado RENAME COLUMN classificacao to classificacaoIndicativa;

UPDATE desenhoanimado set datalan = '2008-11-07'
WHERE id = 11;

UPDATE desenhoanimado set nota = 3
WHERE id = 11;

TRUNCATE TABLE desenhoanimado;

ALTER TABLE desenhoanimado DROP CONSTRAINT chkstat;



    




