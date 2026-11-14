USE sprint1;

CREATE TABLE Professor (
idProfessor INT PRIMARY KEY,
nome VARCHAR(50),
especialidade VARCHAR(40),
dtNasc DATE
);

INSERT INTO Professor VALUES
('1', 'Luís Fernández', 'Matematica', '1977-07-17'),
('2', 'María Nuñez', 'Geografia', '1990-04-10'),
('3', 'Nicolás Godín', 'Matematica', '1985-05-27'),
('4', 'Pablo Passarella', 'Física', '1987-09-11'),
('5', 'Marianella Rinaldi', 'História', '1990-05-12'),
('6', 'Julieta Vasquez', 'Quimica', '1996-08-07');

SELECT * FROM Professor;
SELECT idProfessor, nome, especialidade, dtNasc FROM Professor;

SELECT especialidade FROM Professor;

SELECT * FROM Professor
WHERE especialidade = 'Matematica';

SELECT * FROM Professor ORDER BY nome;

SELECT * FROM Professor ORDER BY dtNasc DESC;

SELECT * FROM Professor
WHERE nome LIKE 'l%';

SELECT * FROM Professor
WHERE nome LIKE '%z';

SELECT * FROM Professor
WHERE nome LIKE '_a%';

SELECT * FROM Professor
WHERE nome LIKE '%d_';

DROP TABLE Professor;

