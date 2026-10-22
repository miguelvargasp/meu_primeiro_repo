USE sprint1;

CREATE TABLE Filme (
idFilme INT PRIMARY KEY,
titulo VARCHAR(50),
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

SELECT * FROM Filme;

ALTER TABLE Filme ADD COLUMN protagonista VARCHAR(50);
DESCRIBE Filme;

UPDATE FIlme set protagonista = 'Tobey Maguire'
WHERE idFilme= 1;
SELECT * FROM Filme;

UPDATE FIlme set protagonista = 'Marlon Brando'
WHERE idFilme= 2;

UPDATE FIlme set protagonista = 'Griffin Dune'
WHERE idFilme= 3;

UPDATE FIlme set protagonista = 'Leonardo DiCaprio'
WHERE idFilme= 4;

UPDATE FIlme set protagonista = 'Linda Hamilton'
WHERE idFilme= 5;

UPDATE FIlme set protagonista = 'Guy Pearce'
WHERE idFilme= 6;

UPDATE FIlme set protagonista = 'Matt Damon'
WHERE idFilme= 7;
SELECT * FROM Filme;

ALTER TABLE Filme MODIFY COLUMN diretor VARCHAR(150);

UPDATE Filme set diretor = 'Steven Spielberg'
Where idFilme = 5;
SELECT * FROM Filme;

UPDATE Filme set diretor = 'Alfred Hitchcock'
Where idFilme = 2;

UPDATE Filme set diretor = 'Dennis Villeneuve'
Where idFilme = 7;

UPDATE Filme set titulo = 'O Grande Truque'
Where idFilme = 6;

DELETE FROM Filme WHERE idFilme = 3;
SELECT * FROM Filme;

SELECT * FROM FIlme 
WHERE genero <> 'Drama';

SELECT * FROM FIlme 
WHERE genero = 'Suspense';

DESCRIBE Filme;
TRUNCATE TABLE Filme;


