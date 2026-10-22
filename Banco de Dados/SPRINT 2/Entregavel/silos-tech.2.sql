
USE db_silostech;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    nomeEmpresa VARCHAR(100) NOT NULL,
    cnpjEmpresa CHAR(14) NOT NULL UNIQUE,
    dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    statusEmpresa TINYINT NOT NULL DEFAULT 1,

    CONSTRAINT chk_status_empresa CHECK (statusEmpresa IN (0, 1))
);

--  LOCAIS (uma empresa pode ter vários locais) 
CREATE TABLE locais (
    idLocal INT PRIMARY KEY AUTO_INCREMENT,
    nomeLocal VARCHAR(100) NOT NULL,
    cepLocal CHAR(8),
    numeroLocal VARCHAR(10),
    bairroLocal VARCHAR(50),
    cidadeLocal VARCHAR(50),
    estadoLocal CHAR(2),
    complementoLocal VARCHAR(50),
    statusLocal TINYINT NOT NULL DEFAULT 1,
    fkEmpresa INT NOT NULL,

    CONSTRAINT fk_locais_empresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT chk_status_local CHECK (statusLocal IN (0, 1))
);

--  CLIENTE (usuário que pertence a uma empresa) 
CREATE TABLE cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nomeCliente VARCHAR(100) NOT NULL,
    cpfCliente CHAR(11) UNIQUE,
    emailCliente VARCHAR(100) UNIQUE,
    telefoneCliente VARCHAR(20),
    dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    senhaCliente VARCHAR(255) NOT NULL,
    statusCliente TINYINT NOT NULL DEFAULT 1,
    permissaoCliente TINYINT NOT NULL DEFAULT 0,   -- 0, 1 ou 2 
    fkEmpresa INT NOT NULL,

    CONSTRAINT fk_cliente_empresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    CONSTRAINT chk_permissao_cliente CHECK (permissaoCliente IN (0, 1, 2)),
    CONSTRAINT chk_email_cliente CHECK (emailCliente LIKE '%@%'),
    CONSTRAINT chk_status_cliente CHECK (statusCliente IN (0, 1))
);

--  SILO (fica em um local) 
CREATE TABLE silo (
    idSilo INT PRIMARY KEY AUTO_INCREMENT,
    nomeSilo VARCHAR(50) NOT NULL,
    capacidadeMaximaVolume DECIMAL(12,2) NOT NULL,
    tipoConteudo VARCHAR(50),
    dataInstalacao DATE,
    statusSilo TINYINT NOT NULL DEFAULT 1,
    fkLocal INT NOT NULL,

    CONSTRAINT fk_silo_local FOREIGN KEY (fkLocal) REFERENCES locais(idLocal),
    CONSTRAINT chk_status_silo CHECK (statusSilo IN (0, 1))
);

--  SENSOR (o equipamento, instalado em um silo) 
CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    statusSensor TINYINT NOT NULL DEFAULT 1,
    fkSilo INT NOT NULL,

    CONSTRAINT fk_sensor_silo FOREIGN KEY (fkSilo) REFERENCES silo(idSilo),
    CONSTRAINT chk_status_sensor CHECK (statusSensor IN (0, 1))
);

--  LEITURA (cada medição feita por um sensor) 
CREATE TABLE leitura (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    dataHoraLeitura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valorLeitura DECIMAL(4,2) NOT NULL,   -- definir a unidade (ex.: distância em cm, temperatura em °C)
    fkSensor INT NOT NULL,

    CONSTRAINT fk_leitura_sensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
);


-- INSERTS (na ordem das dependências)


INSERT INTO empresa (razaoSocial, nomeEmpresa, cnpjEmpresa) VALUES
('AgroSilos Armazenagem de Grãos Ltda', 'AgroSilos', '12345678000101'),
('Silo Forte Cereais S.A.', 'SiloForte', '23456789000202'),
('Grãos do Brasil Armazenagem Ltda', 'Grãos do Brasil', '34567890000303'),
('AgroStorage Soluções Agrícolas Ltda', 'AgroStorage', '45678901000404');

INSERT INTO locais (nomeLocal, cepLocal, numeroLocal, bairroLocal, cidadeLocal, estadoLocal, complementoLocal, fkEmpresa) VALUES
('Unidade Sorriso I', '78890000', '450', 'Zona Rural', 'Sorriso', 'MT', 'Próximo ao silo de soja', 1),
('Unidade Sorriso II', '78890000', '500', 'Zona Rural', 'Sorriso', 'MT', NULL, 1),
('Unidade Rondonópolis', '78745000', '1200', 'Distrito Industrial', 'Rondonópolis', 'MT', 'Unidade de armazenagem', 2),
('Unidade Rio Verde', '75901000', '850', 'Setor Industrial', 'Rio Verde', 'GO', 'Armazém de soja', 3),
('Unidade Itumbiara', '75503000', '680', 'Zona Rural', 'Itumbiara', 'GO', 'Unidade de silos', 4);

INSERT INTO cliente (nomeCliente, cpfCliente, emailCliente, telefoneCliente, senhaCliente, statusCliente, permissaoCliente, fkEmpresa) VALUES
('Carlos Silva', '12345678901', 'carlos.silva@email.com', '(11) 98765-4321', '$2y$10$eImiTXuWVxfM37uY4JANjOL.oMQPQOxhH5f5v4d5e6f7g8h9i0j1k', 1, 2, 1),
('Ana Souza', '23456789012', 'ana.souza@email.com', '(21) 99876-5432', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oMQPQOxhH5f5v4d5e6f7g8h9i0j1k', 1, 0, 2),
('Marcos Oliveira', '34567890123', 'marcos.oliveira@email.com', '(31) 98888-7777', '$2y$10$X7vRtY2bN8mK9pL3qW1s2u4oMQPQOxhH5f5v4d5e6f7g8h9i0j1k', 0, 0, 3),
('Juliana Lima', '45678901234', 'juliana.lima@email.com', '(41) 97777-6666', '$2y$10$Z3xCvBnM1qAzWsEdRfTgYh6oMQPQOxhH5f5v4d5e6f7g8h9i0j1k', 1, 2, 4),
('Roberto Santos', '56789012345', 'roberto.santos@email.com', '(71) 96666-5555', '$2y$10$P5oLiKuYtReWqAzXsEdCfV8oMQPQOxhH5f5v4d5e6f7g8h9i0j1k', 0, 1, 4);

INSERT INTO silo (nomeSilo, capacidadeMaximaVolume, tipoConteudo, dataInstalacao, fkLocal) VALUES
('Silo GrãoSoberano', 150000.00, 'Soja', '2024-03-15', 1),
('Silo SafraOuro', 250000.50, 'Soja', '2023-08-22', 2),
('Silo Milhoja', 180000.00, 'Soja', '2025-01-10', 3),
('Silo Agromais Grãos', 90000.75, 'Soja', '2022-11-05', 4),
('Silo DouroGrão', 120000.00, 'Soja', '2024-06-18', 5);

INSERT INTO sensor (statusSensor, fkSilo) VALUES
(1, 1),
(1, 2),
(0, 3),
(1, 4),
(1, 5);

INSERT INTO leitura (dataHoraLeitura, valorLeitura, fkSensor) VALUES
('2026-10-01 10:00:00', 1.23, 1),
('2026-10-01 10:00:00', 3.21, 2),
('2026-10-01 10:00:00', 2.31, 3),
('2026-10-01 08:00:00', 1.10, 1),
('2026-10-01 09:00:00', 1.18, 1),
('2026-10-01 08:00:00', 3.05, 2);


-- Todas as leituras com sensor, silo, local e empresa
SELECT e.nomeEmpresa AS empresa,
       l.nomeLocal AS local,
       s.nomeSilo AS silo,
       se.idSensor AS sensor,
       le.valorLeitura AS valor,
       le.dataHoraLeitura AS data_hora
FROM leitura le
JOIN sensor se ON le.fkSensor = se.idSensor
JOIN silo s ON se.fkSilo = s.idSilo
JOIN locais l ON s.fkLocal = l.idLocal
JOIN empresa e ON l.fkEmpresa = e.idEmpresa
ORDER BY le.dataHoraLeitura DESC;
