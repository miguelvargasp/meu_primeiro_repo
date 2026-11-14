USE sprint1;

CREATE TABLE Filme (
idFilme INT PRIMARY KEY,
titulo VARCHAR(40),
genero VARCHAR(40),
diretor VARCHAR(40)
);

INSERT INTO Filme VALUES
('1', 'Spider-Man', 'Ação', 'Sam Raimi'),
('2', 'Poderoso Chefão', 'Drama', 'Francis Coppola'),
('3', 'Depois de Horas', 'Comédia', 'Martin Scorsese'),
('4', 'Ilha do Medo', 'Suspense', 'Martin Scorsese'),
('5', 'Exterminador do Futuro', 'Ação', 'James Cameron'), 
('6', 'Amnesia', 'Suspense', 'Christopher Nolan'),
('7', 'A Odisséia', 'Épico', 'Christopher Nolan');

SELECT idFIlme, titulo, genero, diretor FROM Filme;
SELECT * FROM Filme;

SELECT titulo, diretor FROM Filme;

SELECT * FROM Filme
WHERE genero = 'Ação';

SELECT * FROM Filme
WHERE diretor = 'Christopher Nolan';

SELECT * FROM Filme ORDER BY diretor;

SELECT * FROM Filme 
WHERE titulo LIKE 'a%';

SELECT * FROM Filme
WHERE diretor LIKE 'm%';

SELECT * FROM Filme
WHERE genero LIKE '_u%';

SELECT * FROM Filme
WHERE titulo LIKE '%a_';

DROP TABLE Filme;

