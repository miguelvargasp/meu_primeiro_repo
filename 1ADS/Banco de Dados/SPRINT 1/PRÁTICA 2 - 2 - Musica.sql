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
('7', 'Like a Virgin', 'Madonna', 'Pop');

SELECT * FROM Musica;
SELECT idMusica, titulo, artista, genero FROM Musica;

ALTER  TABLE Musica ADD COLUMN curtidas INT;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 11
WHERE idMusica = 1;

UPDATE Musica SET curtidas = 22
WHERE idMusica = 2;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 33
WHERE idMusica = 3;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 44
WHERE idMusica = 4;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 55
WHERE idMusica = 5;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 66
WHERE idMusica = 6;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 66
WHERE idMusica = 7;
SELECT * FROM Musica;

ALTER TABLE Musica MODIFY COLUMN artista VARCHAR(80);
DESCRIBE Musica;

UPDATE Musica SET curtidas = 57
WHERE idMusica = 1;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 58
WHERE idMusica = 2;
SELECT * FROM Musica;

UPDATE Musica SET curtidas = 59
WHERE idMusica = 3;
SELECT * FROM Musica;

UPDATE Musica SET titulo = 'Give In To Me'
WHERE idMusica = 5;
SELECT * FROM Musica;

DELETE FROM Musica WHERE idMusica = 4;
SELECT * FROM Musica;

SELECT * FROM Musica
WHERE genero != 'funk';

SELECT * FROM Musica
WHERE curtidas >= 20;

DESCRIBE Musica;

TRUNCATE TABLE Musica;
SELECT * FROM Musica;
