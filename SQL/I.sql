/*
   PROCEDIMENTO 1: ConsultarEntregadoresDisponiveis
   Este procedimento analisa o status dos pedidos e retorna uma tabela com todos os entregadores livres no momento (não estão em rota 'SA').
*/
DELIMITER //
CREATE PROCEDURE ConsultarEntregadoresDisponiveis()
BEGIN
    SELECT idEntregador, nomeEntregador, foneEntregador
    FROM Entregador
    WHERE idEntregador NOT IN (SELECT DISTINCT idEntregador 
				       FROM Pedido 
				       WHERE statusPedido = 'SA')
    ORDER BY idEntregador;
END //
DELIMITER ;

-- Consultando a fila de entregadores disponíveis
CALL ConsultarEntregadoresDisponiveis();
-- Simulando que o entregador 1 saiu para entregar o pedido 5
UPDATE Pedido
SET statusPedido = 'SA', idEntregador = 1
WHERE idPedido = 5;

-- Chamando a procedure de novo
CALL ConsultarEntregadoresDisponiveis();

/*
   PROCEDIMENTO 2: CalcularValorTotalPedido
   Este procedimento recebe o idPedido e calcula seu valor total final, após os descontos de cupons.
*/
DELIMITER //
CREATE PROCEDURE CalcularValorTotalPedido(IN idPedidoP INT,
						     OUT valorTotalFinal DECIMAL(5,2))
BEGIN
    DECLARE subtotal DECIMAL(5,2);
    DECLARE desconto DECIMAL(5,2);
    
    SELECT SUM(quantidadeProduto * precoPedido) INTO subtotal
    FROM Composto_por
    WHERE idPedido = idPedidoP;
    
    -- se o pedido não tiver produtos, o SUM retorna NULL. Por isso, temos que fazer o tratamento:
    IF subtotal IS NULL THEN
        SET subtotal = 0.00;
    END IF;
    
    SELECT valorDesconto INTO desconto
    FROM Cupom NATURAL JOIN Eh_aplicado_em
    WHERE idPedido = idPedidoP;
    
    -- se não houver cupom aplicado, o SELECT retorna NULL. Por isso, temos que fazer o tratamento:
    IF desconto IS NULL THEN
	SET desconto = 0;
    END IF;
    
    SET valorTotalFinal = subtotal - desconto;
END //
DELIMITER ;

-- Teste 1: Chamando o procedure para o pedido 6 (1 Pizza de Frango Catupiry (47.00) e sem cupom aplicado)
CALL CalcularValorTotalPedido(6, @total_p6);
SELECT @total_p6 AS valorFinalTotal;

-- Teste 2: Chamando o procedure para o pedido 1 (2 Pizzas Calabresa (2 x 45.90 = 91.80) e com o cupom 'PROMO10' (10.00 de desconto))
CALL CalcularValorTotalPedido(1, @total_p1);
SELECT @total_p1 AS valorFinalTotal;

/* 
   PROCEDIMENTO 3: ObterMetricasRestaurante
   Este procedimento recebe o idRestaurante e retorna, via parâmetros de saída, a quantidade de pedidos cancelados, a quantidade de pedidos entregues, a média das notas das avaliações, a taxa de sucesso dos pedidos e uma classificação com base nos dois últimos parâmetros.
*/
DELIMITER //
CREATE PROCEDURE ObterMetricasRestaurante(IN idRestauranteP INT,
						     OUT qtdePedidosCancelados INT,
                                          			     OUT qtdePedidosEntregues INT,
                                          			     OUT mediaAvaliacoes DECIMAL(2,1),
                                          			     OUT taxaSucesso DECIMAL(5,2),
                                          			     OUT classificacao VARCHAR(20))
BEGIN
    DECLARE totalPedidos INT;
    
    -- conta os pedidos cancelados
    SELECT COUNT(*) INTO qtdePedidosCancelados
    FROM Pedido
    WHERE idRestaurante = idRestauranteP AND statusPedido = 'CA';
    
    -- conta os pedidos entregues
    SELECT COUNT(*) INTO qtdePedidosEntregues
    FROM Pedido
    WHERE idRestaurante = idRestauranteP AND statusPedido = 'EN';
    
    -- calcula o total de pedidos processados e a taxa de sucesso
    SET totalPedidos = qtdePedidosEntregues + qtdePedidosCancelados;
    
    IF totalPedidos > 0 THEN
        SET taxaSucesso = (qtdePedidosEntregues / totalPedidos) * 100;
    ELSE
        SET taxaSucesso = 0.00;
    END IF;
    
    -- calcula a média de notas das avaliações
    SELECT AVG(A.nota) INTO mediaAvaliacoes
    FROM Avaliacao A
		JOIN Pedido P
			ON A.idPedido = P.idPedido
    WHERE P.idRestaurante = idRestauranteP;
    
    -- trata o valor da média caso o restaurante ainda não possua nenhuma avaliação
    IF mediaAvaliacoes IS NULL THEN
    SET mediaAvaliacoes = 0.0;
    END IF;
    
    SET classificacao = CASE 
        WHEN totalPedidos = 0 THEN 'Sem histórico de pedidos'
        WHEN mediaAvaliacoes = 0.0 THEN 'Sem avaliações'
        WHEN mediaAvaliacoes >= 4.5 AND taxaSucesso >= 80.00 THEN 'Excelente'
        WHEN mediaAvaliacoes >= 4.0 AND taxaSucesso >= 70.00 THEN 'Muito Bom'
        WHEN mediaAvaliacoes >= 3.0 AND taxaSucesso >= 50.00 THEN 'Regular'
        
        -- se não se encaixar em nenhuma das faixas acima (ex: nota alta, mas muito cancelamento)
        ELSE 'Alerta'
    END;
END //
DELIMITER ;

-- Teste 1: Restaurante 1, com alta taxa de sucesso
CALL ObterMetricasRestaurante(1, @cancelados_r1, @entregues_r1, @media_r1, @taxa_r1, @class_r1);
SELECT @cancelados_r1 AS 'Cancelados',
	   @entregues_r1 AS 'Entregues',
       	   @media_r1 AS 'Média',
       	   CONCAT(@taxa_r1, '%') AS 'TaxaSucesso',
       	   @class_r1 AS 'Classificação';

-- Teste 2: Restaurante 3, que teve metade dos pedidos cancelados
CALL ObterMetricasRestaurante(3, @cancelados_r3, @entregues_r3, @media_r3, @taxa_r3, @class_r3);
SELECT @cancelados_r3 AS 'Cancelados',
	   @entregues_r3 AS 'Entregues',
       	   @media_r3 AS 'Média',
       	   CONCAT(@taxa_r3, '%') AS 'TaxaSucesso',
      	   @class_r3 AS 'Classificação';
