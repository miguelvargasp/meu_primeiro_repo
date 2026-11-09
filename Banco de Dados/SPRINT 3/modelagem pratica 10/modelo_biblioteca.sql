CREATE DATABASE IF NOT EXISTS biblioteca_comunitaria CHARACTER SET utf8mb4;
USE biblioteca_comunitaria;

CREATE TABLE genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(45)
);

CREATE TABLE livro (
    id_livro       INT AUTO_INCREMENT PRIMARY KEY,
    titulo         VARCHAR(45),
    ano_publicacao INT,
    num_paginas    INT,
    id_genero      INT,
    CONSTRAINT fk_livro_genero FOREIGN KEY (id_genero)
        REFERENCES genero (id_genero)
);

CREATE TABLE leitor (
    id_leitor INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(45),
    email     VARCHAR(45),
    cidade    VARCHAR(45)
);

CREATE TABLE clube (
    id_clube     INT AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(45),
    data_criacao DATE
);

CREATE TABLE participacao (
    id_leitor     INT,
    id_clube      INT,
    data_ingresso DATE,
    num_encontros INT DEFAULT 0,
    PRIMARY KEY (id_leitor, id_clube),
    CONSTRAINT fk_part_leitor FOREIGN KEY (id_leitor)
        REFERENCES leitor (id_leitor),
    CONSTRAINT fk_part_clube FOREIGN KEY (id_clube)
        REFERENCES clube (id_clube)
);
