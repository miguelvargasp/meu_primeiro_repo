USE sprint1;

CREATE TABLE Revista (
idRevista INT PRIMARY KEY,
nome VARCHAR(40),
categoria VARCHAR(30)
) auto_increment = 1;

INSERT INTO Revista (nome) VALUES
('Veja'),
('Isto E'),
('Caras'),
('Capricho');
SELECT * FROM Revista;

UPDATE Revista set categoria = 'geral'
WHERE idRevista = 1;

UPDATE Revista set categoria = 'noticias'
WHERE idRevista = 2;

UPDATE Revista set categoria = 'fofoca'
WHERE idRevista = 3;

UPDATE Revista set categoria = 'infantojuvenil'
WHERE idRevista = 4;
SELECT * FROM Revista;

INSERT INTO Revista (nome, categoria) VALUES 
('Ole', 'esportes'),
('Forbes', 'economia'),
('Vogue', 'moda');
SELECT * FROM Revista;

DESCRIBE Revista;

ALTER TABLE Revista MODIFY COLUMN categoria VARCHAR(40);
DESCRIBE Revista;

ALTER TABLE Revista ADD COLUMN periodicidade VARCHAR(15);
SELECT * FROM Revista;

ALTER TABLE Revista DROP COLUMN periodicidade ;

SELECT * FROM Revista;


