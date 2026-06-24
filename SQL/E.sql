-- Exemplo 1: Tabela FoneRestaurante (Exclusão com chave composta)
-- Remove um número de telefone secundário específico cadastrado para o restaurante de ID 1 (Pizzaria Bella Napoli).
DELETE FROM FoneRestaurante 
WHERE idRestaurante = 1 AND telefone = '31988776655';

-- Exemplo 2: Tabela Classificado_em (Exclusão em tabela de relacionamento)
-- Remove o vínculo de classificação que diz que o produto de ID 6 (Batata Frita) pertence à categoria de ID 2 (Hambúrgueres).
DELETE FROM Classificado_em 
WHERE idProduto = 6 AND idCategoria = 2;
-- Exemplo 3: Tabela Avaliacao (Exclusão condicional)
-- Exclui do banco de dados todas as avaliações cuja nota registrada pelo cliente tenha sido inferior a 2.0.
DELETE FROM Avaliacao 
WHERE nota < 2.0;

-- Exemplo 4: Tabela Eh_aplicado_em (Exclusão simples)
-- Remove o vínculo de cupom de desconto que havia sido aplicado ao pedido de ID 5.
DELETE FROM Eh_aplicado_em 
WHERE idPedido = 5;

-- Exemplo 5: Tabela Composto_por (DELETE Aninhado / Subconsulta)
-- Exclui todos os itens (produtos listados) que pertencem a pedidos que foram cancelados ('CA').
DELETE FROM Composto_por 
WHERE idPedido IN (SELECT idPedido 
                  	           FROM Pedido 
                   	           WHERE statusPedido = 'CA');
