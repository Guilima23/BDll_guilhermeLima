-- =========================================================================
-- ARQUIVO: triggers.sql
-- Descrição: Triggers para validação e integridade de dados do ScoutTatico
-- =========================================================================

DELIMITER //

-- Trigger 1: Impede associar jogador a partida de outra equipe em INSERT
CREATE TRIGGER validar_jogador_partida_insert
BEFORE INSERT ON Participacao_Partida
FOR EACH ROW
BEGIN
 DECLARE equipe_jogador INT;
 DECLARE equipe_partida INT;
 
 SELECT id_equipe INTO equipe_jogador FROM Jogador WHERE id_jogador = NEW.id_jogador;
 SELECT id_equipe INTO equipe_partida FROM Partida WHERE id_partida = NEW.id_partida;
 
 IF equipe_jogador IS NULL OR equipe_partida IS NULL OR equipe_jogador <> equipe_partida THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Jogador não pertence à equipe desta partida.';
 END IF;
END //

-- Trigger 2: Impede associar jogador a partida de outra equipe em UPDATE
CREATE TRIGGER validar_jogador_partida_update
BEFORE UPDATE ON Participacao_Partida
FOR EACH ROW
BEGIN
 DECLARE equipe_jogador INT;
 DECLARE equipe_partida INT;
 
 SELECT id_equipe INTO equipe_jogador FROM Jogador WHERE id_jogador = NEW.id_jogador;
 SELECT id_equipe INTO equipe_partida FROM Partida WHERE id_partida = NEW.id_partida;
 
 IF equipe_jogador IS NULL OR equipe_partida IS NULL OR equipe_jogador <> equipe_partida THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: Jogador não pertence à equipe desta partida.';
 END IF;
END //

DELIMITER ;

-- -------------------------------------------------------------------------
-- Exemplo Prático de Aplicação e Teste da Trigger:
-- -------------------------------------------------------------------------
-- O Jogador ID 6 pertence à equipe ID 2 ('Águias do Bairro').
-- A Partida ID 1 pertence à equipe ID 1 ('Falcões FC').
-- O comando abaixo tentará associar incorretamente e disparará o erro (SIGNAL 45000):
-- 
-- INSERT INTO Participacao_Partida (id_partida, id_jogador, titular, minutos_jogados) 
-- VALUES (1, 6, TRUE, 90);
