
Create database Biblioteca ;

Use biblioteca;
CREATE TABLE Usuario (
ID_user INT PRIMARY KEY auto_increment,
CPF VARCHAR(14) NOT NULL UNIQUE,
Nome VARCHAR(100) NOT NULL,
Email VARCHAR(100)NOT NULL UNIQUE,
Idade INT,
CEP VARCHAR(10) not null
);

-- Tabela Emprestimo
CREATE TABLE Emprestimo (
ID_emp INT PRIMARY KEY auto_increment,
Data_inicio DATE,
Data_prevista_entrega DATE,
Data_atraso DATE,
Status_ VARCHAR(20)not null,
ID_user INT,
ID_livro INT,
FOREIGN KEY (ID_user) REFERENCES Usuario(ID_user),
FOREIGN KEY (ID_livro) REFERENCES Livro(ID_livro)
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
Data_nascimento DATE
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


insert into Usuario (CPF, Nome, Email, Idade, CEP) 
values (432-901-588-09 , 'João Silva' , 'joao_legal@gmail.com.br ', 34 , 'SP',
443-784-611-06 , 'Neymar Araujo' , 'Neyparaguai@outlook.com' , 25 , 'RS',
788-651-321-67 , 'Cleide Joana' ,'cleidejo@gmail.com' ,55, 'BA',
336-742-123-78 , 'Thiago Martins' , 'Martinsenterprise@gmail.com ',68, 'RN',
321-964-425-90 , 'Manuel Ribeiro' , 'Manuel_rib34@gmail.com',28, 'PE');

Insert into Emprestimo (Data_inicio ,Data_prevista_entrega , Data_atraso , Status_ )
values ('13/08/2025','14/02/2026', '17/02/2026' , 'Entregue',
         '17/01/2025','05/02/2025', '08/02/2026' , 'EM ATRASO',
         '01/02/2025','14/03/2026', '17/03/2026' , 'Entregue',
         '10/06/2025','20/06/2025', '25/02/2025' , 'EM ATRASO',	
         '13/06/2023','14/07/2023', '19/07/2023' , 'Entregue');
         
         insert into Livro (Numero_paginas , nome , Idioma , Edicao , tipo)
         values (134, 'Mogli o menino lobo ' , 'portugues' , 'limitada', 'Capa dura',
	534, 'Fome de poder' , 'portugues' , 'ilimitada', 'Capa dura',
    34, 'Vai embora monstro' , 'portugues' , 'ilimitada', 'Brochura',
    400, 'Jacquin ' , 'portugues' , 'limitada', 'Capa dura',
    200, 'Álbum da sulamericana ' , 'portugues' , 'limitada', 'Flexivel');
    
    insert into Categoria (Faixa_etaria , Numero_livros, Nome_categoria , Publico_alvo ,Tipo )
    values ('+14', 200 , 'Documental' , 'Juvenil' , 'não-ficticio',
    '+3', 300 , 'Infantil' , 'infantil' , 'ficticio',
    '+14', 200 , 'HQ' , 'Juvenil' , 'ficticio''
    +18', 100 , 'Acidentes e massacres' , 'Adulto' , 'não-ficticio',
    '+16', 260 , 'Biografias' , 'jovens adultos' , 'não-ficticio');
    Insert Autor (Nome ,Idade, Endereco_principal,Nacionalidade, Data_nascimento)
    values ('Jonas Arlin', 26 , 'Rua G', 'Brasileiro', '10/02/2000'
 'Joana Arlin', 27 , 'Rua G', 'Brasileira', '10/09/1999'
 'Jonas Arlin', 26 , 'Rua G', 'Brasileiro', '10/02/2000'
 ('Jonas Arlin', 26 , 'Rua G', 'Brasileiro', '10/02/2000'
 ('Jonas Arlin', 26 , 'Rua G', 'Brasileiro', '10/02/2000'