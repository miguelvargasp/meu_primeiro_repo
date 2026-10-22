USE sprint1;

CREATE TABLE Professor (
idProfessor INT PRIMARY KEY,
nome VARCHAR(50),
especialidade VARCHAR(40),
dtNasc DATE
);

INSERT INTO Professor VALUES
('1', 'Luís Fernández', 'Matematica', '1977-07-17'),
('2', 'María Nuñez', 'Historia', '1990-04-10'),
('3', 'Natalia Giardino', 'Matematica', '1985-05-27'),
('4', 'Pablo Passarella', 'Fisica', '1987-09-11'),
('5', 'Marianella Rinaldi', 'Historia', '1990-05-12'),
('6', 'Julieta Vasquez', 'Quimica', '1996-08-07');

SELECT * FROM Professor;

ALTER TABLE Professor ADD COLUMN funcao VARCHAR(50);

UPDATE Professor SET funcao = 'titular'
WHERE idProfessor = 1;
SELECT * FROM Professor;

UPDATE Professor SET funcao = 'titular'
WHERE idProfessor = 2;
SELECT * FROM Professor;

UPDATE Professor SET funcao = 'titular'
WHERE idProfessor = 3;
SELECT * FROM Professor;

UPDATE Professor SET funcao = 'titular'
WHERE idProfessor = 4;

UPDATE Professor SET funcao = 'assistente'
WHERE idProfessor = 5;
SELECT * FROM Professor;

UPDATE Professor SET funcao = 'monitor'
WHERE idProfessor = 6;
SELECT * FROM Professor;

INSERT INTO Professor VALUES 
('7', 'Melanie Martínez', 'Portugues', '2005-06-11', 'monitor');
SELECT * FROM Professor;

DELETE FROM Professor WHERE idProfessor = 5;		

SELECT * FROM Professor
WHERE funcao = 'titular';

SELECT * FROM Professor
WHERE funcao = 'monitor';

UPDATE Professor SET dtNasc = '2000-02-28'
WHERE idProfessor = 3;
SELECT * FROM Professor;

TRUNCATE TABLE Professor;
