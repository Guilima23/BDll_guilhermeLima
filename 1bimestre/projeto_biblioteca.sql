drop database if exists Biblioteca24;
Create database Biblioteca24;

Use biblioteca24;
CREATE TABLE Usuario (
ID_user INT PRIMARY KEY auto_increment,
CPF VARCHAR(14) NOT NULL UNIQUE,
Nome VARCHAR(100) NOT NULL,
Email VARCHAR(100)NOT NULL UNIQUE,
Idade INT,
CEP VARCHAR(10) not null
);


-- Tabela Categoria
CREATE TABLE Categoria (
ID_cat INT PRIMARY KEY auto_increment,
Faixa_etaria VARCHAR(50) not null,
Numero_livros INT,
Nome_categoria VARCHAR(100) not null,
Publico_alvo VARCHAR(100)not null,
Tipo VARCHAR(50)
);

-- Tabela Autor
CREATE TABLE Autor (
ID_auto INT PRIMARY KEY auto_increment,
Nome VARCHAR(100)not null,
Idade INT,
Endereco_principal VARCHAR(150)not null,
Nacionalidade VARCHAR(50),
nascimento date
);

-- Tabela Editora
CREATE TABLE Editora (
ID_edit INT PRIMARY KEY auto_increment,
Estoque INT,
Funcionarios INT,
Pais VARCHAR(50),
Nome VARCHAR(100),
Cidade VARCHAR(100)
);


-- Tabela Livro
CREATE TABLE Livro (
ID_livro INT PRIMARY KEY auto_increment,
Numero_paginas INT,
Nome varchar(200),
Idioma VARCHAR(50),
Edicao VARCHAR(50),
tipo varchar(50),
ID_categoria INT,
ID_editora INT,
FOREIGN KEY (ID_categoria) REFERENCES Categoria(ID_cat),
FOREIGN KEY (ID_editora) REFERENCES Editora(ID_edit)
);
-- Tabela Emprestimo
CREATE TABLE Emprestimo (
ID_emp INT PRIMARY KEY auto_increment,
inicio DATE,
entrega_prevista DATE,
atraso DATE,
Status_ VARCHAR(20)not null,
ID_user INT,
ID_livro INT,
FOREIGN KEY (ID_user) REFERENCES Usuario(ID_user),
FOREIGN KEY (ID_livro) REFERENCES Livro(ID_livro)
);

CREATE TABLE Emprestimo_Livro (
ID_emp INT,
ID_livro INT,
PRIMARY KEY (ID_emp, ID_livro),
FOREIGN KEY (ID_emp) REFERENCES Emprestimo(ID_emp),
FOREIGN KEY (ID_livro) REFERENCES Livro(ID_livro)
);

insert into Usuario (CPF, Nome, Email, Idade, CEP) 
values (432-901-588-09 , 'João Silva' , 'joao_legal@gmail.com.br ', 34 , 'SP'),
(443-784-611-06 , 'Neymar Araujo' , 'Neyparaguai@outlook.com' , 25 , 'RS'),
(788-651-321-67 , 'Cleide Joana' ,'cleidejo@gmail.com' ,55, 'BA'),
(336-742-123-78 , 'Thiago Martins' , 'Martinsenterprise@gmail.com ',68, 'RN'),
(321-964-425-90 , 'Manuel Ribeiro' , 'Manuel_rib34@gmail.com',28, 'PE');

         
         insert into Livro (Numero_paginas , nome , Idioma , Edicao , tipo)
         values (134, 'Mogli o menino lobo ' , 'portugues' , 'limitada', 'Capa dura'),
	(534, 'Fome de poder' , 'portugues' , 'ilimitada', 'Capa dura'),
    (34, 'Vai embora monstro' , 'portugues' , 'ilimitada', 'Brochura'),
    (400, 'Jacquin ' , 'portugues' , 'limitada', 'Capa dura'),
    (200, 'Álbum da sulamericana ' , 'portugues' , 'limitada', 'Flexivel');
    
    insert into Categoria (Faixa_etaria , Numero_livros, Nome_categoria , Publico_alvo ,Tipo )
    values ('+14', 200 , 'Documental' , 'Juvenil' , 'não-ficticio'),
   ('+3', 300 , 'Infantil' , 'infantil' , 'ficticio'),
   ('+14', 200 , 'HQ' , 'Juvenil' , 'ficticio'),
   ('+18', 100 , 'Acidentes e massacres' , 'Adulto' , 'não-ficticio'),
   ('+16', 260 , 'Biografias' , 'jovens adultos' , 'não-ficticio');
    Insert Autor (Nome ,Idade, Endereco_principal,Nacionalidade,nascimento)
    values ('Jonas Arlin', 26 , 'Rua G', 'Brasileiro', 10-02-2000),
 ('Joana Arlin', 27 , 'Rua G', 'Brasileira', '10-09-1999'),
 ('Carlos Silva', 45, 'Rua H', 'Brasileiro', '07-07-1981'),
('Ana Souza', 38, 'Rua I', 'Brasileira', '16-12-1988'),
('Caio Silvero', 42, 'Rua F', 'Brasileiro', '23-02-1984');
Insert into Emprestimo(inicio ,entrega_prevista , atraso , Status_ )
values (2025-08-28, 2025-09-13, 2026-09-15 , 'Entregue'),
         ('2026-01-25','2026-01-15', '2023-01-25', 'EM ATRASO'),
         ('2026-02-14','2026-03-20', '2026-03-31', 'Entregue'),
         ('2025-06-10','2025-06-25', '2025-06-30' , 'EM ATRASO'),	
         ('2023-09-24','2023-09-30', '2023-08-01', 'Entregue');
         -- EDITORA
INSERT INTO Editora (Estoque, Funcionarios, Pais, Nome, Cidade) VALUES
(1000, 50, 'Brasil', 'Editora Ademais', 'São Paulo'),
(800, 40, 'Brasil', 'Editora Bari', 'Rio de Janeiro'),
(600, 30, 'Brasil', 'Editora Carrascal', 'Belo Horizonte'),
(200, 12, 'Brasil', 'Editora Dionísio', 'Porto Seguro'),
(600, 47, 'Brasil', 'Editora Estudante', 'Pernambuco');


SELECT * FROM Usuario;

SELECT * FROM Categoria;

SELECT * FROM Editora;

SELECT * FROM Livro;

SELECT * FROM Autor;

SELECT * FROM Emprestimo;

SELECT * FROM Emprestimo_Livro;