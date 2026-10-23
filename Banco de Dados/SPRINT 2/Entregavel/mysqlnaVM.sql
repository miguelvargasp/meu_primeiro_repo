CREATE DATABASE mysqlnavm;

USE mysqlnavm;

CREATE TABLE grupo(
idIntegrantes INT PRIMARY KEY AUTO_INCREMENT,
nomeIntegrante VARCHAR(40),
RA CHAR(8))
;

INSERT INTO grupo VALUES 
(default, 'Ana Beatriz', 01262145),
(default, 'Davidy Costa', 01262460),
(default, 'Kaik Correia', 01262646),
(default, 'Luca Yamamura', 01262465),
(default, 'Miguel Vargas', 01262019),
(default, 'Ricardo Motta', 01262123);

SELECT * FROM grupo;