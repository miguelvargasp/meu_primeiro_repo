USE sprint2;

CREATE TABLE funcionario (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
area VARCHAR(45),
salario DECIMAL(10,2),
fkSupervisor INT,
CONSTRAINT fkFuncSuper 
	FOREIGN KEY (fkSupervisor) 
		REFERENCES funcionario(idFuncionario)
        );

INSERT INTO funcionario(nome,salario, fkSupervisor) VALUES 
('Brandão', 100.00, null), 
('Vivian', 99.00, 1), 
('Matheus', 96.00, 1),
('Pedro', 101.00, 2);

SELECT * FROM funcionario JOIN funcionario AS supervisor 
	ON funcionario.fkSupervisor = supervisor.idFuncionario;
    

SELECT funcionario.nome AS NomeFunc,
	ifnull(supervisor.nome, 'Supervisor') AS NomeSuper -- Brandão tem um Supervisor não definido
    FROM funcionario RIGHT JOIN funcionario AS supervisor -- LEFT ou RIGHT JOIN --> BRANDÃO APARECE
		ON funcionario.fkSupervisor = supervisor.idFuncionario; -- CUIDADO PARA NÃO INVERTER, SENÃO FUNCIONÁRIO VIRA SUPERVISOR

CREATE TABLE dependente(
idDependente INT, 
fkFuncionario INT,
CONSTRAINT pkComposta PRIMARY KEY (idDependente, fkFuncionario),
nome VARCHAR(45),
parentesco VARCHAR(45),
CONSTRAINT fkDepFunc FOREIGN KEY(fkFuncionario) 
	REFERENCES funcionario (idFuncionario)
    );
    
INSERT INTO dependente VALUES -- É possível repetir o idDependente 
	(1, 2, 'Cintia', 'namorada'),
	(1, 3, 'Lola', 'pet'),
	(2, 3, 'Sebastian', 'pet'),
	(1, 4, 'Eliane', 'mãe');
    
SELECT funcionario.nome as Func,
	dependente.nome as Dependente
    FROM funcionario JOIN dependente
		ON idFuncionario = fkFuncionario; -- COMO SÃO TABELAS DIFERENTES O JOIN é NORMAL
        
-- TRAZER FUNCIONÁRIO QUE NÃO TÊM DEPENDENTES
SELECT funcionario.nome as Func,
	dependente.nome as Dependente
    FROM funcionario LEFT JOIN dependente
		ON idFuncionario = fkFuncionario;

-- TRAZER SÓ o BRANDÃO
SELECT funcionario.nome as Func,
	dependente.nome as Dependente
    FROM funcionario LEFT JOIN dependente
		ON idFuncionario = fkFuncionario
        WHERE fkFuncionario IS NULL;
        
    
ALTER TABLE funcionario ADD CONSTRAINT SalarioPositivo
	CHECK(salario >= 0);
    
SELECT funcionario.nome as Funcionário,
	supervisor.nome as Supervisor,
    dependente.nome as Dependente
 FROM funcionario JOIN dependente
    ON idFuncionario = fkFuncionario
    JOIN funcionario AS supervisor 
	ON funcionario.fkSupervisor = supervisor.idFuncionario; -- JOIN MOSTRANTDO TUDO E FUNÇÃoptimize
    
    
SELECT f.idFuncionario AS 'ID Func',
	f.fkSupervisor AS 'ID Super',
    f.nome AS 'Nome Funcionario',
    s.nome AS 'Nome Supervisor',
    d.nome AS 'Nome Dependente'
    FROM funcionario as f JOIN funcionario as s
    ON f.fkSupervisor = s.idFuncionario
    JOIN dependente as d
    ON f.idFuncionario = d.fkFuncionario
    ORDER BY f.idFuncionario;
    
    
    

