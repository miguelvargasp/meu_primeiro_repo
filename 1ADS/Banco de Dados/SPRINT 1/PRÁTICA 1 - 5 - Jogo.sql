USE sprint1;

CREATE TABLE Jogo (
idJogo INT PRIMARY KEY,
nome VARCHAR(50), 
comentario VARCHAR(200),
ranking INT
);

INSERT Jogo VALUES
('1', 'Grand Theft Auto', 'Rockstar Games', '3'),
('2', 'Super Mario Galaxy', 'Nintendo', '2'),
('3', 'The Legend of Zelda', 'Nintendo', '1'),
('4', 'Red Dead Redemption', 'Rockstar Games', '4'),
('5', 'Minecraft', 'Mojang', '5');

SELECT idJogo, nome, comentario, ranking FROM  Jogo;
SELECT * FROM Jogo;

SELECT nome FROM Jogo;

SELECT comentario FROM Jogo;

SELECT * FROM Jogo ORDER BY nome;

SELECT * FROM Jogo ORDER BY ranking DESC;

SELECT * FROM Jogo
WHERE nome LIKE 'r%';

SELECT * FROM Jogo
WHERE nome LIKE '%a';


SELECT * FROM Jogo
WHERE nome LIKE '_i%';


SELECT * FROM Jogo
WHERE nome LIKE '%x_';	

SELECT * FROM Jogo
WHERE nome != 'Minecraft';

DROP TABLE Jogo;
	