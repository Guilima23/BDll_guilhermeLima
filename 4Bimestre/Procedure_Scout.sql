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
