/*
   TRIGGER 1: Bloqueio de Avaliação Indevida (BEFORE INSERT ON Avaliacao)
   Este trigger impede que um cliente avalie um pedido que não esteja com o status 'EN' (Entregue). Se o pedido estiver pendente, preparando, saindo ou cancelado, o trigger barra a inserção e exibe uma mensagem de erro.
*/
DELIMITER //
CREATE TRIGGER BloquearAvaliacaoIndevida
	BEFORE INSERT ON Avaliacao
	FOR EACH ROW
BEGIN
    DECLARE statusPed CHAR(2);
    
    -- busca o status atual do pedido que o usuário está tentando avaliar
    SELECT statusPedido INTO statusPed
    FROM Pedido
    WHERE idPedido = NEW.idPedido;
    
    -- se o status não for 'EN' (Entregue), barra a operação
    IF statusPed != 'EN' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Só é permitido avaliar pedidos que já foram entregues.';
    END IF;
END //
DELIMITER ;

-- Criando um pedido novo para teste
INSERT INTO Pedido(idPedido, idCliente, idEntregador, idRestaurante, dataPedido, horaPedido, statusPedido) 
VALUES (99, 5, 2, 2, '2026-06-19', '14:00:00', 'EN');

-- Teste 1: Avaliando o pedido anterior. Será permitido, pois o pedido está com status = 'EN' E não possui avaliações ainda.
INSERT INTO Avaliacao(idPedido, idCliente, nota, comentario) 
VALUES (99, 5, 5.0, 'Ótimo!');

-- Teste 2: Avaliando o pedido 3. Será bloqueado, pois o pedido está com o status 'PR' (Preparando).
INSERT INTO Avaliacao(idPedido, idCliente, nota, comentario) 
VALUES (3, 3, 1.0, 'Não recebi ainda, mas confio no restaurante :D');

-- Teste 3: Avaliando o pedido 99 novamente. Será bloqueado, pois um pedido pode ser avaliado apenas uma vez (unicidade da chave primária).
INSERT INTO Avaliacao(idPedido, idCliente, nota, comentario) 
VALUES (99, 5, 2.0, 'Esqueceram meu refrigerante.');

/*
   TRIGGER 2: Finalizador de pedido com aprovação de pagamento (AFTER UPDATE ON Pedido)
   Quando o status do pedido é alterado para 'EN' (Entregue), este trigger entra em ação nos bastidores e altera automaticamente o statusPagamento daquele pedido para 'A' (Aprovado).
*/
DELIMITER //
CREATE TRIGGER AprovarPagamentoEntregue
	AFTER UPDATE ON Pedido
	FOR EACH ROW
BEGIN
    -- verifica se o status do pedido mudou especificamente para 'EN' (Entregue)
    IF NEW.statusPedido = 'EN' AND OLD.statusPedido != 'EN' THEN
        UPDATE Pagamento
        SET statusPagamento = 'A'
        WHERE idPedido = NEW.idPedido;
    END IF;
END //
DELIMITER ;

-- Teste 1: Atualizando o pedido 4 de 'SA' para 'EN'. Será uma modificação bem sucedida.
UPDATE Pedido
SET statusPedido = 'EN'
WHERE idPedido = 4;

SELECT idPedido, statusPagamento
FROM Pagamento
WHERE idPedido = 4;

-- Teste 2: Atualizando o pedido 5 de 'PE' para 'PR'. O trigger não é ativado.
UPDATE Pedido
SET statusPedido = 'PR'
WHERE idPedido = 5;

SELECT idPedido, statusPagamento
FROM Pagamento
WHERE idPedido = 5;

/*
   TRIGGER 3: Restrição de exclusão de cupons ativos e históricos (BEFORE DELETE ON Cupom)
   Este cupom protege a integridade do negócio, impedindo que um cupom seja deletado se ainda estiver dentro do prazo de validade OU se já tiver sido utilizado em algum pedido passado (para não quebrar o histórico de relatórios financeiros).
*/
DELIMITER //
CREATE TRIGGER RestringirExclusaoCupom
	BEFORE DELETE ON Cupom
	FOR EACH ROW
BEGIN
    DECLARE usosCupom INT;
    
    -- 1. Verifica se o cupom já foi associado a algum pedido histórico
    SELECT COUNT(*) INTO usosCupom
    FROM Eh_aplicado_em
    WHERE idCupom = OLD.idCupom;
    
    -- 2. Se foi usado ou se a validade é maior/igual à data de hoje, barra a exclusão
    IF usosCupom > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este cupom já foi utilizado em pedidos do sistema e não pode ser removido.';
    ELSEIF OLD.dataValidade >= CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este cupom ainda está dentro do prazo de validade.';
    END IF;
END //
DELIMITER ;

-- Teste 1: Deleção do cupom 1 (já foi usado). Deve ser barrado.
DELETE FROM Cupom
WHERE idCupom = 1;

-- Criação de cupons para teste
INSERT INTO Cupom (nomeCupom, valorDesconto, dataCriacao, dataValidade) VALUES
('TESTE2', 5.00, '2025-06-18', '2025-07-18'), -- Cupom que nunca foi aplicado e expirado
('TESTE3', 5.00, '2026-06-18', '2026-07-18'); -- Cupom que nunca foi aplicado mas ainda está ativo

SELECT *
FROM Cupom;

-- Teste 2: Deleção do cupom 6 (TESTE2). Será bem sucedida.
DELETE FROM Cupom
WHERE idCupom = 6;

-- Teste 3: Deleção do cupom 7 (TESTE3). Deve ser barrado por ainda estar ativo.
DELETE FROM Cupom
WHERE idCupom = 7;
