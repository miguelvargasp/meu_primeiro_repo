CREATE database Vingadores;
CREATE TABLE heroi (
id INT PRIMARY KEY auto_increment,
nome VARCHAR(45),
versao VARCHAR(45),
habilidade VARCHAR(50),
altura int
) auto_increment = 1;

INSERT INTO heroi (nome, versao, habilidade, altura) VALUES
('Spider-Man', 'The Amazing Spider-Man 2', 'sentido arácnido', 179),
('Wolverine', 'Deadpool & Wolverine', 'fator de cura', 188),
('Hulk', 'Hulk', 'força ilimitada', 450),
('Mulher Invisível', 'Quarteto Fantástico 2025', 'campos de força', 170),
('Capitão América', 'Capitão América Guerra Civil', 'força sobrehumana', 185);

ALTER TABLE heroi ADD COLUMN regeneracao INT;

ALTER TABLE heroi ADD CONSTRAINT chkregen CHECK (regeneracao IN('0', '1'));

ALTER TABLE heroi MODIFY COLUMN versao VARCHAR(100);

DELETE FROM heroi WHERE id = 2; 

INSERT INTO heroi (nome, versao, habilidade, altura) VALUES
('Capitã Marvel', 'Vingadores Ultimato', 'invulnerabilidade', 175);

SELECT * FROM heroi WHERE nome LIKE 'C%' OR nome LIKE 'H%';

SELECT * FROM heroi WHERE nome NOT LIKE '%a%';

SELECT * FROM heroi WHERE altura >= 190;

SELECT * FROM heroi WHERE altura >= 180 ORDER BY nome DESC;

TRUNCATE TABLE heroi;






