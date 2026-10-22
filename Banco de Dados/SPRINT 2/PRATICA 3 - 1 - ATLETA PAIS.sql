use sprint2;

CREATE TABLE Atleta(
idAtleta INT PRIMARY KEY auto_increment, 
nome VARCHAR(40),
modalidade VARCHAR(40),
qtdMedalha INT
) auto_increment = 1;

INSERT INTO Atleta VALUES
(default, 'Rodrigo Villamarín', 'rugby', '5'), 
(default, 'Milena Gutiérrez', 'natação', '2'), 
(default, 'Victor Del Bosque', 'futebol', '6'), 
(default, 'Camila Cruz', 'hoquei grama', '8'), 
(default, 'Rosario Rinaldi', 'esgrima', '4');

CREATE TABLE Pais(
idPais INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30), 
capital VARCHAR(40)
) AUTO_INCREMENT = 1;


INSERT INTO Pais VALUES
(default, 'Espanha', 'Madrid'),
(default, 'Colombia', 'Bogotá'),
(default, 'Argentina', 'Buenos Aires'),
(default, 'Uruguai', 'Montevideo');

ALTER TABLE Atleta ADD COLUMN fkPais INT NOT NULL;
        
UPDATE Atleta SET fkPais = 3 WHERE idAtleta = 1;
UPDATE Atleta SET fkPais = 2 WHERE idAtleta = 2;
UPDATE Atleta SET fkPais = 4 WHERE idAtleta = 3;
UPDATE Atleta SET fkPais = 1 WHERE idAtleta = 4;
UPDATE Atleta SET fkPais = 3 WHERE idAtleta = 5;

ALTER TABLE Atleta ADD CONSTRAINT fkPaisAtleta 
	FOREIGN KEY (fkPais)
		REFERENCES Pais(idPais);
        
SELECT * FROM Pais 
JOIN Atleta on fkPais = idPais;

SELECT Atleta.nome AS nomeatleta,
	Pais.nome AS nomepais
    FROM Pais JOIN Atleta 
    ON fkPais = idPais;
    
SELECT Atleta.nome AS nomeatleta,
	Pais.nome AS nomepais
    FROM Pais JOIN Atleta 
    ON fkPais = idPais
    WHERE Pais.capital = 'Buenos Aires';
    
    
    
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! EXERCICIO 2
CREATE TABLE Musica(
idMusica INT PRIMARY KEY,
titulo VARCHAR(40),
artista VARCHAR(40),
genero VARCHAR(40)
);

INSERT INTO Musica VALUES
(1, 'Here Comes The Sun', 'The Beatles', 'rock'),
(2, 'La Isla Bonita', 'Madonna', 'pop'),
(3, 'Miss Independent', 'Ne-Yo', 'R&B'),
(4, 'Used', 'SZA', 'R&B');

CREATE TABLE Album(
idAlbum INT PRIMARY KEY,
nome VARCHAR(40),
tipo VARCHAR(7),
CONSTRAINT chktipo CHECK (tipo IN ('digital', 'fisico')),
dtLancamento DATE
);

INSERT INTO Album VALUES 
(1, 'Abbery Road', 'fisico', '1969-09-26'),
(2, 'Year Of The Gentleman', 'fisico', '2008-09-16'),
(3, 'SOS', 'digital', '2022-12-09'),
(4, 'True Blue', 'fisico', '1986-06-30');

ALTER TABLE Musica ADD COLUMN fkAlbum INT NOT NULL;

UPDATE Musica SET fkAlbum = 1 WHERE idMusica = 1;
UPDATE Musica SET fkAlbum = 4 WHERE idMusica = 2;
UPDATE Musica SET fkAlbum = 2 WHERE idMusica = 3;
UPDATE Musica SET fkAlbum = 3 WHERE idMusica = 4;

ALTER TABLE Musica ADD CONSTRAINT fkAlbumMusica
	FOREIGN KEY (fkAlbum)
		REFERENCES Album(idAlbum);

SELECT * FROM ALbum
	JOIN Musica ON fkAlbum = idAlbum;
    
SELECT Musica.titulo AS nomedamusica,
	Album.nome AS nomedoalbum
    FROM Album JOIN Musica 
		ON fkAlbum = idAlbum;
        
SELECT Musica.titulo AS nomedamusica,
	Album.nome AS nomedoalbum
    FROM Album JOIN Musica 
		ON fkAlbum = idAlbum
        WHERE Album.tipo = 'fisico';
        

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! EXERCIO 3 

CREATE TABLE 



        
        

        



	



