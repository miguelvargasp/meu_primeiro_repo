USE sprint1;

CREATE TABLE Carro (
idCarro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (40),
placa CHAR(7)
) AUTO_INCREMENT = 1000;

INSERT INTO Carro VALUES
(default, 'Hyundai HB20', 'FHC4787'),
(default, 'VW Vento', 'JQK3197'),
(default, 'Honda Civic', 'NMD4572'),
(default, 'Jeep Compass', 'SVO3820');

SELECT * FROM Carro; 

INSERT INTO Carro (nome) VALUES
('Chevrolet Speedback'),
('BYD Seal'),
('Renault Fluence');

SELECT * FROM Carro;

DESCRIBE Carro;

ALTER TABLE Carro MODIFY COLUMN nome VARCHAR(28);

DESCRIBE Carro;

ALTER TABLE Carro ADD COLUMN ano CHAR(4);

UPDATE Carro set placa = 'ASD4768'
WHERE idCarro = '1004';

UPDATE Carro set placa = 'SNJ3957'
WHERE idCarro = '1005';

UPDATE Carro set placa = 'NGD3964'
WHERE idCarro = '1006';

INSERT INTO Carro (ano) VALUES
('1999'),
('2005'),
('2010'),
('2020'),
('2023'),
('2025'),
('2010');
