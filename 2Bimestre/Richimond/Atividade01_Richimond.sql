drop database if exists Richimond;
create database Richimond;
USE Richimond;



CREATE TABLE Comissao_tecnica (
    BID INT PRIMARY KEY AUTO_INCREMENT,
    Nomes VARCHAR(100),
    Nacionalidades VARCHAR(50),
    Idades INT,
    Encargos VARCHAR(100)
);

CREATE TABLE Time (
    Ata_fundacao INT PRIMARY KEY,
    Nome VARCHAR(100),
    Cidade VARCHAR(100),
    data_Fundacao DATE,
    Estadio VARCHAR(100),

    BID INT,

    FOREIGN KEY (BID)
    REFERENCES Comissao_tecnica(BID)
);



CREATE TABLE Jogadores (
    BID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Data_nascimento DATE,
    Pais VARCHAR(50),
    Posicao VARCHAR(50),
    Altura_cm INT,
    Numero_camisa INT,
    Valor_transferencia INT,

    Ata_fundacao INT,

    FOREIGN KEY (Ata_fundacao)
    REFERENCES Time(Ata_fundacao)
);



CREATE TABLE Contrato (
    Codigo_contrato INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(50),
    Taxa DECIMAL(10,2),
    Anos_contrato INT,

    BID INT,

    FOREIGN KEY (BID)
    REFERENCES Jogadores(BID)
);



CREATE TABLE Campeonato (
    Num_edicao VARCHAR(10) PRIMARY KEY,
    Jogos INT,
    Vitorias INT,
    Derrotas INT,
    Empates INT,
    Gols_pro INT,
    Gols_contra INT,
    Saldo INT,
    Posicao INT,

    Ata_fundacao INT,

    FOREIGN KEY (Ata_fundacao)
    REFERENCES Time(Ata_fundacao)
);



CREATE TABLE Estatistica (
    Temporada INT PRIMARY KEY,
    Artilheiro VARCHAR(100),
    Mais_assistencias INT,
    Menos_vazado VARCHAR(100),
    Quanti_jogos INT,
    Cartoes_amarelos INT,
    Cartoes_vermelhos INT,

    Jogadores INT,

    FOREIGN KEY (Jogadores)
    REFERENCES Jogadores(BID)
);



CREATE TABLE Partida (
    Rodada INT PRIMARY KEY,
    Gols INT,
    Assistencias INT,
    Cartoes INT,
    Num_defesas INT,
    Divididas INT,

    Num_edicao VARCHAR(10),

    FOREIGN KEY (Num_edicao)
    REFERENCES Campeonato(Num_edicao)
);



INSERT INTO Comissao_tecnica
(Nomes,Nacionalidades,Idades,Encargos)
VALUES
("Theodore Lasso","Estados Unidos",42,"Tecnico"),
("Coach Beard","Estados Unidos",41,"Auxiliar-tecnico"),
("Nathan Shelley","Inglaterra",38,"Treinador-estrategico"),
("Roy Kent","Inglaterra",38,"Preparador-fisico"),
("Leslie Higgins","Inglaterra",46,"Diretor de futebol"),
("Sharon Fieldstone","Inglaterra",42,"Psicologa esportiva");


INSERT INTO Time
(Ata_fundacao,Nome,Cidade,data_Fundacao,Estadio)
VALUES
(8061970,"AFC Richmond","Londres","1970-06-08","Nelson Road");


INSERT INTO Jogadores
(Nome,Data_nascimento,Pais,Posicao,Altura_cm,Numero_camisa,Valor_transferencia)
VALUES
("Thierry Zoreaux","1993-10-11","Canada","Goleiro",188,1,16000000),
("Ash Dixon","1996-06-04","Inglaterra","Lateral-direito",170,2,25000000),
("Isaac McAdoo","1996-06-20","Inglaterra","Zagueiro",184,3,45000000),
("Jan Maas","1992-09-01","Holanda","Zagueiro",193,4,2000000),
("George Goodman","1992-07-08","Inglaterra","Lateral-esquerdo",180,5,26000000),
("Samuel Obisanya","2000-01-11","Nigeria","Meia-direita",185,24,85000000),
("Moe Bumbercatch","1996-08-14","Suica","Segundo-volante",174,8,4000000),
("Colin Hughes","1995-08-21","Gales","Meia-central",178,6,28000000),
("Richard Montlaur","1995-07-14","Franca","Meia-esquerda",176,13,2000000,8061970),
("Dani Rojas","1995-09-16","Mexico","Centroavante",183,11,8000000,8061970),
("Jamie Tartt","1997-10-20","Inglaterra","Ponta-de-lança",178,9,18000000,8061970),
("Zava","1986-09-23","Polônia","Centroavante",191,10,1000000,8061970),
("Emmanuel Winchester","1996-06-19","Nigéria","Zagueiro",186,6,12000000,8061970),
("Tom Obrien","1995-03-01","Inglaterra","Goleiro",192,12,14000000,8061970),
("Joe Reynolds","1991-06-01","Irlanda","Zagueiro",187,20,9000000,8061970),
("Ozzie Kukôc","2000-05-09","Inglaterra","Meia",177,18,19000000,8061970),
("Nicolas Batumde","1990-12-09","Nigéria","Volante",19000000,8061970),
("Tanaka Roberts","1993-06-08","Zâmbia","Ponta-de-lança",11000000,8061970);
INSERT INTO Contrato
(Tipo,Taxa,Anos_contrato,BID)
VALUES
("Transferencia",0.00,4,1),
("Transferencia",0.00,3,2),
("Transferencia",0.00,5,3),
("Emprestimo",1500000.00,1,4),
("Transferencia",0.00,4,5),
("Transferencia",0.00,6,6),
("Emprestimo",500000.00,1,7),
("Transferencia",0.00,4,8),
("Emprestimo",250000.00,2,9),
("Transferencia",0.00,5,10),
("Transferencia",0.00,5,11),
("Transferencia",0.00,2,12),
("Transferencia",0.00,3,13),
("Transferencia",0.00,2,14),
("Transferencia",0.00,5,15),
("Transferencia",0.00,3,16),
("Transferencia",0.00,1,17),
("Transferencia",0.00,0,18);
INSERT INTO Campeonato
(Num_edicao,Jogos,Vitorias,Derrotas,Empates,Gols_pro,Gols_contra,Saldo,Posicao,Ata_fundacao)
VALUES
("24/25",38,20,8,10,65,40,25,3,8061970);


INSERT INTO Estatistica
(Temporada,Artilheiro,Mais_assistencias,Menos_vazado,Quanti_jogos,Cartoes_amarelos,Cartoes_vermelhos,Jogadores)
VALUES
(2023,"Jamie Tartt",15,"Thierry Zoreaux",38,45,3,11);


INSERT INTO Partida
(Rodada,Gols,Assistencias,Cartoes,Num_defesas,Divididas,Num_edicao)
VALUES
(1,3,2,4,5,18,"23/24"),
(2,1,1,2,7,12,"23/24"),
(3,4,3,1,2,20,"23/24"),
(4,2,2,3,6,15,"23/24"),
(5,0,0,5,8,10,"23/24"),
(6,5,4,2,3,22,"23/24"),
(7,2,1,4,4,17,"23/24"),
(8,1,1,1,9,11,"23/24"),
(9,3,2,3,5,19,"23/24"),
(10,2,1,2,6,16,"23/24"),
(11,4,3,2,4,21,"23/24"),
(12,1,0,5,7,13,"23/24"),
(13,2,2,1,3,18,"23/24"),
(14,0,0,4,10,9,"23/24"),
(15,3,1,2,5,20,"23/24"),
(16,2,2,3,4,17,"23/24"),
(17,1,1,2,6,14,"23/24"),
(18,5,3,1,2,23,"23/24"),
(19,4,2,3,3,19,"23/24"),
(20,2,1,2,5,16,"23/24"),
(21,3,2,4,7,18,"23/24"),
(22,1,0,5,8,12,"23/24"),
(23,4,4,1,3,24,"23/24"),
(24,2,1,3,5,15,"23/24"),
(25,3,2,2,4,20,"23/24"),
(26,0,0,4,9,10,"23/24"),
(27,1,1,3,6,13,"23/24"),
(28,5,3,1,2,25,"23/24"),
(29,2,2,2,5,17,"23/24"),
(30,4,3,3,4,21,"23/24"),
(31,1,0,5,8,11,"23/24"),
(32,3,2,2,6,18,"23/24"),
(33,2,1,3,7,16,"23/24"),
(34,4,4,1,2,22,"23/24"),
(35,1,1,4,9,12,"23/24"),
(36,2,2,2,5,19,"23/24"),
(37,3,1,3,4,20,"23/24"),
(38,5,4,1,3,26,"23/24");



SELECT * FROM Comissao_tecnica;
SELECT * FROM Time;
SELECT * FROM Jogadores;
SELECT * FROM Contrato;
SELECT * FROM Campeonato;
SELECT * FROM Estatistica;
SELECT * FROM Partida;
