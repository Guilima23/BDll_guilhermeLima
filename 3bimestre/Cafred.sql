DROP DATABASE IF EXISTS Cafred;
CREATE DATABASE Cafred;
    

USE Cafred;

-- =========================================================
-- 1. CLIENTE
-- Relacionamento: Cliente 1 : N Pedido
-- =========================================================
CREATE TABLE Cliente (
    ID_cliente INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(60) NOT NULL,
    Idade INT,
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Email VARCHAR(60),
    Telefone VARCHAR(15),
    PRIMARY KEY (ID_cliente)
);

-- =========================================================
-- 2. CARDÁPIO
-- Relacionamento: Cardápio 1 : N Pedido
-- =========================================================
CREATE TABLE Cardápio (
    ID_produto INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(60) NOT NULL,
    Descrição VARCHAR(100),
    Categoria VARCHAR(30),
    Disponibilidade VARCHAR(20),
    PRIMARY KEY (ID_produto)
);

-- =========================================================
-- 3. FUNCIONÁRIOS
-- Relacionamento: Funcionários 1 : N Pedido
-- =========================================================
CREATE TABLE Funcionários (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(60) NOT NULL,
    Funções VARCHAR(50),
    CPF VARCHAR(11) NOT NULL UNIQUE,
    Email VARCHAR(60),
    Telefone VARCHAR(15),
    PRIMARY KEY (id_funcionario)
);

-- =========================================================
-- 4. PAGAMENTO
-- O campo Comanda referencia o Cliente, conforme o diagrama.
-- Relacionamento: Pagamento 1 : N Pedido
-- =========================================================
CREATE TABLE Pagamento (
    ID_pagamento INT NOT NULL AUTO_INCREMENT,
    Comanda INT NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    Forma_Pagamento VARCHAR(30) NOT NULL,
    Data DATE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID_pagamento)
);


CREATE TABLE Pedido (
    ID_pedido INT NOT NULL AUTO_INCREMENT,
    Comanda INT NOT NULL,
    Descrição VARCHAR(100),
    Status VARCHAR(20),
    Especificações VARCHAR(100),
    Quantidade INT NOT NULL,
    Cardápio INT NOT NULL,
    Funcionário INT NOT NULL,
    Pagamento INT NOT NULL,
    PRIMARY KEY (ID_pedido),

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (Comanda)
        REFERENCES Cliente (ID_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_pedido_cardapio
        FOREIGN KEY (Cardápio)
        REFERENCES Cardápio (ID_produto),
   
        FOREIGN KEY (Funcionário)
        REFERENCES Funcionários (id_funcionario),

            FOREIGN KEY (Pagamento)
        REFERENCES Pagamento (ID_pagamento)

);

-- =========================================================
-- POPULAÇÃO: 20 CLIENTES
-- =========================================================
INSERT INTO Cliente
(Nome, Idade, CPF, Email, Telefone) VALUES
('Ana Souza', 22, '11111111101', 'ana.souza@email.com', '11990000001'),
('Bruno Oliveira', 25, '11111111102', 'bruno.oliveira@email.com', '11990000002'),
('Carlos Santos', 31, '11111111103', 'carlos.santos@email.com', '11990000003'),
('Daniela Costa', 28, '11111111104', 'daniela.costa@email.com', '11990000004'),
('Eduardo Lima', 34, '11111111105', 'eduardo.lima@email.com', '11990000005'),
('Fernanda Alves', 21, '11111111106', 'fernanda.alves@email.com', '11990000006'),
('Gabriel Pereira', 27, '11111111107', 'gabriel.pereira@email.com', '11990000007'),
('Helena Martins', 30, '11111111108', 'helena.martins@email.com', '11990000008'),
('Igor Rodrigues', 24, '11111111109', 'igor.rodrigues@email.com', '11990000009'),
('Julia Ferreira', 26, '11111111110', 'julia.ferreira@email.com', '11990000010'),
('Lucas Carvalho', 29, '11111111111', 'lucas.carvalho@email.com', '11990000011'),
('Mariana Gomes', 23, '11111111112', 'mariana.gomes@email.com', '11990000012'),
('Nicolas Ribeiro', 32, '11111111113', 'nicolas.ribeiro@email.com', '11990000013'),
('Olivia Barbosa', 20, '11111111114', 'olivia.barbosa@email.com', '11990000014'),
('Pedro Mendes', 35, '11111111115', 'pedro.mendes@email.com', '11990000015'),
('Rafael Teixeira', 27, '11111111116', 'rafael.teixeira@email.com', '11990000016'),
('Sofia Nascimento', 22, '11111111117', 'sofia.nascimento@email.com', '11990000017'),
('Thiago Moreira', 33, '11111111118', 'thiago.moreira@email.com', '11990000018'),
('Valentina Castro', 24, '11111111119', 'valentina.castro@email.com', '11990000019'),
('William Rocha', 38, '11111111120', 'william.rocha@email.com', '11990000020');

-- =========================================================
-- POPULAÇÃO: 20 PRODUTOS DO CARDÁPIO
-- =========================================================
INSERT INTO Cardápio
(Nome, Descrição, Categoria, Disponibilidade) VALUES
('Café Espresso', 'Café espresso tradicional', 'Café', 'Disponível'),
('Café com Leite', 'Café espresso com leite', 'Café', 'Disponível'),
('Cappuccino', 'Café com leite vaporizado e espuma', 'Café', 'Disponível'),
('Mocha', 'Café com chocolate e leite', 'Café', 'Disponível'),
('Latte', 'Café espresso com leite cremoso', 'Café', 'Disponível'),
('Chocolate Quente', 'Chocolate cremoso servido quente', 'Bebida', 'Disponível'),
('Chá de Camomila', 'Chá de camomila quente', 'Chá', 'Disponível'),
('Chá de Frutas', 'Infusão de frutas vermelhas', 'Chá', 'Disponível'),
('Suco de Laranja', 'Suco natural de laranja', 'Suco', 'Disponível'),
('Suco de Morango', 'Suco natural de morango', 'Suco', 'Disponível'),
('Água Mineral', 'Água mineral sem gás', 'Bebida', 'Disponível'),
('Refrigerante', 'Refrigerante em lata', 'Bebida', 'Disponível'),
('Pão de Queijo', 'Pão de queijo tradicional', 'Salgado', 'Disponível'),
('Croissant', 'Croissant de massa folhada', 'Salgado', 'Disponível'),
('Sanduíche Natural', 'Sanduíche com frango e salada', 'Salgado', 'Disponível'),
('Bolo de Chocolate', 'Fatia de bolo de chocolate', 'Doce', 'Disponível'),
('Bolo de Cenoura', 'Fatia de bolo de cenoura', 'Doce', 'Disponível'),
('Torta de Limão', 'Fatia de torta de limão', 'Doce', 'Disponível'),
('Cookie', 'Cookie com gotas de chocolate', 'Doce', 'Disponível'),
('Brownie', 'Brownie de chocolate', 'Doce', 'Disponível');

-- =========================================================
-- POPULAÇÃO: 20 FUNCIONÁRIOS
-- =========================================================
INSERT INTO Funcionários
(Nome, Funções, CPF, Email, Telefone) VALUES
('João Silva', 'Atendente', '22222222201', 'joao.silva@cafeteria.com', '11991110001'),
('Maria Oliveira', 'Caixa', '22222222202', 'maria.oliveira@cafeteria.com', '11991110002'),
('Pedro Santos', 'Barista', '22222222203', 'pedro.santos@cafeteria.com', '11991110003'),
('Larissa Costa', 'Atendente', '22222222204', 'larissa.costa@cafeteria.com', '11991110004'),
('Mateus Lima', 'Barista', '22222222205', 'mateus.lima@cafeteria.com', '11991110005'),
('Camila Alves', 'Caixa', '22222222206', 'camila.alves@cafeteria.com', '11991110006'),
('André Pereira', 'Gerente', '22222222207', 'andre.pereira@cafeteria.com', '11991110007'),
('Beatriz Martins', 'Atendente', '22222222208', 'beatriz.martins@cafeteria.com', '11991110008'),
('Felipe Rodrigues', 'Barista', '22222222209', 'felipe.rodrigues@cafeteria.com', '11991110009'),
('Isabela Ferreira', 'Caixa', '22222222210', 'isabela.ferreira@cafeteria.com', '11991110010'),
('Renato Carvalho', 'Atendente', '22222222211', 'renato.carvalho@cafeteria.com', '11991110011'),
('Amanda Gomes', 'Barista', '22222222212', 'amanda.gomes@cafeteria.com', '11991110012'),
('Diego Ribeiro', 'Atendente', '22222222213', 'diego.ribeiro@cafeteria.com', '11991110013'),
('Clara Barbosa', 'Caixa', '22222222214', 'clara.barbosa@cafeteria.com', '11991110014'),
('Gustavo Mendes', 'Barista', '22222222215', 'gustavo.mendes@cafeteria.com', '11991110015'),
('Bianca Teixeira', 'Atendente', '22222222216', 'bianca.teixeira@cafeteria.com', '11991110016'),
('Henrique Nascimento', 'Gerente', '22222222217', 'henrique.nascimento@cafeteria.com', '11991110017'),
('Luana Moreira', 'Barista', '22222222218', 'luana.moreira@cafeteria.com', '11991110018'),
('Rodrigo Castro', 'Atendente', '22222222219', 'rodrigo.castro@cafeteria.com', '11991110019'),
('Carolina Rocha', 'Caixa', '22222222220', 'carolina.rocha@cafeteria.com', '11991110020');

-- =========================================================
-- POPULAÇÃO: 20 PAGAMENTOS
-- =========================================================
INSERT INTO Pagamento
(Comanda, Valor, Forma_Pagamento, Data, Status) VALUES
(1, 12.50, 'Pix', '2026-08-01', 'Pago'),
(2, 18.00, 'Cartão', '2026-08-01', 'Pago'),
(3, 9.50, 'Dinheiro', '2026-08-02', 'Pago'),
(4, 22.00, 'Pix', '2026-08-02', 'Pago'),
(5, 15.00, 'Cartão', '2026-08-03', 'Pago'),
(6, 27.50, 'Pix', '2026-08-03', 'Pago'),
(7, 8.00, 'Dinheiro', '2026-08-04', 'Pago'),
(8, 19.00, 'Cartão', '2026-08-04', 'Pago'),
(9, 14.50, 'Pix', '2026-08-05', 'Pago'),
(10, 32.00, 'Cartão', '2026-08-05', 'Pago'),
(11, 11.00, 'Dinheiro', '2026-08-06', 'Pago'),
(12, 24.50, 'Pix', '2026-08-06', 'Pago'),
(13, 16.00, 'Cartão', '2026-08-07', 'Pago'),
(14, 13.50, 'Pix', '2026-08-07', 'Pago'),
(15, 29.00, 'Cartão', '2026-08-08', 'Pago'),
(16, 10.00, 'Dinheiro', '2026-08-08', 'Pago'),
(17, 21.50, 'Pix', '2026-08-09', 'Pago'),
(18, 17.00, 'Cartão', '2026-08-09', 'Pago'),
(19, 26.00, 'Pix', '2026-08-10', 'Pago'),
(20, 35.00, 'Cartão', '2026-08-10', 'Pago');

-- =========================================================
-- POPULAÇÃO: 20 PEDIDOS
-- =========================================================
INSERT INTO Pedido
(Comanda, Descrição, Status, Especificações, Quantidade, Cardápio, Funcionário, Pagamento) VALUES
(1, 'Café espresso', 'Finalizado', 'Sem açúcar', 1, 1, 1, 1),
(2, 'Cappuccino', 'Finalizado', 'Canela por cima', 1, 3, 2, 2),
(3, 'Pão de queijo', 'Finalizado', 'Bem assado', 2, 13, 3, 3),
(4, 'Mocha', 'Finalizado', 'Pouco açúcar', 1, 4, 4, 4),
(5, 'Latte', 'Finalizado', 'Leite integral', 1, 5, 5, 5),
(6, 'Chocolate quente', 'Finalizado', 'Sem chantilly', 2, 6, 6, 6),
(7, 'Suco de laranja', 'Finalizado', 'Sem gelo', 1, 9, 7, 7),
(8, 'Croissant', 'Finalizado', 'Aquecer', 1, 14, 8, 8),
(9, 'Cookie', 'Finalizado', 'Com gotas de chocolate', 2, 19, 9, 9),
(10, 'Bolo de chocolate', 'Finalizado', 'Fatia grande', 1, 16, 10, 10),
(11, 'Café com leite', 'Finalizado', 'Pouco açúcar', 1, 2, 11, 11),
(12, 'Torta de limão', 'Finalizado', 'Fatia média', 1, 18, 12, 12),
(13, 'Brownie', 'Finalizado', 'Aquecer', 2, 20, 13, 13),
(14, 'Chá de camomila', 'Finalizado', 'Sem açúcar', 1, 7, 14, 14),
(15, 'Sanduíche natural', 'Finalizado', 'Sem tomate', 1, 15, 15, 15),
(16, 'Bolo de cenoura', 'Finalizado', 'Com cobertura', 1, 17, 16, 16),
(17, 'Suco de morango', 'Finalizado', 'Com pouco gelo', 1, 10, 17, 17),
(18, 'Refrigerante', 'Finalizado', 'Bem gelado', 1, 12, 18, 18),
(19, 'Chá de frutas', 'Finalizado', 'Sem açúcar', 1, 8, 19, 19),
(20, 'Pão de queijo', 'Finalizado', 'Bem quente', 3, 13, 20, 20);


SELECT * FROM Cliente;
SELECT * FROM Cardápio;
SELECT * FROM Funcionários;
SELECT * FROM Pagamento;
SELECT * FROM Pedido;
SELECT	
    p.ID_pedido,
    c.Nome AS Cliente,
    car.Nome AS Produto,
    f.Nome AS Funcionario,
    pag.Valor,
    pag.Forma_Pagamento
FROM Pedido p
INNER JOIN Cliente c ON p.Comanda = c.ID_cliente
INNER JOIN Cardápio car ON p.Cardápio = car.ID_produto
INNER JOIN Funcionários f ON p.Funcionário = f.id_funcionario
INNER JOIN Pagamento pag ON p.Pagamento = pag.ID_pagamento;

 SELECT 
    c.Nome AS Cliente,
    pag.ID_pagamento,
    pag.Valor,
    pag.Forma_Pagamento
FROM Cliente c
LEFT JOIN Pagamento pag ON c.ID_cliente = pag.Comanda;
 SELECT 
    car.Nome AS Produto,
    p.ID_pedido,
    p.Quantidade
FROM Pedido p
RIGHT JOIN Cardápio car ON p.Cardápio = car.ID_produto;
 SELECT 
    c.Nome AS Cliente,
    car.Nome AS Produto
FROM Cliente c
CROSS JOIN Cardápio car;