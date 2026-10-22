USE sprint1;

CREATE TABLE Curso (
idCurso1 INT PRIMARY KEY,
nome VARCHAR(50),
sigla CHAR(3), 
coordenador VARCHAR(50)
);

INSERT INTO Curso VALUES
('1', 'Lideranca', 'lid', 'Pablo Paz'),
('2', 'Gestao', 'ges', 'Victoria Venegas'),
('3', 'Marketing', 'mkt', 'Delfina Delgado');

SELECT * FROM Curso;

SELECT coordenador FROM Curso;

SELECT * FROM Curso
WHERE sigla = 'mkt';

SELECT * FROM Curso ORDER BY nome DESC;

SELECT * FROM Curso
WHERE nome LIKE 'm%';

SELECT * FROM Curso
WHERE nome LIKE '%a';

SELECT * FROM Curso
WHERE nome LIKE '_e%';

SELECT * FROM Curso
WHERE nome LIKE '%n_';

DROP TABLE Curso;