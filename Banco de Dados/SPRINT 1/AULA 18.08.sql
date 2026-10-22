USE sprint1;

CREATE TABLE sensor (
id INT PRIMARY KEY auto_increment,
tipo VARCHAR(50) DEFAULT 'DHT11', -- Se não colocar nada o default coloca dht11
temperaturaIdeal FLOAT NOT NULL, -- Não pode ser 0
locall VARCHAR(20) UNIQUE, -- Não pode ter um igual
statuss VARCHAR(40),
CONSTRAINT chkStatus CHECK (statuss IN ('Ativo', 'Inativo')),
dataHora DATETIME DEFAULT current_timestamp -- current timestamp coloca hora atual conforme fuso horário do servidor
) auto_increment = 1000;     -- AUTO INCREMENT = numero sempre colocar fora dos parenteses

INSERT INTO sensor VALUES -- se não colocar o default no campo id, especificar entre parenteses as colunas que serão preenchidas
( default, 'LM35', 29.2, 'Quadrante A', 'Ativo', '2026-08-18 10:47:00');

INSERT INTO sensor (temperaturaIdeal, locall, statuss) VALUES
(25.4, 'Quadrante B', 'Inativo'),
(23.4, 'Quadrante C', 'Ativo');

SELECT * FROM sensor;


-- O comando abaixo dará erro de constraint
INSERT INTO sensor (temperaturaIdeal,statuss) VALUES
(19.0, 'Em manutenção');
-- Check constraint 'chkStatus' is violated

-- remover constraint
ALTER TABLE sensor DROP CONSTRAINT chkStatus;

ALTER TABLE sensor ADD CONSTRAINT chkStatuss
CHECK (statuss IN ('Ativo', 'Inativo', 'Em manutenção'));

-- ALIAS - APELIDO 'AS'
SELECT tipo AS 'Qualquer Coisa' FROM sensor; -- colocar entre aspas se tem espaço no apelido

-- CONCAT - CONCATENAR

SELECT CONCAT(tipo,statuss) FROM sensor;
SELECT CONCAT(tipo, ' ', statuss) FROM sensor;
SELECT CONCAT(tipo, ' ', statuss) AS Frase FROM sensor;
SELECT CONCAT('O tipo do sensor é ', tipo, ' ', 'e seu status é ', statuss) AS Frase FROM sensor;

-- INSERINDO STATUS NULO PARA TRATAR 
INSERT INTO sensor (temperaturaIdeal) VALUES
(19.3);

SELECT * FROM sensor;

-- IFNULL - SE NULO 
SELECT IFNULL(statuss, 'Não preenchido') AS 'Status' FROM sensor;

SELECT CONCAT('O tipo do sensor é ', tipo, ' ', 'e seu status é ', IFNULL(statuss, 'Não preenchido')) AS Frase FROM sensor;

-- CONDIÇÃO CASE 
SELECT CASE 
	WHEN temperaturaIdeal > 20 THEN 'Temperatura Alta'
    WHEN temperaturaIdeal = 20 Then 'Temperatura Ideal'
    ELSE 'Temperatura não tratada'
    END AS Temperatura
    FROM sensor;
    
SELECT tipo, statuss, dataHora, locall, -- SE FOR MOSTRAR ALÉM DO CASE
CASE 
	WHEN temperaturaIdeal > 20 THEN 'Temperatura Alta'
    WHEN temperaturaIdeal = 20 Then 'Temperatura Ideal'
    ELSE 'Temperatura não tratada'
    END AS Temperatura
    FROM sensor;

-- CONFIGURAR DATA
SELECT date_format(dataHora, '%y/%m/%d') AS dataHora FROM sensor; -- minusculo breve, maiusculo detalhado
SELECT date_format(dataHora, '%d/%m/%y') AS dataHora FROM sensor;
SELECT date_format(dataHora, '%d/%m/%Y') AS dataHora FROM sensor;
SELECT date_format(dataHora, '%d/%m/%Y %h:%i') AS dataHora FROM sensor; -- com hora i = minuto













