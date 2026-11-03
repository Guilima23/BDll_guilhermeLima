
DROP DATABASE IF EXISTS ScoutTatico;
CREATE DATABASE ScoutTatico;
USE ScoutTatico;

-- 1. TABELAS
CREATE TABLE Usuario (
 id_usuario INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(100) NOT NULL UNIQUE,
 senha_hash VARCHAR(255) NOT NULL,
 perfil ENUM('ADMIN','TREINADOR') NOT NULL DEFAULT 'TREINADOR',
 criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE Equipe (
 id_equipe INT AUTO_INCREMENT PRIMARY KEY,
 id_responsavel INT NOT NULL,
 nome VARCHAR(100) NOT NULL,
 categoria VARCHAR(50),
 cidade VARCHAR(100),
 data_criacao DATE,
 FOREIGN KEY (id_responsavel) REFERENCES Usuario(id_usuario)
 ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Jogador (
 id_jogador INT AUTO_INCREMENT PRIMARY KEY,
 id_equipe INT NOT NULL,
 nome VARCHAR(100) NOT NULL,
 data_nascimento DATE,
 posicao ENUM('GOLEIRO','ZAGUEIRO','LATERAL','VOLANTE','MEIO_CAMPO','PONTA','ATACANTE'),
 numero_camisa INT,
 pe_preferido ENUM('DIREITO','ESQUERDO','AMBIDESTRO'),
 ativo BOOLEAN NOT NULL DEFAULT TRUE,
 UNIQUE (id_equipe, numero_camisa),
 FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
 ON DELETE RESTRICT ON UPDATE CASCADE,
 CHECK (numero_camisa IS NULL OR numero_camisa BETWEEN 1 AND 99)
) ENGINE=InnoDB;

CREATE TABLE Partida (
 id_partida INT AUTO_INCREMENT PRIMARY KEY,
 id_equipe INT NOT NULL,
 adversario VARCHAR(100) NOT NULL,
 data_hora DATETIME NOT NULL,
 local_partida VARCHAR(100),
 competicao VARCHAR(100),
 formacao VARCHAR(20),
 gols_marcados INT NOT NULL DEFAULT 0,
 gols_sofridos INT NOT NULL DEFAULT 0,
 status ENUM('AGENDADA','EM_ANDAMENTO','FINALIZADA','CANCELADA') NOT NULL DEFAULT 'AGENDADA',
 observacoes TEXT,
 FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
 ON DELETE RESTRICT ON UPDATE CASCADE,
 CHECK (gols_marcados >= 0),
 CHECK (gols_sofridos >= 0)
) ENGINE=InnoDB;

CREATE TABLE Participacao_Partida (
 id_participacao INT AUTO_INCREMENT PRIMARY KEY,
 id_partida INT NOT NULL,
 id_jogador INT NOT NULL,
 titular BOOLEAN NOT NULL DEFAULT TRUE,
 minutos_jogados INT NOT NULL DEFAULT 0,
 posicao_utilizada VARCHAR(50),
 gols INT NOT NULL DEFAULT 0,
 assistencias INT NOT NULL DEFAULT 0,
 finalizacoes INT NOT NULL DEFAULT 0,
 finalizacoes_no_gol INT NOT NULL DEFAULT 0,
 passes_certos INT NOT NULL DEFAULT 0,
 passes_tentados INT NOT NULL DEFAULT 0,
 cartoes_amarelos INT NOT NULL DEFAULT 0,
 cartoes_vermelhos INT NOT NULL DEFAULT 0,
 UNIQUE (id_partida, id_jogador),
 FOREIGN KEY (id_partida) REFERENCES Partida(id_partida)
 ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (id_jogador) REFERENCES Jogador(id_jogador)
 ON DELETE RESTRICT ON UPDATE CASCADE,
 CHECK (minutos_jogados BETWEEN 0 AND 150),
 CHECK (finalizacoes >= 0 AND finalizacoes_no_gol BETWEEN 0 AND finalizacoes),
 CHECK (passes_certos >= 0 AND passes_tentados >= passes_certos),
 CHECK (gols >= 0 AND assistencias >= 0 AND cartoes_amarelos >= 0 AND cartoes_vermelhos >= 0)
) ENGINE=InnoDB;

CREATE TABLE Evento_Partida (
 id_evento INT AUTO_INCREMENT PRIMARY KEY,
 id_participacao INT NOT NULL,
 tipo ENUM('GOL','ASSISTENCIA','FINALIZACAO','PASSE','CARTAO_AMARELO','CARTAO_VERMELHO','DEFESA','FALTA') NOT NULL,
 minuto INT,
 posicao_x DECIMAL(5,2),
 posicao_y DECIMAL(5,2),
 descricao TEXT,
 FOREIGN KEY (id_participacao) REFERENCES Participacao_Partida(id_participacao)
 ON DELETE CASCADE ON UPDATE CASCADE,
 CHECK (minuto IS NULL OR minuto BETWEEN 0 AND 150),
 CHECK (posicao_x IS NULL OR posicao_x BETWEEN 0 AND 100),
 CHECK (posicao_y IS NULL OR posicao_y BETWEEN 0 AND 100)
) ENGINE=InnoDB;

CREATE INDEX idx_jogador_nome ON Jogador(nome);
CREATE INDEX idx_partida_data ON Partida(data_hora);
CREATE INDEX idx_partida_equipe_data ON Partida(id_equipe,data_hora);
CREATE INDEX idx_evento_tipo ON Evento_Partida(tipo);

-- 2. TRIGGERS: impedem associar jogador a partida de outra equipe.
DELIMITER //
CREATE TRIGGER validar_jogador_partida_insert
BEFORE INSERT ON Participacao_Partida
FOR EACH ROW
BEGIN
 DECLARE equipe_jogador INT;
 DECLARE equipe_partida INT;
 SELECT id_equipe INTO equipe_jogador FROM Jogador WHERE id_jogador=NEW.id_jogador;
 SELECT id_equipe INTO equipe_partida FROM Partida WHERE id_partida=NEW.id_partida;
 IF equipe_jogador IS NULL OR equipe_partida IS NULL OR equipe_jogador <> equipe_partida THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Jogador nao pertence a equipe desta partida.';
 END IF;
END //

CREATE TRIGGER validar_jogador_partida_update
BEFORE UPDATE ON Participacao_Partida
FOR EACH ROW
BEGIN
 DECLARE equipe_jogador INT;
 DECLARE equipe_partida INT;
 SELECT id_equipe INTO equipe_jogador FROM Jogador WHERE id_jogador=NEW.id_jogador;
 SELECT id_equipe INTO equipe_partida FROM Partida WHERE id_partida=NEW.id_partida;
 IF equipe_jogador IS NULL OR equipe_partida IS NULL OR equipe_jogador <> equipe_partida THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Jogador nao pertence a equipe desta partida.';
 END IF;
END //
DELIMITER ;

-- 3. PROCEDURE: cadastra participacao; em caso de erro, faz ROLLBACK.
DELIMITER //
CREATE PROCEDURE registrar_participacao(
 IN p_partida INT,
 IN p_jogador INT,
 IN p_titular BOOLEAN,
 IN p_minutos INT,
 IN p_gols INT,
 IN p_assistencias INT,
 IN p_finalizacoes INT,
 IN p_finalizacoes_gol INT,
 IN p_passes_certos INT,
 IN p_passes_tentados INT
)
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
 BEGIN
  ROLLBACK;
  RESIGNAL;
 END;
 START TRANSACTION;
 INSERT INTO Participacao_Partida
 (id_partida,id_jogador,titular,minutos_jogados,gols,assistencias,
  finalizacoes,finalizacoes_no_gol,passes_certos,passes_tentados)
 VALUES
 (p_partida,p_jogador,p_titular,p_minutos,p_gols,p_assistencias,
  p_finalizacoes,p_finalizacoes_gol,p_passes_certos,p_passes_tentados);
 COMMIT;
END //
DELIMITER ;

-- 4. DADOS FICTICIOS
INSERT INTO Usuario (nome,email,senha_hash,perfil) VALUES
('Carlos Mendes','carlos@scouttatico.com','03369874','ADMIN');

INSERT INTO Equipe (id_responsavel,nome,categoria,cidade,data_criacao) VALUES
(1,'Falcões FC','Amador','São Paulo','2020-03-15'),
(1,'Águias do Bairro','Amador','São Paulo','2021-06-20');

INSERT INTO Jogador (id_equipe,nome,posicao,numero_camisa,pe_preferido) VALUES
(1,'Lucas Ferreira','ATACANTE',9,'DIREITO'),
(1,'Gabriel Santos','PONTA',11,'ESQUERDO'),
(1,'Pedro Henrique','MEIO_CAMPO',10,'DIREITO'),
(1,'Matheus Oliveira','ZAGUEIRO',4,'DIREITO'),
(1,'Rafael Costa','GOLEIRO',1,'DIREITO'),
(2,'Bruno Almeida','ATACANTE',9,'DIREITO'),
(2,'Diego Martins','PONTA',7,'ESQUERDO'),
(2,'André Ribeiro','MEIO_CAMPO',8,'DIREITO'),
(2,'Felipe Rocha','ZAGUEIRO',3,'DIREITO'),
(2,'Vinícius Souza','GOLEIRO',1,'ESQUERDO');

INSERT INTO Partida
(id_equipe,adversario,data_hora,local_partida,competicao,formacao,gols_marcados,gols_sofridos,status)
VALUES
(1,'União FC','2025-08-10 15:00:00','Campo Municipal','Copa de Bairro','4-3-3',2,1,'FINALIZADA'),
(1,'Águias do Bairro','2025-08-17 16:00:00','Campo Municipal','Copa de Bairro','4-4-2',1,1,'FINALIZADA'),
(1,'União FC','2025-08-24 15:00:00','Campo Municipal','Copa de Bairro','4-3-3',0,0,'FINALIZADA');

INSERT INTO Participacao_Partida
(id_partida,id_jogador,titular,minutos_jogados,gols,assistencias,finalizacoes,finalizacoes_no_gol,passes_certos,passes_tentados,cartoes_amarelos)
VALUES
(1,1,TRUE,90,1,0,3,2,18,22,0),
(1,2,TRUE,90,1,0,2,1,14,18,0),
(1,3,TRUE,90,0,1,1,0,20,24,0),
(1,4,TRUE,90,0,0,0,0,25,30,1),
(1,5,TRUE,90,0,0,0,0,12,16,0),
(2,1,TRUE,90,1,0,4,2,15,20,0),
(2,2,TRUE,90,0,1,2,1,17,21,0),
(2,3,TRUE,90,0,0,2,1,28,32,0),
(2,4,TRUE,90,0,0,0,0,22,27,0),
(2,5,TRUE,90,0,0,0,0,14,18,0);

INSERT INTO Evento_Partida (id_participacao,tipo,minuto,posicao_x,posicao_y,descricao) VALUES
(1,'GOL',25,85,50,'Gol de Lucas Ferreira'),
(3,'ASSISTENCIA',25,70,55,'Assistencia de Pedro Henrique'),
(2,'GOL',67,90,30,'Gol de Gabriel Santos'),
(4,'CARTAO_AMARELO',72,50,60,'Cartao amarelo para Matheus Oliveira'),
(5,'DEFESA',81,5,60,'Defesa de Rafael Costa'),
(6,'GOL',38,88,48,'Gol de Lucas Ferreira'),
(7,'ASSISTENCIA',38,75,40,'Assistencia de Gabriel Santos'),
(8,'FINALIZACAO',62,78,52,'Finalizacao de Pedro Henrique');

-- Exemplo de uso da procedure na terceira partida.
CALL registrar_participacao(3,1,TRUE,90,0,0,2,1,20,25);

-- 5. EXEMPLOS OPCIONAIS DE TRANSACAO
-- Descomente e execute separadamente para testar.
 START TRANSACTION;
 UPDATE Participacao_Partida SET gols=5 WHERE id_participacao=1;
 ROLLBACK;



-- 6. CONSULTAS
-- Jogadores e equipes
SELECT J.nome AS jogador,J.posicao,J.numero_camisa,E.nome AS equipe
FROM Jogador J INNER JOIN Equipe E ON J.id_equipe=E.id_equipe
ORDER BY E.nome,J.numero_camisa;

-- Historico das partidas
SELECT E.nome AS equipe,P.adversario,P.gols_marcados,P.gols_sofridos,
       P.formacao,P.data_hora,P.status
FROM Partida P INNER JOIN Equipe E ON P.id_equipe=E.id_equipe
ORDER BY P.data_hora;

-- Artilharia
SELECT J.nome AS jogador,SUM(PP.gols) AS total_gols
FROM Jogador J INNER JOIN Participacao_Partida PP ON J.id_jogador=PP.id_jogador
GROUP BY J.id_jogador,J.nome
ORDER BY total_gols DESC,J.nome;

-- Desempenho das equipes
SELECT E.nome AS equipe,COUNT(P.id_partida) AS partidas,
       SUM(P.gols_marcados) AS gols_marcados,
       SUM(P.gols_sofridos) AS gols_sofridos,
       SUM(CASE
           WHEN P.gols_marcados>P.gols_sofridos THEN 3
           WHEN P.gols_marcados=P.gols_sofridos THEN 1
           ELSE 0
       END) AS pontos
FROM Equipe E INNER JOIN Partida P ON E.id_equipe=P.id_equipe
WHERE P.status='FINALIZADA'
GROUP BY E.id_equipe,E.nome;

-- Precisao de passes
SELECT J.nome AS jogador,SUM(PP.passes_certos) AS passes_certos,
       SUM(PP.passes_tentados) AS passes_tentados,
       ROUND(SUM(PP.passes_certos)/NULLIF(SUM(PP.passes_tentados),0)*100,2)
       AS precisao_passes
FROM Jogador J INNER JOIN Participacao_Partida PP ON J.id_jogador=PP.id_jogador
GROUP BY J.id_jogador,J.nome
ORDER BY precisao_passes DESC;

-- Eventos registrados
SELECT J.nome AS jogador,EP.tipo,EP.minuto,EP.descricao
FROM Evento_Partida EP
INNER JOIN Participacao_Partida PP ON EP.id_participacao=PP.id_participacao
INNER JOIN Jogador J ON PP.id_jogador=J.id_jogador
ORDER BY EP.minuto,EP.id_evento;
