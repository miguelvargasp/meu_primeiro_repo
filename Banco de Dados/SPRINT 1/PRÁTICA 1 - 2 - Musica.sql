USE sprint1;
CREATE TABLE Musica (
idMusica INT PRIMARY KEY,
titulo VARCHAR(40), 
artista VARCHAR(40),
genero VARCHAR(40)
);

INSERT INTO Musica VALUES
('1', 'Kiss from a rose', 'Seal', 'Soul'),
('2', 'Bed of roses', 'Bon Jovi', 'Rock'),
('3', 'La Isla Bonita', 'Madonna', 'Pop'),
('4', 'Stand by Me', 'Ben E. King', 'Soul'),
('5', 'Beat It', 'Michael Jackson', 'Rock'),
('6', 'Billie Jean', 'Michael Jackson', 'Pop'),
('7', 'Never Gonna Give You Up', 'Rick Astley', 'Pop');

SELECT idMusica, titulo, artista, genero FROM Musica;
SELECT * FROM Musica;
SELECT titulo, artista FROM Musica;

SELECT * FROM Musica 
WHERE genero = 'Pop';

SELECT * FROM Musica
WHERE artista = 'Michael Jackson';

SELECT * FROM Musica ORDER BY titulo;

SELECT * FROM Musica ORDER BY artista DESC;

SELECT * FROM Musica 
WHERE titulo LIKE 'B%';

SELECT * FROM Musica 
WHERE artista LIKE '%a';

SELECT * FROM Musica 
WHERE genero LIKE '_o%';

SELECT * FROM Musica 
WHERE titulo LIKE '%a_';

DROP TABLE Musica;