USE sprint1;
CREATE TABLE ATLETA (
idAtleta INT PRIMARY KEY,
nome VARCHAR(40),
modalidade VARCHAR(40),
qtdMedalha INT
);

INSERT INTO atleta VALUES 
('1', 'Tomás', 'handebol', '3');

INSERT INTO atleta VALUES
('2', 'Sofía', 'handebol', '4'),
('3', 'Agustín', 'futebol', '4'),
('4', 'Milagros', 'hockey', '6'),
('5', 'Pilar', 'hockey', '3');

SELECT * FROM atleta;

UPDATE atleta SET qtdMedalha = '5'
WHERE idAtleta = 1;
SELECT *FROM atleta;

UPDATE atleta SET qtdMedalha = '3'
WHERE idAtleta = 2;

UPDATE atleta SET qtdMedalha = '2'
WHERE idAtleta = 3;
SELECT * FROM atleta;

UPDATE atleta SET nome = 'Valentina'
WHERE idAtleta = 4;
SELECT * FROM atleta;

ALTER TABLE atleta ADD COLUMN dtNasc DATE;

UPDATE atleta SET dtNasc = '2007-08-12'
WHERE idAtleta = 1;
SELECT * FROM atleta;

UPDATE atleta SET dtNasc = '2012-07-20'
WHERE idAtleta = 2;

UPDATE atleta SET dtNasc = '2009-10-15'
WHERE idAtleta = 3;

UPDATE atleta SET dtNasc = '2010-4-14'
WHERE idAtleta = 4;

UPDATE atleta SET dtNasc = '2011-06-06'
WHERE idAtleta = 5;
SELECT * FROM atleta;

DELETE FROM atleta WHERE id = 5 

