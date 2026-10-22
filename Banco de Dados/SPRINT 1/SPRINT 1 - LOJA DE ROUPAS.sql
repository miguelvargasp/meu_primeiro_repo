USE sprint1;

CREATE TABLE produto(
id INT PRIMARY KEY,
nome VARCHAR(100), 
categoria VARCHAR(50),
preco DECIMAL(10,2),
tamanho VARCHAR(5),
CONSTRAINT chktamanho CHECK (tamanho IN ('P', 'M', 'G', 'GG')),
data_cadastro DATETIME,
disponivel TINYINT
);

ALTER TABLE produto ADD CONSTRAINT chkdisponivel CHECK (disponivel IN (0,1));

INSERT INTO produto VALUES 
('1', 'DIAMOND Tshirt' , 'camiseta', 359.99, 'GG', '2019-04-12', 1),
('2', 'Calvin Klein shirt' , 'camisa', 399.99, 'M', '2015-02-28', 0),
('3', 'Booksfield Calça alfaiate' , 'calca', 749.99, 'M', '2020-05-12',1),
('4', 'Armani moletom' , 'inverno', 549.99, 'M', '2014-02-28', 0),
('5', 'John John boné' , 'chapeu', 129.99, 'M', '2018-11-08', 0),
('6', 'Tommy Hilfiger brinco' , 'accessorios', 319.99, 'M', '2021-07-11', 1),
('7', 'New Balance cueca' , 'intima', 39.99, 'M', '2024-07-09', 1);

SELECT * FROM produto 
	WHERE nome LIKE '%shirt%';
    

SELECT * FROM produto 
	WHERE tamanho <> 'M';
    
SELECT * FROM produto 
	WHERE data_cadastro >= '2025-08-18';

SELECT * FROM produto 
	WHERE categoria <> 'camiseta' AND categoria <> 'blusa';
    
SELECT concat(nome,' R$', preco) AS produto_preco FROM produto; -- Não esquecer do FROM ""nome_tabela"

SELECT * FROM produto 
	WHERE nome NOT LIKE '%blusa%';
    
SELECT CASE 
		WHEN disponivel = 1 THEN 'Disponível'
        ELSE 'Indisponível'
        END AS statuss
        FROM produto;
        
SELECT * FROM produto
WHERE categoria = 'calca' AND preco > '100.00';


SELECT * FROM produto
WHERE nome NOT LIKE '%camiseta%';

SELECT * FROM produto
WHERE id =1 OR id = 3 OR id= 5; -- NÃO ESQUECERRRRR

SELECT * FROM produto
WHERE tamanho <> 'M' AND tamanho <> 'P';

SELECT * FROM produto
WHERE data_cadastro <= '2025-08-18';

SELECT nome AS produto_valor, preco AS produto_valor FROM produto;

SELECT concat(nome, categoria,' R$', preco) AS info_completa FROM produto;

SELECT * FROM produto 
WHERE disponivel <> 0 AND tamanho = 'M';

SELECT * FROM produto 
WHERE nome LIKE 'c%';

UPDATE produto set nome = 'Jaqueta Couro'
WHERE id = 4;

UPDATE produto set preco = 270.00
WHERE id = 4;

UPDATE produto set disponivel = 0
WHERE id = 1 OR id = 2;

UPDATE produto set tamanho = 'M'
WHERE id = 2;

UPDATE produto set categoria = 'camiseta'
WHERE id = 1 OR id = 2;

UPDATE produto set disponivel = 0
WHERE id = 7;

UPDATE produto set preco = 41.99
WHERE id = 7;

UPDATE produto set nome = 'Short Esportivo Unissex', categoria = 'short'
WHERE id = 4;







    

