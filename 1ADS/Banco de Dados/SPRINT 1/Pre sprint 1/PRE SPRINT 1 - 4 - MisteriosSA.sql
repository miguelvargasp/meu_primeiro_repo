CREATE DATABASE estoque;

CREATE TABLE MisteriosSA (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
datacompra DATE,
preco DECIMAL(10,2),
peso DECIMAL(7,2),
dataretirada DATE
) auto_increment = 1;

INSERT INTO MisteriosSA (nome, datacompra, preco, peso) VALUES
('Biscoitos Scooby', '2022-07-18', 50.00, 300.00),
('Biscoitos Scooby', '2024-07-18', 40.00, 250.00),
('Cachorro quente', '2023-07-18', 25.00, 250.00),
('Cachorro quente', '2023-07-18', 18.00, 180.00),
('Biscoitos Scooby', '2023-07-18', 80.00, 500.00);

SELECT * FROM MisteriosSA;

SELECT * FROM MisteriosSA ORDER BY datacompra DESC;

UPDATE MisteriosSA SET dataretirada = '2023-08-01'
WHERE id = 5;

ALTER TABLE MisteriosSA RENAME COLUMN id to idComida;

ALTER TABLE MisteriosSA ADD CONSTRAINT chknome CHECK (nome IN('Biscoitos Scooby', 'Cachorro quente'));

SELECT nome, datacompra AS 'data de compra', dataretirada AS 'data de retirada' FROM MisteriosSA;

SELECT * FROM MisteriosSA
WHERE datacompra <= '2024-07-25';

SELECT * FROM MisteriosSA
WHERE preco >= 30.50;

TRUNCATE TABLE MisteriosSA;
