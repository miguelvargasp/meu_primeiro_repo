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
        

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! EXERCICIO 3 
CREATE TABLE pessoa(
idpessoa INT PRIMARY KEY,
nome VARCHAR(45),
cpf CHAR(11)
);

INSERT INTO pessoa VALUES
(1, 'Rodrigo Ramírez', '74476344744'),
(2, 'Romina Carrizo', '38452959284'),
(3, 'Alana González', '37859375694'),
(4, 'Victoria Belmonte', '29457673958'),
(5, 'Ezequiel Zeballos', '60493785603');

CREATE TABLE Reserva(
idReserva INT PRIMARY KEY,
dtReserva DATETIME,
dtRetirada DATETIME,
dtDevolução DATETIME
);

INSERT INTO Reserva VALUES 
(1, '2024-07-12 12:00:00','2024-07-13 12:00:00', '2024-07-14 12:00:00'), 
(2, '2024-07-14 12:00:00','2024-07-15 12:00:00', '2024-07-16 12:00:00'), 
(3, '2024-08-12 12:00:00','2024-08-13 12:00:00', '2024-08-14 12:00:00'), 
(4, '2024-09-12 12:00:00','2024-09-13 12:00:00', '2024-09-14 12:00:00'), 
(5, '2024-09-16 12:00:00','2024-09-17 12:00:00', null);

ALTER TABLE Reserva ADD COLUMN fkPessoa INT NOT NULL;

UPDATE Reserva SET fkPessoa = 1 WHERE idReserva = 1;
UPDATE Reserva SET fkPessoa = 2 WHERE idReserva = 2;
UPDATE Reserva SET fkPessoa = 3 WHERE idReserva = 3;
UPDATE Reserva SET fkPessoa = 4 WHERE idReserva = 4;
UPDATE Reserva SET fkPessoa = 5 WHERE idReserva = 5;

ALTER TABLE Reserva ADD CONSTRAINT fkPessoaReserva 
	FOREIGN KEY (fkPessoa)
		REFERENCES pessoa(idpessoa);
        
SELECT * FROM pessoa 
	JOIN Reserva ON fkPessoa = idpessoa;
    
SELECT Reserva.dtReserva as datareserva,
	pessoa.nome as nomedapessoa
	FROM pessoa 
		JOIN Reserva ON fkPessoa = idpessoa;
        
SELECT Reserva.dtReserva as datareserva,
	pessoa.nome as nomedapessoa,
    CASE MONTH(Reserva.dtReserva)
		WHEN 7 THEN 'Julho'
		WHEN 8 THEN 'Agosto'
		WHEN 9 THEN 'Setembro'
        ELSE 'mês do escopo'
        END AS Mês
        FROM pessoa
        JOIN Reserva ON fkPessoa = idpessoa;
        
SELECT pessoa.nome AS nomedapessoa,
       Reserva.dtReserva AS datareserva,
       IFNULL(Reserva.dtRetirada, 'Não retirado') AS dataretirada,
       IFNULL(Reserva.dtDevolução, 'Não devolvido') AS datadevolucao
FROM pessoa
JOIN Reserva ON fkPessoa = idpessoa;

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! EXERCICIO 4

CREATE TABLE Pessoa1(
idPessoa1 INT PRIMARY KEY,
nome VARCHAR(45),
dtNascimento DATE
);

INSERT INTO Pessoa1 VALUES
(1, 'Alonso Vargas', '1998-09-06'),
(2, 'Andrea Benitez', '2002-03-12'),
(3, 'Alejandra Guzmán', '2005-08-31'),
(4, 'Violeta Rondríguez', '2008-04-11'),
(5, 'Santiago Paz', '2001-12-06');

CREATE TABLE Pessoa2 (
idPessoa2 INT PRIMARY KEY,
nome VARCHAR(45),
dtNascimento date
);
INSERT INTO Pessoa2 VALUES
(1, 'Valentín Vargas', '1998-09-06'),
(2, 'Alejandra Benitez', '2002-03-12'),
(3, 'Carla Guzmán', '2005-08-31'),
(4, 'Julieta Rondríguez', '2008-04-11'),
(5, 'Nicolás Paz', NULL);

ALTER TABLE Pessoa2 ADD COLUMN fkPessoa1 INT NOT NULL;

UPDATE Pessoa2 SET fkPessoa1 = 1 WHERE idPessoa2 = 1;
UPDATE Pessoa2 SET fkPessoa1 = 2 WHERE idPessoa2 = 2;
UPDATE Pessoa2 SET fkPessoa1 = 3 WHERE idPessoa2 = 3;
UPDATE Pessoa2 SET fkPessoa1 = 4 WHERE idPessoa2 = 4;
UPDATE Pessoa2 SET fkPessoa1 = 5 WHERE idPessoa2 = 5;

ALTER TABLE Pessoa2 ADD CONSTRAINT fkPessoa1Pessoa2
	FOREIGN KEY (fkPessoa1)
		REFERENCES Pessoa1(idPessoa1);

SELECT * FROM Pessoa1
	JOIN Pessoa2 ON fkPessoa1 = idPessoa1;
    
SELECT Pessoa1.nome AS nomegemeo1,
	Pessoa2.nome AS nomegemeo2
    FROM Pessoa1 
    JOIN Pessoa2 ON fkPessoa1 = idPessoa1;
    
SELECT Pessoa1.nome AS nomegemeo1,
	Pessoa2.nome AS nomegemeo2,
    CASE YEAR(Pessoa1.dtNascimento)
    WHEN 2008 THEN 'os(as) mais novinhos(as)'
    WHEN 1998 THEN 'experientes'
    ELSE 'novos(as)'
    END AS idade
    FROM Pessoa1
    JOIN Pessoa2 ON fkPessoa1 = idPessoa1;
    
SELECT Pessoa1.nome AS nomegemeo1,
       Pessoa2.nome AS nomegemeo2,
       IFNULL(Pessoa2.dtNascimento, 'há um(a) gêmeo(a) não registrado(a)') AS registroOK
FROM Pessoa1
JOIN Pessoa2 ON fkPessoa1 = idPessoa1;

-- ######################################################## EXERCICIO 5

CREATE TABLE candidato(
idcandidato INT PRIMARY KEY,
nome VARCHAR(45),
dtNascimento DATE,
cpf CHAR(11)
);

INSERT INTO candidato VALUES
(1, 'Rodrigo Ramírez', '1998-09-06', '74476344744'),
(2, 'Romina Carrizo', '2002-03-12', '38452959284'),
(3, 'Alana González', '2005-08-31', '37859375694'),
(4, 'Victoria Belmonte', '2008-04-11', '29457673958'),
(5, 'Ezequiel Zeballos', '2002-04-11', '60493785603');

CREATE TABLE habilitacao(
idhabilitacao INT primary key,
categoria VARCHAR(2),
dtValidade DATE,
acc CHAR(1)
);

INSERT INTO habilitacao VALUES
(1, 'AB', '2026-11-10', '1'),
(2, 'B', '2027-09-10', '0'),
(3, 'AB', '2026-11-23', '1'),
(4, 'B', '2027-06-06', '0'),
(5, 'AB', '2026-10-10', '1');

UPDATE habilitacao SET acc = NULL WHERE idhabilitacao = 4;

ALTER TABLE habilitacao ADD COLUMN fkcandidato INT UNIQUE;

UPDATE habilitacao SET fkcandidato = 1 WHERE idhabilitacao = 1;
UPDATE habilitacao SET fkcandidato = 2 WHERE idhabilitacao = 2;
UPDATE habilitacao SET fkcandidato = 3 WHERE idhabilitacao = 3;
UPDATE habilitacao SET fkcandidato = 4 WHERE idhabilitacao = 4;
UPDATE habilitacao SET fkcandidato = 5 WHERE idhabilitacao = 5;

ALTER TABLE habilitacao ADD CONSTRAINT fkcandidatohabilitacao
	FOREIGN KEY (fkcandidato)
		REFERENCES candidato(idcandidato);

SELECT * FROM candidato
	JOIN habilitacao ON fkcandidato = idcandidato;
    
SELECT habilitacao.categoria as categoria,
	candidato.nome as nomecandidato
		FROM candidato 
        JOIN habilitacao ON fkcandidato = idcandidato;
        
SELECT candidato.nome as nomecandidato,
	habilitacao.categoria as categoria,
    CASE categoria
    WHEN 'B' THEN 'Apenas carro'
    WHEN 'A' THEN 'Apenas moto'
    ELSE 'Carro e moto'
    END AS nomecategoria
	FROM candidato
    JOIN habilitacao ON fkcandidato = idcandidato;
    
SELECT candidato.nome AS nomecandidato,
       habilitacao.categoria AS categoria,
       IFNULL(habilitacao.acc, 'não pretende tirar ACC') AS habilitacaoacc
FROM candidato
JOIN habilitacao ON fkcandidato = idcandidato;


-- ####################################################### EXERCICIO 6 

CREATE TABLE farmacia (
    idFarmacia INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cnpj CHAR(11)
    );
    
INSERT INTO farmacia VALUES
(1, 'Drogaria Bem Estar', '82938592894'),
(2, 'Farma Vida', '57396350278'),
(3, 'Saúde Total', '24738406748'),
(4, 'Popular Center', '12346834569'),
(5, 'Farmácia Central', '57396428578');

CREATE TABLE endereco(
idendereco INT PRIMARY KEY,
nome VARCHAR(45),
numero VARCHAR(5)
);

INSERT INTO endereco VALUES
(1, 'Rua Augusta', '1200'),
(2, 'Av. Paulista', '900'),
(3, 'Rua Haddock Lobo','350'),
(4, 'Rua Vergueiro', NULL),
(5, 'Av. Francisco Glicério', NULL);

ALTER TABLE endereco ADD COLUMN fkfarmacia INT UNIQUE;

UPDATE endereco SET fkfarmacia = 1 WHERE idendereco = 1;
UPDATE endereco SET fkfarmacia = 2 WHERE idendereco = 2;
UPDATE endereco SET fkfarmacia = 3 WHERE idendereco = 3;
UPDATE endereco SET fkfarmacia = 4 WHERE idendereco = 4;
UPDATE endereco SET fkfarmacia = 5 WHERE idendereco = 5;

CREATE TABLE farmaceutico(
idfarmaceutico INT PRIMARY KEY,
nome VARCHAR(45),
telefone CHAR(11)
);

INSERT INTO farmaceutico VALUES
(1, 'Jorge Amado', '11938592894'),
(2, 'Carlos Saavedra', '11996350278'),
(3, 'Mariana Velásquez', '11938406748'),
(4, 'Judith Salvatierra', '11946834569'),
(5, 'Rocío Herrera', '11986428578');

ALTER TABLE farmaceutico ADD COLUMN fkfarmacia INT UNIQUE;

UPDATE farmaceutico SET fkfarmacia = 1 WHERE idfarmaceutico = 1;
UPDATE farmaceutico SET fkfarmacia = 2 WHERE idfarmaceutico = 2;
UPDATE farmaceutico SET fkfarmacia = 3 WHERE idfarmaceutico = 3;
UPDATE farmaceutico SET fkfarmacia = 4 WHERE idfarmaceutico = 4;
UPDATE farmaceutico SET fkfarmacia = 5 WHERE idfarmaceutico = 5;

ALTER TABLE endereco ADD CONSTRAINT fkfarmaciaendereco
	FOREIGN KEY (fkfarmacia)
		REFERENCES farmacia(idfarmacia);
        
ALTER TABLE farmaceutico ADD CONSTRAINT fkfarmaciafarmaceutico
	FOREIGN KEY (fkfarmacia)
		REFERENCES farmacia(idfarmacia);
        
SELECT * FROM farmacia
JOIN farmaceutico ON fkfarmacia = idfarmacia;

SELECT farmaceutico.nome as nomefarmaceutico,
	farmacia.nome as nomefarmacia
	FROM farmacia
	JOIN farmaceutico ON fkfarmacia = idfarmacia;

SELECT farmaceutico.nome as nomefarmaceutico,
	farmacia.nome as nomefarmacia,
    CASE telefone
    WHEN '11%' THEN 'É de São Paulo'
    ELSE 'Não é de São Paulo'
    END AS 'É de onde?'
    FROM farmacia
	JOIN farmaceutico ON fkfarmacia = idfarmacia;
    
SELECT endereco.nome AS nomerua,
       farmacia.nome AS nomefarmacia,
       IFNULL(endereco.numero, 'S/N') AS numerorua
FROM farmacia
JOIN endereco ON fkfarmacia = idfarmacia;















        
        

        



	



